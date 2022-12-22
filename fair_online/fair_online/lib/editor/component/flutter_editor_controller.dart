import 'dart:async';
import 'dart:html' as html;
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fair_online/editor/completion.dart';
import 'package:fair_online/editor/constant.dart';
import 'package:fair_online/editor/core/keys.dart';
import 'package:fair_online/editor/fair_online.dart';
import 'package:fair_online/editor/editing/codemirror_options.dart';
import 'package:fair_online/editor/editing/editor_codemirror.dart';
import 'package:fair_online/editor/editing/hint_helper.dart';
import 'package:fair_online/editor/playground_context.dart';
import 'package:fair_online/editor/services/common.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/editor/services/execution_iframe.dart';
import 'package:fair_online/models/dart_editor_model.dart';
import 'package:fair_online/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'params_provider.dart';

final Logger _logger = Logger('flutter_editor');

///源码类型
enum SourceType {
  filePath, //有文件路径的类型
  temp, //无文件路径，使用临时文件
}

///运行模式
enum RunMode {
  project, //运行整个工程
  singlePage //单页面编译运行
}

class FlutterEditorController implements ParamsProvider {
  ///标识，用于享元获取实例和作为HtmlElementView的viewType
  String key;

  ///缓存池
  static final Map<String, FlutterEditorController> _cache = {};

  factory FlutterEditorController({required String key}) {
    if (_cache.containsKey(key)) {
      return _cache[key]!;
    } else {
      final controller = FlutterEditorController._internal(key);
      controller._setUpFrame();
      _cache[key] = controller;
      return controller;
    }
  }

  FlutterEditorController._internal(this.key);

  ///初始化预览视图
  void _setUpFrame() {
    // Set up the iframe.
    _frame = html.IFrameElement()
      ..style.border = 'none'
      ..src = 'scripts/frame_dark.html';
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(getPreviewViewType(),
        (int viewId) {
      return _frame;
    });
  }

  final RegExp cssSymbolRegexp = RegExp(r'[A-Z]');

  late final Editor editor;

  late PlaygroundContext context;

  String get fullDartSource => context.dartSource;

  Document get currentDocument => editor.document;

  bool get _isCompletionActive => editor.completionActive;

  late final ExecutionService executionService;

  bool get shouldAddFirebaseJs => false;

  Future<AnalysisResults>? analysisRequest;

  Future<AnalysisResults>? fairAnalysisRequest;

  late html.IFrameElement _frame;

  CodeMirrorFactory editorFactory = CodeMirrorFactory();

  /**
   * 是否初始化过
   */
  bool _hasInitialized = false;

  /**
   * 初始化代码编辑器
   */
  Future<Editor> initialized() async {
    if (_hasInitialized) {
      //如果初始化完成则返回
      clearIssues();
      return editor;
    }
    _hasInitialized = true;
    executionService = ExecutionServiceIFrame(_frame);
    executionService.onStdout.listen(_showOutput);
    executionService.onStderr.listen((m) => _showOutput(m, error: true));
    executionService.screenshot.listen(_showScreenshot);
    final html.HtmlElement element = html.DivElement();
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(getCodeMirrorViewType(),
        (int viewId) {
      return element;
    });
    //初始化codemirror
    editor = (editorFactory..paramsProvider = this)
        .createFromElement(element, options: codeMirrorOptions)
      ..theme = 'darkpad'
      ..mode = 'dart'
      ..showLineNumbers = true;
    //绑定按键事件
    _initKeyBindings();
    //编辑器上下文
    context = PlaygroundContext(editor);
    editorFactory.registerCompleter(
        'dart', DartCompleter(dartServices, context.dartDocument));
    context.onDartReconcile.listen((_) => performAnalysis());
    return editor;
  }

