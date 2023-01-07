/// A wrapper around an analysis server instance
library services.analysis_server;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:analysis_server_lib/analysis_server_lib.dart';
import 'package:fair_online_service/src/common.dart';
import 'package:fair_online_service/src/common_server_impl.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:fair_online_service/src/fair_plugin/fair_visitor.dart';
import 'package:fair_online_service/src/fair_plugin/model/issue.dart';
import 'package:fair_online_service/src/fair_plugin/utils/analysis_utils.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'protos/dart_services.pb.dart' as proto;
import 'pub.dart';
import 'scheduler.dart';
import 'utils.dart' as utils;

final Logger _logger = Logger('analysis_server');

/// Flag to determine whether we should dump the communication with the server
/// to stdout.
bool dumpServerMessages = false;

// Use very long timeouts to ensure that the server has enough time to restart.
const Duration _analysisServerTimeout = Duration(seconds: 35);

class FlutterAnalysisServerWrapper {
  // dart sdk 路径
  final String _sdkPath;

  //源码目录
  final String _sourceDirPath;
  final TaskScheduler serverScheduler = TaskScheduler();

  // analysis server初始化
  bool _initialized = false;

  late AnalysisServer _analysisServer;

  //收集plugin返回的fair语法糖语法错误
  // final pluginErrors = <AnalysisError>{};

  //获取临时分析文件的路径
  String get tempPath => _getPathFromName(kTempDart);

  FlutterAnalysisServerWrapper(
      {required String dartSdkPath, required String userProjectPath})
      : _sdkPath = dartSdkPath,
        _sourceDirPath = userProjectPath;

  //dart sdk version
  String get _sdkVersion {
    return File(path.join(_sdkPath, 'version')).readAsStringSync().trim();
  }

  //server uniqueId
  int get uniqueId => _sourceDirPath.hashCode;

  //暴力获取所有source
  Map<String, String> _getAllSourceFromDir(String dirPath) {
    final result = <String, String>{};
    final fileDir = Directory(dirPath);
    final files = fileDir.listSync();
    for (var file in files) {
      if (file.statSync().type == FileSystemEntityType.directory) {
        result.addAll(_getAllSourceFromDir(file.path));
      } else {
        if (file.path.contains('.dart')) {
          result[file.path] = File(file.path).readAsStringSync();
        }
      }
    }
    return result;
  }

  Future<int> get onExit {
    // Return when the analysis server exits. We introduce a delay so that when
    // we terminate the analysis server we can exit normally.
    return _analysisServer.processCompleter.future.then((int code) {
      return Future<int>.delayed(const Duration(seconds: 1), () {
        return code;
      });
    });
  }

  Future<proto.CompleteResponse> complete(
    String src,
    int offset,
    String filePath,
    String type,
  ) async {
    if (type != SourceType.filePath && type != SourceType.temp) {
      throw BadRequest('Unknown type!');
    }
    bool isTemp = type == SourceType.temp;
    var sources = <String, String>{};
    if (isTemp) {
      sources[tempPath] = src;
    } else {
      sources[filePath] = src;
    }
    final location = Location(isTemp ? tempPath : filePath, offset);

    //校验一下初始化
    if (!_initialized) {
      return proto.CompleteResponse()
        ..replacementOffset = 0
        ..replacementLength = 0
        ..completions.addAll([]);
    }

    final results =
        await _completeImpl(sources, location.sourceName, location.offset);
    var suggestions = results.results;

    final source = sources[location.sourceName]!;
    final prefix = source.substring(results.replacementOffset, location.offset);
    suggestions = suggestions.where((suggestion) {
      return suggestion.completion
          .toLowerCase()
          .startsWith(prefix.toLowerCase());
    }).where((CompletionSuggestion suggestion) {
      // We do not want to enable arbitrary discovery of file system resources.

      // In order to avoid returning local file paths, we only allow returning
      // IMPORT kinds that are dart: or package: imports.
      if (suggestion.kind == 'IMPORT') {
        final completion = suggestion.completion;
        return completion.startsWith('dart:') ||
            completion.startsWith('package:');
      } else {
        return true;
      }
    }).toList();

    suggestions.sort((CompletionSuggestion x, CompletionSuggestion y) {
      if (x.relevance == y.relevance) {
        return x.completion.compareTo(y.completion);
      } else {
        return y.relevance.compareTo(x.relevance);
      }
    });

    return proto.CompleteResponse()
      ..replacementOffset = results.replacementOffset
      ..replacementLength = results.replacementLength
      ..completions
          .addAll(suggestions.map((CompletionSuggestion c) => proto.Completion()
            ..completion.addAll(c.toMap().map((key, value) {
              // TODO: Properly support Lists, Maps (this is a hack).
              if (value is Map || value is List) {
                value = json.encode(value);
              }
              return MapEntry(key.toString(), value.toString());
            }))));
  }

