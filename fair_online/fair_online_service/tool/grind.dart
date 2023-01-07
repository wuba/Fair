library services.grind;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:fair_online_service/src/sdk.dart';
import 'package:fair_online_service/src/utils.dart';
import 'package:grinder/grinder.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as path;

Future<void> main(List<String> args) async {
  return grind(args);
}

@Task('Make sure SDKs are appropriately initialized')
@Depends(setupFlutterSdk)
void sdkInit() {}

@Task()
@Depends(buildStorageArtifacts)
Future<void> serve() async {
  await _run(Platform.executable, arguments: [
    path.join('bin', 'server.dart'),
    '--version',
    _version,
    '--port',
    '8082',
  ]);
}

@Task()
@Depends(buildStorageArtifacts)
Future<void> serveNullSafety() async {
  await _run(Platform.executable, arguments: [
    path.join('bin', 'server.dart'),
    '--version',
    _version,
    '--port',
    '8084',
    '--null-safety',
  ]);
}

/// Returns the Flutter channel provided in environment variables.
late final String _version = () {
  final version = Platform.environment['FLUTTER_VERSION'];
  if (version == null) {
    throw StateError('Must provide FLUTTER_VERSION');
  }
  return version;
}();

/// Returns the appropriate SDK for the given Flutter channel.
///
/// The Flutter SDK directory must be already created by [sdkInit].
Sdk _getSdk() => Sdk.create(_version);

final List<String> compilationArtifacts = [
  'dart_sdk.js',
  'flutter_web.js',
];

@Task('build the sdk compilation artifacts for upload to google storage')
@Depends(sdkInit, setupFairSdk, setupPreviewPlugin)
void buildStorageArtifacts() async {
  final sdk = _getSdk();
  delete(getDir('artifacts'));
  final instructions = <String>[];

  // build and copy dart_sdk.js, flutter_web.js, and flutter_web.dill
  final temp = Directory.systemTemp.createTempSync('flutter_web_sample');

  try {
    instructions
        .add(await _buildStorageArtifacts(temp, sdk, v: _version));
  } finally {
    temp.deleteSync(recursive: true);
  }

  log('\nFrom the fair_online_service project root dir, run:');
  for (final instruction in instructions) {
    log(instruction);
  }
}

Future<String> _buildStorageArtifacts(Directory dir, Sdk sdk,
    {required String v}) async {
  final dependenciesFile = _pubDependenciesFile(version: v);
  final pubspec = createPubspec(
    includeFlutterWeb: true,
    dartLanguageVersion: readDartLanguageVersion(_version),
    dependencies: parsePubDependenciesFile(dependenciesFile: dependenciesFile),
  );
  joinFile(dir, ['pubspec.yaml']).writeAsStringSync(pubspec);

  await runFlutterPackagesGet(sdk.flutterToolPath, dir.path, log: log);

  // locate the artifacts
  final flutterPackages = ['flutter', 'flutter_test'];

  final flutterLibraries = <String>[];
  final config = await findPackageConfig(dir);
  if (config == null) {
    throw FileSystemException('package config not found', dir.toString());
  }
  for (final package in config.packages) {
    if (flutterPackages.contains(package.name)) {
      // This is a package we're interested in - add all the public libraries to
      // the list.
      final libPath = package.packageUriRoot.toFilePath();
      for (final entity in getDir(libPath).listSync()) {
        if (entity is File && entity.path.endsWith('.dart')) {
          flutterLibraries.add('package:${package.name}/${fileName(entity)}');
        }
      }
    }
  }

  // Make sure flutter-sdk/bin/cache/flutter_web_sdk/flutter_web_sdk/kernel/flutter_ddc_sdk.dill
  // is installed.
  await _run(
    sdk.flutterToolPath,
    arguments: ['precache', '--web'],
    workingDirectory: dir.path,
  );

  // Build the artifacts using DDC:
  // dart-sdk/bin/dartdevc -s kernel/flutter_ddc_sdk.dill
  //     --modules=amd package:flutter/animation.dart ...
  bool over330 = compareVersion(sdk.flutterVersion, "3.3.0");
  final compilerPath = path.join(sdk.dartSdkPath, 'bin', over330 ? 'dart' : 'dartdevc');
  final dillPath = path.join(
    sdk.flutterWebSdkPath,
    'flutter_ddc_sdk_sound.dill',
  );
  final args = <String>[
    if(over330)...[
      path.join(sdk.dartSdkPath, 'bin', 'snapshots', 'dartdevc.dart.snapshot'),
    ],
    '-s',
    dillPath,
    '--sound-null-safety',
    '--modules=amd',
    '--source-map',
    '-o',
    'flutter_web.js',
    ...flutterLibraries
  ];

  await _run(
    compilerPath,
    arguments: args,
    workingDirectory: dir.path,
  );

  // Copy both to the project directory.
  final artifactsDir = getDir(path.join('artifacts'));
  artifactsDir.createSync(recursive: true);

  final sdkJsPath =
      path.join(sdk.flutterWebSdkPath, 'amd-canvaskit-html-sound/dart_sdk.js');

  copy(getFile(sdkJsPath), artifactsDir);
  copy(getFile('$sdkJsPath.map'), artifactsDir);
  copy(joinFile(dir, ['flutter_web.js']), artifactsDir);
  copy(joinFile(dir, ['flutter_web.js.map']), artifactsDir);
  copy(joinFile(dir, ['flutter_web.dill']), artifactsDir);

  // Emit some good Google Storage upload instructions.
  final version = sdk.versionFull;
  return ('  gsutil -h "Cache-Control: public, max-age=604800, immutable" cp -z js ${artifactsDir.path}/*.js*'
      ' gs://nnbd_artifacts/$version/');
}

