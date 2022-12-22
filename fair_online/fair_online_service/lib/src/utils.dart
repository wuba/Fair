import 'dart:io';

import 'package:path/path.dart' as path;
import 'dart:convert' show jsonDecode, utf8;

/// Normalizes any "paths" from [text], replacing the segments before the last
/// separator with either "dart:core" or "package:flutter", or removes them,
/// according to their content.
///
/// ## Examples:
///
/// "Unused import: '/path/foo.dart'" -> "Unused import: 'foo.dart'"
///
/// "Unused import: '/path/to/dart/lib/core/world.dart'" ->
/// "Unused import: 'dart:core/world.dart'"
///
/// "Unused import: 'package:flutter/material.dart'" ->
/// "Unused import: 'package:flutter/material.dart'"
String normalizeFilePaths(String text) {
  return text.replaceAllMapped(_possiblePathPattern, (match) {
    final possiblePath = match.group(0)!;

    final uri = Uri.tryParse(possiblePath);
    if (uri != null && uri.hasScheme) {
      return possiblePath;
    }

    final pathComponents = path.split(possiblePath);
    final basename = path.basename(possiblePath);

    if (pathComponents.contains('flutter')) {
      return path.join('package:flutter', basename);
    }

    if (pathComponents.contains('lib') && pathComponents.contains('core')) {
      return path.join('dart:core', basename);
    }

    return basename;
  });
}

Future<Process> runWithLogging(
  String executable, {
  List<String> arguments = const [],
  String? workingDirectory,
  Map<String, String> environment = const {},
  required void Function(String) log,
}) async {
  log([
    'Running $executable ${arguments.join(' ')}',
    if (workingDirectory != null) "from directory: '$workingDirectory'",
    if (environment.isNotEmpty) 'with additional environment: $environment',
  ].join('\n  '));

  final process = await Process.start(executable, arguments,
      workingDirectory: workingDirectory,
      environment: environment,
      includeParentEnvironment: true,
      runInShell: Platform.isWindows);
  process.stdout.listen((out) => log(systemEncoding.decode(out)));
  process.stderr.listen((err) => log(systemEncoding.decode(err)));
  return process;
}

/// A pattern which matches a possible path.
///
/// This pattern is essentially "possibly some letters and colons, followed by a
/// slash, followed by non-whitespace."
final _possiblePathPattern = RegExp(r'[a-zA-Z:]*\/\S*');

/// Perform a git clone, logging the command and any output, and throwing an
/// exception if there are any issues with the clone.
Future<void> clone(List<String> args, {required String cwd}) async {
  final result = await _execLog('git', ['clone', ...args], cwd);
  if (result != 0) {
    throw 'result from git clone: $result';
  }
}

Future<void> git(List<String> args, {required String cwd}) async {
  final result = await _execLog('git', args, cwd);
  if (result != 0) {
    throw 'result from git: $result';
  }
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

/// Copies all of the files in the [from] directory to [to].
///
/// This is similar to `cp -R <from> <to>`:
/// * Symlinks are supported.
/// * Existing files are over-written, if any.
/// * If [to] is within [from], throws [ArgumentError] (an infinite operation).
/// * If [from] and [to] are canonically the same, no operation occurs.
///
/// Returns a future that completes when complete.
Future<void> copyPath(String from, String to) async {
  if (_doNothing(from, to)) {
    return;
  }
  await Directory(to).create(recursive: true);
  await for (final file in Directory(from).list(recursive: true)) {
    final copyTo = path.join(to, path.relative(file.path, from: from));
    if (file is Directory) {
      await Directory(copyTo).create(recursive: true);
    } else if (file is File) {
      await File(file.path).copy(copyTo);
    } else if (file is Link) {
      await Link(copyTo).create(await file.target(), recursive: true);
    }
  }
}

bool _doNothing(String from, String to) {
  if (path.canonicalize(from) == path.canonicalize(to)) {
    return true;
  }
  if (path.isWithin(from, to)) {
    throw ArgumentError('Cannot copy from $from to $to');
  }
  return false;
}
typedef LogFunction = void Function(String);

/// Parses [dependenciesFile] as a JSON Map of Strings.
Map<String, String> parsePubDependenciesFile(
    {required File dependenciesFile}) {
  final packageVersions =
  jsonDecode(dependenciesFile.readAsStringSync()) as Map;
  return packageVersions.cast<String, String>();
}

/// Build a return a `pubspec.yaml` file.
String createPubspec({
  required bool includeFlutterWeb,
  required String dartLanguageVersion,
  Map<String, String> dependencies = const {},
}) {
  var content = '''
name: dartpad_sample
environment:
  sdk: '>=$dartLanguageVersion <3.0.0'
dependencies:
''';

  if (includeFlutterWeb) {
    content += '''
  flutter:
    sdk: flutter
  flutter_test:
    sdk: flutter
''';
  }
  dependencies.forEach((name, version) {
    content += '  $name: $version\n';
  });

  return content;
}

Future<void> runFlutterPackagesGet(
    String flutterToolPath,
    String projectPath, {
      required LogFunction log,
    }) async {
  final process = await runWithLogging(flutterToolPath,
      arguments: ['packages', 'get'],
      workingDirectory: projectPath,
      environment: {'PUB_CACHE': _pubCachePath},
      log: log);
  await process.exitCode;
}

/// Builds the local pub cache directory and returns the path.
String get _pubCachePath {
  final pubCachePath = path.join(Directory.current.path, 'local_pub_cache');
  Directory(pubCachePath).createSync();
  return pubCachePath;
}