  Future<proto.FixesResponse> getFixes(
    String src,
    int offset,
    String filePath,
    String type,
  ) async {
    //校验一下初始化
    if (!_initialized) {
      return Future(() => proto.FixesResponse()..fixes.addAll([]));
    }
    if (type != SourceType.filePath && type != SourceType.temp) {
      throw BadRequest('Unknown type!');
    }
    bool isTemp = type == SourceType.temp;
    var sources = <String, String>{};
    if (isTemp) {
      //保存代码
      await File(tempPath).writeAsString(src);
      sources[tempPath] = src;
    } else {
      sources[filePath] = src;
    }
    final fixes = <AnalysisErrorFixes>[];

    //如果传入的source是有错误的，可能会导致抽象语法树转换失败
    ParseStringResult? parseResult;
    try {
      parseResult = parseString(content: src, path: filePath);
    } catch (e) {
      _logger.warning('getFixes parseString error ===>$e');
    }

    if (null != parseResult && parseResult is ParseStringResult) {
      var compilationUnit = parseResult.unit;
      final visitor = FairVisitor();
      //遍历AST
      compilationUnit.accept(visitor);
      var analysisIssues = visitor.issues;

      if (analysisIssues.isNotEmpty) {
        final results = analysisIssues.where(
            (issue) => (offset >= issue.offset && offset <= issue.offset + 2));
        for (var result in results) {
          if (result is SugarIfIssue) {
            fixes.add(fixesFromIssue<SugarIfIssue>(
                result, filePath, compilationUnit));
          }
          if (result is SugarMapIssue) {
            fixes.add(fixesFromIssue<SugarMapIssue>(
                result, filePath, compilationUnit));
          }
        }
      }
    }
    return getFixesMulti(
      sources,
      Location(isTemp ? tempPath : filePath, offset),
      fixes,
    );
  }

  Future<proto.FixesResponse> getFixesMulti(
    Map<String, String> sources,
    Location location,
    Iterable<AnalysisErrorFixes> fixes,
  ) async {
    final results =
        (await _getFixesImpl(sources, location.sourceName, location.offset))
          ..fixes.addAll(fixes);
    final responseFixes = results.fixes.map(_convertAnalysisErrorFix);
    return proto.FixesResponse()..fixes.addAll(responseFixes);
  }

  Future<proto.AssistsResponse> getAssists(
    String src,
    int offset,
    String filePath,
    String type,
  ) async {
    //校验一下初始化
    if (!_initialized) {
      return proto.AssistsResponse()..assists.addAll([]);
    }
    if (type != SourceType.filePath && type != SourceType.temp) {
      throw BadRequest('Unknown type!');
    }
    bool isTemp = type == SourceType.temp;
    var sources = <String, String>{};
    if (isTemp) {
      sources[tempPath] = src;
    } else {
      sources[filePath] = src;
    }
    final sourceName =
        Location(isTemp ? tempPath : filePath, offset).sourceName;
    final results = await _getAssistsImpl(sources, sourceName, offset);
    final fixes = _convertSourceChangesToCandidateFixes(results.assists);
    return proto.AssistsResponse()..assists.addAll(fixes);
  }