  void _initKeyBindings() {
    keys.bind(['ctrl-enter', 'macctrl-enter'], handleRun, 'Run');
    keys.bind(['f1'], () {
      if (!editor.hasFocus) {
        //没有焦点直接返回
        return;
      }
    }, 'Documentation');

    keys.bind(['alt-enter'], () {
      if (!editor.hasFocus) {
        //没有焦点直接返回
        return;
      }
      editor.showCompletions(onlyShowFixes: true);
    }, 'Quick fix');

    keys.bind(['ctrl-space', 'macctrl-space'], () {
      if (!editor.hasFocus) {
        //没有焦点直接返回
        return;
      }
      editor.showCompletions();
    }, 'Completion');

    keys.bind(['shift-ctrl-f', 'shift-macctrl-f'], () {
      if (!editor.hasFocus) {
        //没有焦点直接返回
        return;
      }
      _format();
    }, 'Format');

    document.onKeyDown.listen((event) {
      if (!editor.hasFocus) {
        //没有焦点直接返回
        return;
      }
      //识别字母数字触发代码补全提示
      if (AUTO_COMPLETE_KEY_CODE.contains(event.keyCode) &&
          !event.metaKey &&
          !HintHelper.isShow) {
        editor.showCompletions(autoInvoked: true);
      }
    });

    document.onKeyUp.listen((e) {
      _handleAutoCompletion(e);
    });
  }

  ///获得焦点，重新绑定按键事件，因为按键事件只能对一个编辑器实例生效
  void requestFocus() {
    editorFactory.registerCompleter(
        'dart', DartCompleter(dartServices, context.dartDocument));
    _initKeyBindings();
  }

  ///是否运行中
  ValueNotifier<bool> isRunningNotifier = ValueNotifier<bool>(false);

  get isRunning => isRunningNotifier.value;

  set _isRunning(value) {
    isRunningNotifier.value = value;
  }

  Future<bool> handleRun({BuildContext? buildContext}) async {
    if (isRunning) {
      return false;
    }
    _isRunning = true;
    final compileRequest = CompileDDCRequest()
      ..source = fullDartSource
      ..pageName = _currentPagePath
      ..type = _sourceType.name
      ..runMode = _runMode.name;

    try {
      final response = await dartServices
          .compileDDC(compileRequest)
          .timeout(longServiceCallTimeout);
      debugPrint("misery response.modulesBaseUrl = ${response.modulesBaseUrl}");
      clearOutput();
      await executionService.execute(
        context.htmlSource,
        context.cssSource,
        response.result,
        modulesBaseUrl: response.modulesBaseUrl,
        addRequireJs: true,
        addFirebaseJs: shouldAddFirebaseJs,
        destroyFrame: false,
      );
      return true;
    } catch (e) {
      final message = e is ApiRequestError ? e.message : '$e';
      clearOutput();
      _showOutput('Error compiling... \n$message', error: true);
      if (buildContext != null) {
        DartEditorModel model = buildContext.read<DartEditorModel>();
        if (!model.isEditorPanelShow) {
          model.isEditorPanelShow = true;
        }
      }
      return false;
    } finally {
      _isRunning = false;
    }
  }

  ///清空控制台的输出
  void clearOutput() {
    consoleMessageList.value = ConsoleMessageList([]);
  }

  Future<void> _format() {
    final originalSource = context.dartSource;
    final input = SourceRequest()
      ..source = originalSource
      ..type = _sourceType.name
      ..filePath = _currentPagePath;

    final request = dartServices.format(input).timeout(serviceCallTimeout);
    return request.then((FormatResponse result) {

      if (result.newString.isEmpty) {
        _logger.fine('Format returned null/empty result');
        return;
      }

      if (originalSource != result.newString) {
        context.dartSource = result.newString;
      }
    }).catchError((e) {
      _logger.severe(e);
    });
  }

  void _handleAutoCompletion(KeyboardEvent e) {
    if (context.focusedEditor == 'dart' && editor.hasFocus) {
      if (e.keyCode == KeyCode.PERIOD) {
        editor.showCompletions(autoInvoked: true);
      }
    }

    if (!_isCompletionActive && editor.hasFocus) {
      if (context.focusedEditor == 'html') {
        if (printKeyEvent(e) == 'shift-,') {
          editor.showCompletions(autoInvoked: true);
        }
      } else if (context.focusedEditor == 'css') {
        if (cssSymbolRegexp.hasMatch(String.fromCharCode(e.keyCode))) {
          editor.showCompletions(autoInvoked: true);
        }
      }
    }
  }

