/// This library is a wrapper around the Dart to JavaScript (dart2js) compiler.
library services.compiler;

import 'dart:async';
import 'dart:io';

import 'package:bazel_worker/driver.dart';
import 'package:fair_online_service/src/code/compile_ddc_code.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'common.dart';
import 'common_server_impl.dart';
import 'sdk.dart';

Logger _logger = Logger('compiler');

/// An interface to the dart2js compiler. A compiler object can process one
/// compile at a time.
class Compiler {
  final Sdk _sdk;
  final String _dartPath;
  final String _dartdevcPath;
  final BazelWorkerDriver _ddcDriver;

  Compiler(Sdk sdk) : this._(sdk, path.join(sdk.dartSdkPath, 'bin', 'dart'));

  Compiler._(this._sdk, this._dartPath)
      : _dartdevcPath = path.join(
            _sdk.dartSdkPath, 'bin', 'snapshots', 'dartdevc.dart.snapshot'),
        _ddcDriver = BazelWorkerDriver(
            () => Process.start(_dartPath, [
                  path.join(_sdk.dartSdkPath, 'bin', 'snapshots',
                      'dartdevc.dart.snapshot'),
                  '--persistent_worker'
                ]),
            maxWorkers: 1);

  /// Compile the given string and return the resulting [DDCCompilationResults].
  Future<DDCCompilationResults> compileDDC(
    String input,
    String pageName,
    String userId,
    String projectName,
    String type,
    String runMode,
  ) async {
    if (type != SourceType.filePath && type != SourceType.temp) {
      throw BadRequest('Unknown type!');
    }
    if (runMode != RunMode.project && runMode != RunMode.singlePage) {
      throw BadRequest('Unknown runMode!');
    }
    //TODO 完善检查依赖的逻辑
    // final imports = getAllImportsFor(input);
    // final unsupportedImports =
    //     getUnsupportedImports(imports, devMode: _sdk.devMode);
    // if (unsupportedImports.isNotEmpty) {
    //   return DDCCompilationResults.failed([
    //     for (var import in unsupportedImports)
    //       CompilationProblem._('unsupported import: ${import.uri.stringValue}'),
    //   ]);
    // }

    final projectPath = path.join(
        Directory.current.path, 'fairDir', 'userProject', userId, projectName);
    _logger.info('projectPath : $projectPath');
    final temp = Directory(projectPath);

    try {
      await Directory(path.join(temp.path, 'lib')).create(recursive: true);

      final ddcFileName = kMainDart;
      final mainPath = path.join(temp.path, 'lib', ddcFileName);
      final bootstrapPath = path.join(temp.path, 'lib', kBootstrapDart);
      // different flutter version select different bootstrap code
      final bootstrapContents = kBootstrapFlutterCode250;

      await File(bootstrapPath).writeAsString(bootstrapContents);

      if (pageName.isNotEmpty) {
        pageName = path.join(projectPath, 'lib', 'page', pageName);
        await File(pageName).writeAsString(input);
      }
      if (runMode == RunMode.project) {
        //对整个工程进行编译预览
        await File(mainPath).writeAsString(kCompileDDCMainCode(projectPath));
      } else {
        //单文件预览模式
        if (type == SourceType.filePath) {
          await File(mainPath)
              .writeAsString(kCompileDDCSingleFileCode(pageName, projectPath));
        } else {
          //构造临时文件，进行编译预览
          final pagePath = path.join(temp.path, 'lib', 'temp', 'temp.dart');
          File tempFile = File(pagePath);
          if(!tempFile.existsSync()){
            tempFile.createSync(recursive: true);
          }
          await tempFile.writeAsString(input);
          await File(mainPath).writeAsString(kCompileDDCTempFileCode(input));
        }
      }

      final arguments = <String>[
        '--modules=amd',
        '-s',
        path.join(
          'artifacts',
          'flutter_web.dill',
        ),
        '-s',
        '${_sdk.flutterWebSdkPath}/flutter_ddc_sdk_sound.dill',
        ...['-o', path.join(temp.path, '$ddcFileName.js')],
        ...['--module-name', 'fair_online'],
        '--enable-asserts',
        '--sound-null-safety',
        bootstrapPath,
        '--packages=${path.join(temp.path, '.dart_tool', 'package_config.json')}',
      ];

      final mainJs = File(path.join(temp.path, '$ddcFileName.js'));

      _logger.info(
          'About to exec dartdevc worker:$_dartdevcPath  ${arguments.join(' ')}"');

      final response =
          await _ddcDriver.doWork(WorkRequest()..arguments.addAll(arguments));

      if (response.exitCode != 0) {
        return DDCCompilationResults.failed(
            [CompilationProblem._(response.output)]);
      } else {
        // The `--single-out-file` option for dartdevc was removed in v2.7.0. As
        // a result, the JS code produced above does *not* provide a name for
        // the module it contains. That's a problem for DartPad, since it's
        // adding the code to a script tag in an iframe rather than loading it
        // as an individual file from baseURL. As a workaround, this replace
        // statement injects a name into the module definition.
        final processedJs = (await mainJs.readAsString())
            .replaceFirst('define([', "define('fair_online', [");

        final results = DDCCompilationResults(
          compiledJS: processedJs,
          modulesBaseUrl: 'https://storage.googleapis.com/nnbd_artifacts'
              '/${_sdk.versionFull}/',
        );
        return results;
      }
    } catch (e, st) {
      _logger.warning('Compiler failed: $e\n$st');
      rethrow;
    } finally {
      _logger.info('CompileDDC finished');
    }
  }

  Future<void> dispose() async {
    return _ddcDriver.terminateWorkers();
  }
}

/// The result of a DDC compile.
class DDCCompilationResults {
  final String? compiledJS;
  final String? modulesBaseUrl;
  final List<CompilationProblem> problems;

  DDCCompilationResults({this.compiledJS, this.modulesBaseUrl})
      : problems = const <CompilationProblem>[];

  DDCCompilationResults.failed(this.problems)
      : compiledJS = null,
        modulesBaseUrl = null;

  bool get hasOutput => compiledJS != null && compiledJS!.isNotEmpty;

  /// This is true if there were no errors.
  bool get success => problems.isEmpty;

  @override
  String toString() => success
      ? 'CompilationResults: Success'
      : 'Compilation errors: ${problems.join('\n')}';
}

/// An issue associated with [CompilationResults].
class CompilationProblem implements Comparable<CompilationProblem> {
  final String message;

  CompilationProblem(String message) : this._(message);

  CompilationProblem._(this.message);

  @override
  int compareTo(CompilationProblem other) => message.compareTo(other.message);

  @override
  String toString() => message;
}