  Future<proto.FormatResponse> format(
    String src,
    int offset,
    String filePath,
    String type,
  ) {
    //校验一下初始化
    if (!_initialized) {
      return Future(() => proto.FormatResponse()
        ..newString = ''
        ..offset = 0);
    }

    return _formatImpl(src, offset, filePath, type)
        .then((FormatResult editResult) {
      final edits = editResult.edits;

      edits.sort((SourceEdit e1, SourceEdit e2) =>
          -1 * e1.offset.compareTo(e2.offset));

      for (final edit in edits) {
        src = src.replaceRange(
            edit.offset, edit.offset + edit.length, edit.replacement);
      }

      return proto.FormatResponse()
        ..newString = src
        ..offset = editResult.selectionOffset;
    }).catchError((dynamic error) {
      _logger.fine('server:$uniqueId format error: $error');
      return proto.FormatResponse()
        ..newString = src
        ..offset = offset;
    });
  }

  Future<void> warmup() async {
    //已经初始化过了，就不要再重复初始化了
    if (_initialized) {
      _logger.info('server:${_sourceDirPath.hashCode} 已经初始化');
      return;
    }
    _logger.info(
        '===============>server:${_sourceDirPath.hashCode} 开始初始化<===============');

    final serverArgs = <String>[
      '--client-id=${_sourceDirPath.hashCode}',
      '--client-version=$_sdkVersion',
    ];

    _analysisServer = await AnalysisServer.create(
      sdkPath: _sdkPath,
      serverArgs: serverArgs,
    );

    _initialized = true;

    try {
      _analysisServer.server.onError.listen((ServerError error) {
        _logger.severe(
            'server:${_sourceDirPath.hashCode} error${error.isFatal ? ' (fatal)' : ''}',
            error.message,
            StackTrace.fromString(error.stackTrace));
      });
      await _analysisServer.server.onConnected.first;
      await _analysisServer.server.setSubscriptions(<String>['STATUS']);

      listenForCompletions();

      //先指定 lib/page 为可分析路径，因为只有page下的页面才会暂时在前端。
      //如果要做Android studio那种全局的错误收集再开放路径。
      final included = path.join(_sourceDirPath, 'lib', 'page');
      //如果是empty工程不存在page目录，手动创建一个
      final pageDir = Directory(included);
      if (!pageDir.existsSync()) {
        pageDir.createSync();
      }
      //自定义组件需要临时文件目录
      final tempIncluded = path.join(_sourceDirPath, 'lib', 'temp');
      _logger.fine('要分析的文件路径：$included');
      await _analysisServer.analysis
          .setAnalysisRoots([included, tempIncluded], []);
      // Warmup.寻找page目录下第一个页面作为warmup对象，如果page下面没有页面，则不做warmup
      final pages = pageDir.listSync();
      var warmupFilePath = '';
      if (pages.isNotEmpty) {
        var warmupTarget = pages.first;
        if (warmupTarget.statSync().type == FileSystemEntityType.directory) {
          warmupFilePath = (warmupTarget as Directory)
              .listSync()
              .firstWhere((element) => path.extension(element.path) == '.dart')
              .path;
        } else {
          if (warmupTarget.path.endsWith('.dart')) {
            warmupFilePath = warmupTarget.path;
          }
        }
      }

      if (warmupFilePath.isNotEmpty) {
        final warmupFile = File(warmupFilePath);
        final warmupSource = warmupFile.readAsStringSync();
        await _sendAddOverlays({warmupFilePath: warmupSource});
        await _sendRemoveOverlays();
      }
    } catch (err, st) {
      _logger.severe(
          'server:${_sourceDirPath.hashCode} Error starting analysis server ($_sdkPath): $err.\n$st');
      rethrow;
    }
    _logger.fine(
        '===============>server:${_sourceDirPath.hashCode} 初始化完毕<===============');
  }