  /// Perform static analysis of the source code. Return whether the code
  /// analyzed cleanly (had no errors or warnings).
  Future<bool> performAnalysis() async {
    final input = SourceRequest()
      ..source = fullDartSource
      ..filePath = _currentPagePath
      ..type = _sourceType.name;

    final lines = Lines(input.source);

    final request = dartServices.analyze(input).timeout(serviceCallTimeout);
    analysisRequest = request;

    try {
      final result = await request;
      // Discard if we requested another analysis.
      if (analysisRequest != request) return false;

      // Discard if the document has been mutated since we requested analysis.
      if (input.source != fullDartSource) return false;

      _displayIssues(result.issues);

      currentDocument.setAnnotations(result.issues.map((AnalysisIssue issue) {
        final startLine = lines.getLineForOffset(issue.charStart);
        final endLine =
            lines.getLineForOffset(issue.charStart + issue.charLength);
        final offsetForStartLine = lines.offsetForLine(startLine);

        final start = Position(startLine, issue.charStart - offsetForStartLine);
        final end = Position(
            endLine, issue.charStart + issue.charLength - offsetForStartLine);

        return Annotation(issue.kind, issue.message, issue.line,
            start: start, end: end);
      }).toList());

      final hasErrors = result.issues.any((issue) => issue.kind == 'error');
      final hasWarnings = result.issues.any((issue) => issue.kind == 'warning');
      return !hasErrors && !hasWarnings;
    } catch (e) {
      if (e is! TimeoutException) {
        final message = e is ApiRequestError ? e.message : '$e';

        //TODO message提示
      } else {
        Log.d(e.message ?? "");
      }

      currentDocument.setAnnotations([]);
      return false;
    }
  }

  /**
   * 延迟两秒调用fairAnalyze接口
   */
  Future<bool> performFairAnalysis() async {
    await Future.delayed(Duration(seconds: 1));

    final input = SourceRequest()
      ..source = fullDartSource
      ..filePath = _currentPagePath
      ..type = _sourceType.name;

    final lines = Lines(input.source);

    final request = dartServices.fairAnalyze(input).timeout(serviceCallTimeout);
    fairAnalysisRequest = request;

    try {
      final result = await request;
      // Discard if we requested another analysis.
      if (fairAnalysisRequest != request) return false;

      // Discard if the document has been mutated since we requested analysis.
      if (input.source != fullDartSource) return false;

      _insertIssues(result.issues);

      currentDocument.addAnnotations(result.issues.map((AnalysisIssue issue) {
        final startLine = lines.getLineForOffset(issue.charStart);
        final endLine =
            lines.getLineForOffset(issue.charStart + issue.charLength);
        final offsetForStartLine = lines.offsetForLine(startLine);

        final start = Position(startLine, issue.charStart - offsetForStartLine);
        final end = Position(
            endLine, issue.charStart + issue.charLength - offsetForStartLine);

        return Annotation(issue.kind, issue.message, issue.line,
            start: start, end: end);
      }).toList());

      final hasErrors = result.issues.any((issue) => issue.kind == 'error');
      final hasWarnings = result.issues.any((issue) => issue.kind == 'warning');
      return !hasErrors && !hasWarnings;
    } catch (e) {
      if (e is! TimeoutException) {
        final message = e is ApiRequestError ? e.message : '$e';

        //TODO message提示
      } else {
        Log.d(e.message ?? "");
      }

      return false;
    }
  }

  /**
   * analyze分析结果
   */
  ValueNotifier<List<AnalysisIssue>?> analysisIssuesNotifier =
      ValueNotifier<List<AnalysisIssue>?>(null);

  List<AnalysisIssue>? get analysisIssues => analysisIssuesNotifier.value;

