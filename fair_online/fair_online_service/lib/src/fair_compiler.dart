/// This library is a wrapper around the Dart to Fair DSL compiler.
library services.compiler;

import 'dart:async';
import 'dart:io';

import 'package:fair_online_service/src/code/fair_compile_code.dart';
import 'package:fair_online_service/src/common.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:path/path.dart';

import 'compiler.dart';
import 'sdk.dart';

Logger _logger = Logger('fair_compiler');

class FairCompiler {
  final Sdk _sdk;

  FairCompiler(Sdk sdk) : this._(sdk);

  FairCompiler._(this._sdk);

  Future<FairCompilationResults> compile(
      String input, String userId, String projectName) async {
    try {
      final projectDirectory = path.join(Directory.current.path, 'fairDir',
          'userProject', userId, projectName);

      final result = await Process.run(
          _sdk.flutterToolPath,
          [
            'packages',
            'pub',
            'run',
            'build_runner',
            'build',
            '--delete-conflicting-outputs'
          ],
          workingDirectory: projectDirectory);
      if (result.exitCode != 0) {
        return FairCompilationResults.failed(
            [CompilationProblem(result.stdout as String)]);
      } else {
        /// copy bundle to assets
        final fairDslDirPath = path.join(projectDirectory, 'build', 'fair');
        final assetDirPath = path.join(projectDirectory, 'assets', 'fair');
        var assetDir = Directory(assetDirPath);
        if (!assetDir.existsSync()) {
          assetDir.createSync(recursive: true);
        }
        var fairDslDir = Directory(fairDslDirPath);
        if (fairDslDir.existsSync()) {
          fairDslDir.listSync().forEach((element) {
            String path = element.path;
            var ext = extension(path);
            if ((element is File) && (ext == '.json' || ext == '.js')) {
              final copyTo =
                  join(assetDirPath, relative(path, from: fairDslDirPath));
              File(path).copySync(copyTo);
            }
          });
        }

        /// generate fair preview page
        final fairPreviewPath =
            path.join(projectDirectory, 'lib', 'fair_preview.dart');
        await File(fairPreviewPath)
            .writeAsString(kFairCompileCode(projectDirectory, projectName));

        final results = FairCompilationResults(
          compiledJS: ' ',
          compiledJson: ' ',
        );
        return results;
      }
    } catch (e, st) {
      _logger.warning('Compiler failed: $e\n$st');
      rethrow;
    }
  }

  Future<FairRunResults> run(
      String input, String userId, String projectName) async {
    try {
      final projectDirectory = path.join(Directory.current.path, 'fairDir',
          'userProject', userId, projectName);

      final result = await Process.run(
          _sdk.flutterToolPath, ['build', 'web', '--web-renderer=html'],
          workingDirectory: projectDirectory);
      if (result.exitCode != 0) {
        return FairRunResults.failed(
            [CompilationProblem(result.stderr as String)]);
      } else {
        var url = path.join(resourceHost, 'userProject', userId, projectName,
            'build/web/index.html');
        final results = FairRunResults(
          url: url,
        );
        return results;
      }
    } catch (e, st) {
      _logger.warning('Compiler failed: $e\n$st');
      rethrow;
    } finally {}
  }

  Future<void> dispose() async {
    return Future(() => null);
  }
}

/// The result of a Fair compile.
class FairCompilationResults {
  final String? compiledJS;
  final String? compiledJson;
  final List<CompilationProblem> problems;

  FairCompilationResults({this.compiledJS, this.compiledJson})
      : problems = const <CompilationProblem>[];

  FairCompilationResults.failed(this.problems)
      : compiledJS = null,
        compiledJson = null;

  bool get hasOutput => compiledJS != null && compiledJS!.isNotEmpty;

  /// This is true if there were no errors.
  bool get success => problems.isEmpty;

  @override
  String toString() => success
      ? 'CompilationResults: Success'
      : 'Compilation errors: ${problems.join('\n')}';
}

/// The result of a Fair compile.
class FairRunResults {
  final String? url;
  final List<CompilationProblem> problems;

  FairRunResults({this.url}) : problems = const <CompilationProblem>[];

  FairRunResults.failed(this.problems) : url = null;

  bool get hasOutput => url != null && url!.isNotEmpty;

  /// This is true if there were no errors.
  bool get success => problems.isEmpty;

  @override
  String toString() => success
      ? 'CompilationResults: Success'
      : 'Compilation errors: ${problems.join('\n')}';
}