  Future<Map<String, String>> dartdoc(
    String source,
    int offset,
    String filePath,
    String type,
  ) {
    _logger.fine(
        'server:$uniqueId dartdoc: Scheduler queue: ${serverScheduler.queueCount}');

    //校验一下初始化
    if (!_initialized) {
      return Future(() => <String, String>{});
    }
    if (type != SourceType.filePath && type != SourceType.temp) {
      throw BadRequest('Unknown type!');
    }
    bool isTemp = type == SourceType.temp;
    var sources = <String, String>{};
    if (isTemp) {
      sources[tempPath] = source;
    } else {
      sources[filePath] = source;
    }
    return serverScheduler.schedule(ClosureTask<Map<String, String>>(() async {
      await _loadSources(sources);

      final result = await _analysisServer.analysis
          .getHover(isTemp ? tempPath : filePath, offset);
      await _unloadSources();

      if (result.hovers.isEmpty) {
        return const {};
      }

      final info = result.hovers.first;

      return {
        if (info.elementDescription != null)
          'description': info.elementDescription!,
        if (info.elementKind != null) 'kind': info.elementKind!,
        if (info.dartdoc != null) 'dartdoc': info.dartdoc!,
        if (info.containingClassDescription != null)
          'enclosingClassName': info.containingClassDescription!,
        if (info.containingLibraryName != null)
          'libraryName': info.containingLibraryName!,
        if (info.parameter != null) 'parameter': info.parameter!,
        if (info.isDeprecated != null)
          'deprecated': info.isDeprecated!.toString(),
        if (info.staticType != null) 'staticType': info.staticType!,
        if (info.propagatedType != null) 'propagatedType': info.propagatedType!,
      };
    }, timeoutDuration: _analysisServerTimeout));
  }

  Future<proto.AnalysisResults> analyze(
    String source,
    String filePath,
    String type,
  ) async {
    if (type != SourceType.filePath && type != SourceType.temp) {
      throw BadRequest('Unknown type!');
    }
    bool isTemp = type == SourceType.temp;
    // final fileDirPath = path.join(_sourceDirPath, 'lib');
    // var sources = _getAllSourceFromDir(fileDirPath);
    var sources = <String, String>{};
    if (isTemp) {
      sources[tempPath] = source;
    } else {
      //保存代码
      await File(filePath).writeAsString(source);
      sources[filePath] = source;
    }

    _logger.fine(
        'server:$uniqueId analyze: Scheduler queue: ${serverScheduler.queueCount}');

    //校验一下初始化
    if (!_initialized) {
      _logger.fine('调用analyze接口，Analysis Server未初始化');
      return Future(() => proto.AnalysisResults()
        ..issues.addAll([])
        ..packageImports.addAll([]));
    }

    return serverScheduler
        .schedule(ClosureTask<proto.AnalysisResults>(() async {
      sources = _getOverlayMapWithPaths(sources);

      await _loadSources(sources);
      final errors = (await _analysisServer.analysis
              .getErrors(isTemp ? tempPath : filePath))
          .errors;
      await _unloadSources();

      final startTime = DateTime.now().millisecondsSinceEpoch;
      _logger.info('fairAnalyze $startTime');

      //如果传入的source是有错误的，可能会导致抽象语法树转换失败
      ParseStringResult? parseResult;
      try {
        parseResult = parseString(content: source, path: filePath);
      } catch (e) {
        _logger.warning('analyze parseString error ===>$e');
      }
      _logger.info(
          'fairAnalyze ${DateTime.now().millisecondsSinceEpoch} cost ${DateTime.now().millisecondsSinceEpoch - startTime}ms.');
      if (null != parseResult && parseResult is ParseStringResult) {
        var compilationUnit = parseResult.unit;
        final visitor = FairVisitor();
        //遍历AST
        compilationUnit.accept(visitor);
        var analysisIssues = visitor.issues;
        _logger.info(
            'fairAnalyze ${DateTime.now().millisecondsSinceEpoch} cost ${DateTime.now().millisecondsSinceEpoch - startTime}ms.');

        if (analysisIssues.isNotEmpty) {
          final analysisErrors = analysisIssues
              .map(
                  (issue) => analysisErrorFor(filePath, issue, compilationUnit))
              .toList();

          //合并一下两次的结果
          errors.addAll(analysisErrors);
          _logger.info(
              'fairAnalyze ${DateTime.now().millisecondsSinceEpoch} cost ${DateTime.now().millisecondsSinceEpoch - startTime}ms.');
        }
      }

      // Convert the issues to protos.
      final issues = errors.map((error) {
        final issue = proto.AnalysisIssue()
          ..kind = error.severity.toLowerCase()
          ..line = error.location.startLine
          ..message = utils.normalizeFilePaths(error.message)
          ..sourceName = path.basename(error.location.file)
          ..hasFixes = error.hasFix ?? false
          ..charStart = error.location.offset
          ..charLength = error.location.length
          ..diagnosticMessages.addAll(error.contextMessages?.map((m) =>
                  proto.DiagnosticMessage(
                      message: utils.normalizeFilePaths(m.message),
                      line: m.location.startLine,
                      charStart: m.location.offset,
                      charLength: m.location.length)) ??
              []);

        if (error.url != null) {
          issue.url = error.url!;
        }

        if (error.correction != null) {
          issue.correction = utils.normalizeFilePaths(error.correction!);
        }

        return issue;
      }).toList();

      issues.sort((a, b) {
        // Order issues by character position of the bug/warning.
        return a.charStart.compareTo(b.charStart);
      });

      // Calculate the imports.
      final packageImports = {
        for (final source in sources.values)
          ...getAllImportsFor(source).filterSafePackages(),
      };

      return proto.AnalysisResults()
        ..issues.addAll(issues)
        ..packageImports.addAll(packageImports);
    }, timeoutDuration: _analysisServerTimeout));
  }

