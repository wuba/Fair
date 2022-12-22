import 'dart:async';
import 'dart:convert' show utf8;
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

class Sdk {
  static Sdk? _instance;

  final String sdkPath;

  /// The path to the Flutter binaries.
  final String _flutterBinPath;

  /// The path to the Dart SDK.
  final String dartSdkPath;

  /// The current version of the SDK, including any `-dev` suffix.
  final String versionFull;

  final String flutterVersion;

  /// The current version of the SDK, not including any `-dev` suffix.
  final String version;

  factory Sdk.create(String version) {
    final sdkPath = path.join(Sdk._flutterSdksPath, version);
    final flutterBinPath = path.join(sdkPath, 'bin');
    final dartSdkPath = path.join(flutterBinPath, 'cache', 'dart-sdk');
    return _instance ??= Sdk._(
      sdkPath: sdkPath,
      flutterBinPath: flutterBinPath,
      dartSdkPath: dartSdkPath,
      versionFull: _readVersionFile(dartSdkPath),
      flutterVersion: _readVersionFile(sdkPath),
    );
  }

  Sdk._({
    required this.sdkPath,
    required String flutterBinPath,
    required this.dartSdkPath,
    required this.versionFull,
    required this.flutterVersion,
  })  : _flutterBinPath = flutterBinPath,
        version = versionFull.contains('-')
            ? versionFull.substring(0, versionFull.indexOf('-'))
            : versionFull;

  /// The path to the 'flutter' tool (binary).
  String get flutterToolPath => path.join(_flutterBinPath, 'flutter');

  String get flutterWebSdkPath => path.join(
      _flutterBinPath, 'cache', 'flutter_web_sdk', 'flutter_web_sdk', 'kernel');

  static String _readVersionFile(String filePath) =>
      (File(path.join(filePath, 'version')).readAsStringSync()).trim();

  /// Get the path to the Flutter SDKs.
  static String get _flutterSdksPath =>
      path.join(Directory.current.path, 'flutter-sdks');
}

const versions = ['2.5.0', '3.0.0', '3.3.0'];

class DownloadingSdkManager {
  final String version;
  final String flutterVersion;

  DownloadingSdkManager._(this.version, this.flutterVersion);

  factory DownloadingSdkManager(String version) {
    if (!versions.contains(version)) {
      throw StateError('Unknown version: $version');
    }
    final flutterVersion =
        _readVersionMap(version)['flutter_version'] as String;
    return DownloadingSdkManager._(version, flutterVersion);
  }

  /// Creates a Flutter SDK in `flutter-sdks/` that is configured using the
  /// `flutter-sdk-version.yaml` file.
  ///
  /// Note that this is an expensive operation.
  Future<String> createFromConfigFile() async {
    final sdk = await _cloneSdkIfNecessary(version);

    // git checkout master
    await sdk.checkout('master');
    // git fetch --tags
    await sdk.fetchTags();
    // git checkout 1.25.0-8.1.pre
    await sdk.checkout(flutterVersion);

    // Force downloading of Dart SDK before constructing the Sdk singleton.
    final exitCode = await sdk.init();
    if (exitCode != 0) {
      throw StateError('Initializing Flutter SDK resulted in error: $exitCode');
    }

    return sdk.flutterSdkPath;
  }

  Future<_DownloadedFlutterSdk> _cloneSdkIfNecessary(String version) async {
    final sdkPath = path.join(Sdk._flutterSdksPath, version);
    final sdk = _DownloadedFlutterSdk(sdkPath);

    if (!Directory(sdk.flutterSdkPath).existsSync()) {
      // This takes perhaps ~20 seconds.
      await sdk.clone(
        [
          '--depth',
          '1',
          '--no-single-branch',
          'git@github.com:flutter/flutter.git',
          sdk.flutterSdkPath,
        ],
        cwd: Directory.current.path,
      );
    }

    return sdk;
  }
}

String readDartLanguageVersion(String channelName) =>
    _readVersionMap(channelName)['dart_language_version'] as String;

/// Read and return the Flutter SDK configuration file info
/// (`flutter-sdk-version.yaml`).
Map<String, Object> _readVersionMap(String channelName) {
  final file = File(path.join(Directory.current.path, _flutterSdkConfigFile));
  final sdkConfig =
      (loadYaml(file.readAsStringSync()) as Map).cast<String, Object>();

  if (!sdkConfig.containsKey('flutter_sdk')) {
    throw StateError("No key 'flutter_sdk' found in '$_flutterSdkConfigFile'");
  }
  final flutterConfig = sdkConfig['flutter_sdk'] as Map;
  if (!flutterConfig.containsKey(channelName)) {
    throw StateError("No key '$channelName' found in '$_flutterSdkConfigFile'");
  }
  final channelConfig = flutterConfig[channelName] as Map;
  if (!channelConfig.containsKey('flutter_version')) {
    throw StateError(
        "No key 'flutter_version' found in '$_flutterSdkConfigFile'");
  }
  if (!channelConfig.containsKey('dart_language_version')) {
    throw StateError(
        "No key 'dart_language_version' found in '$_flutterSdkConfigFile'");
  }
  return channelConfig.cast<String, Object>();
}

const String _flutterSdkConfigFile = 'flutter-sdk-version.yaml';

class _DownloadedFlutterSdk {
  final String flutterSdkPath;

  _DownloadedFlutterSdk(this.flutterSdkPath);

  Future<int> init() =>
      // `flutter --version` takes ~28s.
      _execLog(path.join('bin', 'flutter'), ['--version'], flutterSdkPath);

  String get sdkPath => path.join(flutterSdkPath, 'bin', 'cache', 'dart-sdk');

  String get versionFull =>
      File(path.join(sdkPath, 'version')).readAsStringSync().trim();

  String get flutterVersion =>
      File(path.join(flutterSdkPath, 'version')).readAsStringSync().trim();

  /// Perform a git clone, logging the command and any output, and throwing an
  /// exception if there are any issues with the clone.
  Future<void> clone(List<String> args, {required String cwd}) async {
    final result = await _execLog('git', ['clone', ...args], cwd);
    if (result != 0) {
      throw 'result from git clone: $result';
    }
  }

  Future<void> checkout(String branch) async {
    final result = await _execLog('git', ['checkout', branch], flutterSdkPath);
    if (result != 0) {
      throw 'result from git checkout: $result';
    }
  }

  Future<void> fetchTags() async {
    final result = await _execLog('git', ['fetch', '--tags'], flutterSdkPath);
    if (result != 0) {
      throw 'result from git fetch: $result';
    }
  }

  Future<void> pull() async {
    final result = await _execLog('git', ['pull'], flutterSdkPath);
    if (result != 0) {
      throw 'result from git pull: $result';
    }
  }

  Future<bool> checkChannelAvailableLocally(String channel) async {
    // git show-ref --verify --quiet refs/heads/beta
    final result = await _execLog(
      'git',
      [
        'show-ref',
        '--verify',
        '--quiet',
        'refs/heads/$channel',
      ],
      flutterSdkPath,
    );

    return result == 0;
  }

  Future<int> _execLog(
      String executable, List<String> arguments, String cwd) async {
    print('$executable ${arguments.join(' ')}');

    final process = await Process.start(
      executable,
      arguments,
      workingDirectory: cwd,
    );
    process.stdout
        .transform<String>(utf8.decoder)
        .listen((string) => stdout.write(string));
    process.stderr
        .transform<String>(utf8.decoder)
        .listen((string) => stderr.write(string));

    return await process.exitCode;
  }
}