  void clearIssues() {
    if (analysisIssuesNotifier.value?.isNotEmpty ?? false) {
      analysisIssuesNotifier.value = <AnalysisIssue>[];
    }
  }

  void _displayIssues(List<AnalysisIssue> issues) {
    analysisIssuesNotifier.value = issues;
  }

  void _insertIssues(List<AnalysisIssue> issues) {
    final lastAnalysisIssues = analysisIssuesNotifier.value;
    List<AnalysisIssue> newIssues = [];
    if (lastAnalysisIssues != null) {
      newIssues.addAll(lastAnalysisIssues);
    }
    newIssues.insertAll(0, issues);
    analysisIssuesNotifier.value = newIssues;
  }

  /**
   * 代码编辑器跳转至指定位置
   */
  void jumpToLocation(int line, int charStart, int charLength) {
    _jumpTo(line, charStart, charLength, focus: true);
  }

  void _jumpTo(int line, int charStart, int charLength, {bool focus = false}) {
    final doc = editor.document;

    doc.select(
        doc.posFromIndex(charStart), doc.posFromIndex(charStart + charLength));

    if (focus) editor.focus();
  }

  /**
   * 控制台输出信息
   */
  final ValueNotifier<ConsoleMessageList> consoleMessageList =
      ValueNotifier<ConsoleMessageList>(ConsoleMessageList([]));

  void _showOutput(String message, {bool error = false}) {
    consoleMessageList.value = ConsoleMessageList(
        consoleMessageList.value.value..add(ConsoleMessage(message, error)));
  }

  final ValueNotifier<Uint8List?> previewScreenshot =
      ValueNotifier<Uint8List?>(null);

  void _showScreenshot(Uint8List data) {
    previewScreenshot.value = data;
  }

  /**
   * 当前展示的页面的代码
   */
  get code => editor.document.value;

  set code(value) {
    editor.document.value = value;
    editor.resize();
  }

  /**
   * 当前展示的页面名字
   */
  String _currentPagePath = '';

  get currentPagePath => _currentPagePath;

  Future<GetPageResponse>? getCodeByPageRequest;

  ///通过页面路径加载页面代码
  Future<void> loadPage(String pagePath) async {
    isEditorShowLoading = true;
    code = '';
    _currentPagePath = '';
    final params = GetPageRequest();
    params.pagePath = pagePath;
    final request = dartServices.getPage(params).timeout(serviceCallTimeout);
    getCodeByPageRequest = request;
    try {
      final response = await request;
      if (request != getCodeByPageRequest) {
        return;
      }
      isEditorShowLoading = false;
      code = response.result;
      _currentPagePath = pagePath;
    } catch (e) {
      print(e);
      if (request == getCodeByPageRequest) {
        isEditorShowLoading = false;
      }
    }
  }

  /**
   * 代码编辑器是否显示加载中
   */
  ValueNotifier<bool> isEditorShowLoadingNotifier = ValueNotifier<bool>(false);

  get isEditorShowLoading => isEditorShowLoadingNotifier.value;

  set isEditorShowLoading(value) {
    isEditorShowLoadingNotifier.value = value;
  }

  String getPreviewViewType() => '${key}IFrame';

  String getCodeMirrorViewType() => '${key}CodeMirror';

  @override
  String getFilePath() {
    return _currentPagePath;
  }

  ///源码类型
  SourceType _sourceType = SourceType.temp;

  SourceType get sourceType => _sourceType;

  set sourceType(SourceType value) {
    _sourceType = value;
  }

  @override
  String getType() {
    return _sourceType.name;
  }

  RunMode _runMode = RunMode.project;

  RunMode get runMode => _runMode;

  set runMode(RunMode value) {
    _runMode = value;
  }
}

/**
 * 控制台输出信息（单挑）
 */
class ConsoleMessage {
  final String message;
  final bool isError;

  ConsoleMessage(this.message, this.isError);
}

/**
 * 控制台输出信息集合
 */
class ConsoleMessageList {
  final List<ConsoleMessage> value;

  ConsoleMessageList(this.value);
}