  Future<AssistsResult> _getAssistsImpl(
    Map<String, String> sources,
    String sourceName,
    int offset,
  ) {
    sources = _getOverlayMapWithPaths(sources);
    final path = _getPathFromName(sourceName);

    if (serverScheduler.queueCount > 0) {
      _logger.fine(
          'server:$uniqueId getRefactoringsImpl: Scheduler queue: ${serverScheduler.queueCount}');
    }

    return serverScheduler.schedule(ClosureTask<AssistsResult>(() async {
      await _loadSources(sources);
      final AssistsResult assists;
      try {
        assists =
            await _analysisServer.edit.getAssists(path, offset, 1 /* length */);
      } finally {
        await _unloadSources();
      }
      return assists;
    }, timeoutDuration: _analysisServerTimeout));
  }

  /// Convert between the Analysis Server type and the API protocol types.
  static proto.ProblemAndFixes _convertAnalysisErrorFix(
      AnalysisErrorFixes analysisFixes) {
    final problemMessage = analysisFixes.error.message;
    final problemOffset = analysisFixes.error.location.offset;
    final problemLength = analysisFixes.error.location.length;

    final possibleFixes = <proto.CandidateFix>[];

    for (final sourceChange in analysisFixes.fixes) {
      final edits = <proto.SourceEdit>[];

      // A fix that tries to modify other files is considered invalid.

      var invalidFix = false;
      for (final sourceFileEdit in sourceChange.edits) {
        // TODO 增加类校验
        // TODO(lukechurch): replace this with a more reliable test based on the
        // psuedo file name in Analysis Server
        // if (!sourceFileEdit.file.endsWith('/main.dart')) {
        //   invalidFix = true;
        //   break;
        // }

        for (final sourceEdit in sourceFileEdit.edits) {
          edits.add(proto.SourceEdit()
            ..offset = sourceEdit.offset
            ..length = sourceEdit.length
            ..replacement = sourceEdit.replacement);
        }
      }
      if (!invalidFix) {
        final possibleFix = proto.CandidateFix()
          ..message = sourceChange.message
          ..edits.addAll(edits);
        possibleFixes.add(possibleFix);
      }
    }
    return proto.ProblemAndFixes()
      ..fixes.addAll(possibleFixes)
      ..problemMessage = problemMessage
      ..offset = problemOffset
      ..length = problemLength;
  }