@Task('Reinitialize the Flutter submodule.')
void setupFlutterSdk() async {
  print('setup-flutter-sdk version: $_version');

  // Download the SDK into ./flutter-sdks/
  final sdkManager = DownloadingSdkManager(_version);
  print('Flutter version: ${sdkManager.flutterVersion}');
  final flutterSdkPath = await sdkManager.createFromConfigFile();

  // Set up the Flutter SDK the way dart-services needs it.
  final flutterBinFlutter = path.join(flutterSdkPath, 'bin', 'flutter');
  await _run(
    flutterBinFlutter,
    arguments: ['doctor'],
  );

  await _run(
    flutterBinFlutter,
    arguments: ['config', '--enable-web'],
  );

  await _run(
    flutterBinFlutter,
    arguments: [
      'precache',
      '--web',
      '--no-android',
      '--no-ios',
      '--no-linux',
      '--no-windows',
      '--no-macos',
      '--no-fuchsia',
    ],
  );
}

@Task()
void fuzz() {
  log('warning: fuzz testing is a noop, see #301');
}

@Task()
@Depends(generateProtos, fuzz, buildStorageArtifacts)
void buildbot() {}

@Task('Generate Protobuf classes')
void generateProtos() async {
  try {
    await _run(
      'protoc',
      arguments: ['--dart_out=lib/src', 'protos/dart_services.proto'],
    );
  } catch (e) {
    print('Error running "protoc"; make sure the Protocol Buffer compiler is '
        'installed (see README.md)');
  }

  // reformat generated classes so travis dart format test doesn't fail
  await _run(
    'dart',
    arguments: ['format', '--fix', 'lib/src/protos'],
  );

  // And reformat again, for $REASONS
  await _run(
    'dart',
    arguments: ['format', '--fix', 'lib/src/protos'],
  );

  // generate common_server_proto.g.dart
  Pub.run('build_runner', arguments: ['build', '--delete-conflicting-outputs']);
}

Future<void> _run(
  String executable, {
  List<String> arguments = const [],
  String? workingDirectory,
  Map<String, String> environment = const {},
}) async {
  final process = await runWithLogging(executable,
      arguments: arguments,
      workingDirectory: workingDirectory,
      environment: environment,
      log: log);
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    fail('Unable to exec $executable, failed with code $exitCode');
  }
}

@Task('Update pubspec dependency versions')
@Depends(sdkInit)

/// Returns the File containing the pub dependencies and their version numbers.
///
/// The file is at `tool/pub_dependencies_{version}.json`, for the Flutter
File _pubDependenciesFile({required String version}) {
  final versionsFileName = 'pub_dependencies_$version.json';
  return File(path.join(Directory.current.path, 'tool', versionsFileName));
}

@Task('Download Fair SDK.')
void setupFairSdk() async {
  print('Download Fair SDK');
  var fairSdkPath = path.join('fairDir', 'fair');
  var dir = Directory(fairSdkPath);
  if (!dir.existsSync()) {
    await clone(
      [
        '--depth',
        '1',
        '--no-single-branch',
        '--branch',
        'main',
        'git@github.com:wuba/fair.git',
        fairSdkPath,
      ],
      cwd: Directory.current.path,
    );
  } else {
    await git(
      [
        'pull',
        '--force',
      ],
      cwd: fairSdkPath,
    );
  }
}

@Task('Download Preview Plugin.')
void setupPreviewPlugin() async {
  print('Download Preview Plugin');
  var previewPath = path.join('fairDir', 'flutter_device_preview');
  var dir = Directory(previewPath);
  if (!dir.existsSync()) {
    await clone(
      [
        '--depth',
        '1',
        '--no-single-branch',
        '--branch',
        'dev_wanbing_3.0',
        'git@github.com:wanbing/flutter_device_preview.git',
        previewPath,
      ],
      cwd: Directory.current.path,
    );
  } else {
    await git(
      [
        'pull',
        '--force',
      ],
      cwd: previewPath,
    );
  }
}

bool compareVersion(curV, reqV) {
  if (curV != null && reqV != null) {
    var arr1 = curV.split('.'),
        arr2 = reqV.split('.');
    int arr1Len = arr1.length;
    int arr2Len = arr2.length;
    int minLength = min(arr1Len, arr2Len),
        position = 0,
        diff = 0;
    while (position < minLength &&
        ((diff = int.parse(arr1[position]) - int.parse(arr2[position])) == 0)) {
      position++;
    }
    diff = (diff != 0) ? diff : (arr1.length - arr2.length);
    return diff >= 0;
  } else {
    print("版本号不能为空");
    return false;
  }
}