  static List<proto.CandidateFix> _convertSourceChangesToCandidateFixes(
      List<SourceChange> sourceChanges) {
    final assists = <proto.CandidateFix>[];

    for (final sourceChange in sourceChanges) {
      for (final sourceFileEdit in sourceChange.edits) {
        // TODO 增加类校验
        // if (!sourceFileEdit.file.endsWith('/main.dart')) {
        //   break;
        // }

        final sourceEdits = sourceFileEdit.edits.map((sourceEdit) {
          return proto.SourceEdit()
            ..offset = sourceEdit.offset
            ..length = sourceEdit.length
            ..replacement = sourceEdit.replacement;
        });

        final candidateFix = proto.CandidateFix();
        candidateFix.message = sourceChange.message;
        candidateFix.edits.addAll(sourceEdits);
        final selectionOffset = sourceChange.selection?.offset;
        if (selectionOffset != null) {
          candidateFix.selectionOffset = selectionOffset;
        }
        candidateFix.linkedEditGroups
            .addAll(_convertLinkedEditGroups(sourceChange.linkedEditGroups));
        assists.add(candidateFix);
      }
    }

    return assists;
  }

  /// Convert a list of the analysis server's [LinkedEditGroup]s into the API's
  /// equivalent.
  static Iterable<proto.LinkedEditGroup> _convertLinkedEditGroups(
      Iterable<LinkedEditGroup> groups) {
    return groups.map<proto.LinkedEditGroup>((g) {
      return proto.LinkedEditGroup()
        ..positions.addAll(g.positions.map((p) => p.offset).toList())
        ..length = g.length
        ..suggestions.addAll(g.suggestions
            .map((s) => proto.LinkedEditSuggestion()
              ..value = s.value
              ..kind = s.kind)
            .toList());
    });
  }

  /// Cleanly shutdown the Analysis Server.
  Future<void> shutdown() {
    // TODO(jcollins-g): calling dispose() sometimes prevents
    // --pause-isolates-on-exit from working; fix.
    return _analysisServer.server
        .shutdown()
        .timeout(const Duration(seconds: 1))
        // At runtime, it appears that [ServerDomain.shutdown] returns a
        // `Future<Map<dynamic, dynamic>>`.
        .catchError((_) => {});
  }

  /// Internal implementation of the completion mechanism.
  Future<CompletionResults> _completeImpl(
    Map<String, String> sources,
    String sourceName,
    int offset,
  ) async {
    if (serverScheduler.queueCount > 0) {
      _logger.info(
          'server:${_sourceDirPath.hashCode} completeImpl: Scheduler queue: ${serverScheduler.queueCount}');
    }

    return serverScheduler.schedule(ClosureTask<CompletionResults>(() async {
      sources = _getOverlayMapWithPaths(sources);
      await _loadSources(sources);
      final id = await _analysisServer.completion.getSuggestions(
        _getPathFromName(sourceName),
        offset,
      );
      final CompletionResults results;
      try {
        results = await getCompletionResults(id.id);
      } finally {
        await _unloadSources();
      }
      return results;
    }, timeoutDuration: _analysisServerTimeout));
  }

  Future<FixesResult> _getFixesImpl(
    Map<String, String> sources,
    String sourceName,
    int offset,
  ) async {
    sources = _getOverlayMapWithPaths(sources);
    final path = _getPathFromName(sourceName);

    if (serverScheduler.queueCount > 0) {
      _logger.fine(
          'server:$uniqueId getFixesImpl: Scheduler queue: ${serverScheduler.queueCount}');
    }

    return serverScheduler.schedule(ClosureTask<FixesResult>(() async {
      await _loadSources(sources);
      final FixesResult fixes;
      try {
        fixes = await _analysisServer.edit.getFixes(path, offset);
      } finally {
        await _unloadSources();
      }
      return fixes;
    }, timeoutDuration: _analysisServerTimeout));
  }

  Future<FormatResult> _formatImpl(
    String src,
    int offset,
    String filePath,
    String type,
  ) async {
    if (type != SourceType.filePath && type != SourceType.temp) {
      throw BadRequest('Unknown type!');
    }
    bool isTemp = type == SourceType.temp;
    var sources = <String, String>{};
    if (isTemp) {
      sources[tempPath] = src;
    } else {
      sources[filePath] = src;
    }
    _logger.fine(
        'server:$uniqueId FormatImpl: Scheduler queue: ${serverScheduler.queueCount}');

    return serverScheduler.schedule(ClosureTask<FormatResult>(() async {
      await _loadSources(sources);
      final FormatResult result;
      try {
        result = await _analysisServer.edit
            .format(isTemp ? tempPath : filePath, offset, 0);
      } finally {
        await _unloadSources();
      }
      return result;
    }, timeoutDuration: _analysisServerTimeout));
  }

  Map<String, String> _getOverlayMapWithPaths(Map<String, String> overlay) {
    final newOverlay = <String, String>{};
    for (final key in overlay.keys) {
      newOverlay[_getPathFromName(key)] = overlay[key]!;
    }
    return newOverlay;
  }

  String _getPathFromName(String sourceName) =>
      path.join(_sourceDirPath, sourceName);

  final Set<String> _overlayPaths = <String>{};

  /// Loads [sources] as file system overlays to the analysis server.
  ///
  /// The analysis server then begins to analyze these as priority files.
  Future<void> _loadSources(
    Map<String, String> sources,
  ) async {
    // if (_overlayPaths.isNotEmpty) {
    //   throw StateError(
    //       'There should be no overlay paths while loading sources, but we '
    //       'have: $_overlayPaths');
    // }
    await _sendAddOverlays(sources);
    await _analysisServer.analysis.setPriorityFiles(sources.keys.toList());
  }

  Future<void> _unloadSources() async {
    await _sendRemoveOverlays();
    await _analysisServer.analysis.setPriorityFiles([]);
  }

  /// Sends [overlays] to the analysis server.
  Future<void> _sendAddOverlays(
    Map<String, String> overlays,
  ) async {
    final contentOverlays = overlays.map((overlayPath, content) =>
        MapEntry(overlayPath, AddContentOverlay(content)));

    _logger
        .fine('About to send analysis.updateContent:${contentOverlays.keys}');

    _overlayPaths.addAll(contentOverlays.keys);

    await _analysisServer.analysis.updateContent(contentOverlays);
  }

  Future<void> _sendRemoveOverlays() async {
    _logger.fine(
        'About to send analysis.updateContent remove overlays:$_overlayPaths');

    final contentOverlays = {
      for (final overlayPath in _overlayPaths)
        overlayPath: RemoveContentOverlay()
    };
    _overlayPaths.clear();

    await _analysisServer.analysis.updateContent(contentOverlays);
  }

  final Map<String, Completer<CompletionResults>> _completionCompleters =
      <String, Completer<CompletionResults>>{};

  void listenForCompletions() {
    _analysisServer.completion.onResults.listen((CompletionResults result) {
      if (result.isLast) {
        final completer = _completionCompleters.remove(result.id);
        if (completer != null) {
          completer.complete(result);
        }
      }
    });
  }

  void dispose() {
    _initialized = false;
    _analysisServer.dispose();
  }

  Future<CompletionResults> getCompletionResults(String id) {
    final completer = Completer<CompletionResults>();
    _completionCompleters[id] = completer;
    return completer.future;
  }
}

class Location {
  final String sourceName;
  final int offset;

  const Location(this.sourceName, this.offset);
}
