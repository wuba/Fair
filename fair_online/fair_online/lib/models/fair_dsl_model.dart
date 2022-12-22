import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;

import 'package:fair_online/data/device_data.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/editing/codemirror_options.dart';
import 'package:fair_online/editor/editing/editor_codemirror.dart';
import 'package:fair_online/editor/services/common.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/abs_model.dart';
import 'package:fair_online/models/dart_editor_model.dart';
import 'package:fair_online/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../editor/fair_online.dart';

enum FairDslViewerType { JSON, JS }

class FairDslModel extends AbsModel {
  /**
   * javascript编辑器
   */
  late Editor _javascriptEditor;

  /**
   * 获取javascript编辑器中的代码
   */
  get javascriptCode => _javascriptEditor.document.value;

  /**
   * json编辑器
   */
  late Editor _jsonEditor;

  /**
   * 获取json编辑器中的代码
   */
  get jsonCode => _jsonEditor.document.value;

  /**
   * fairDsl预览IFrame
   */
  late html.IFrameElement _frame;

  /**
   * 预览的url
   */
  String _fairDslPreviewUrl = '';

  /**
   * 设置预览的url
   */
  set fairDslPreviewUrl(String url) {
    _fairDslPreviewUrl = url;
    _frame.src = _fairDslPreviewUrl;
  }

  FairDslViewerType get fairDslViewerType => _fairDslViewerType;
  FairDslViewerType _fairDslViewerType = FairDslViewerType.JSON;

  set fairDslViewerType(FairDslViewerType value) {
    _fairDslViewerType = value;
    notifyListeners();
  }

  GetFairDslListResponse fairDslListResponse = GetFairDslListResponse();

  int _currentSelectIndex = 0;

  set currentSelectIndex(int index) {
    _currentSelectIndex = index;
    notifyListeners();
  }

  int get currentSelectIndex => _currentSelectIndex;

  List<DeviceData> _devices = COMMON_DEVICES;

  List<DeviceData> get devices => _devices;

  set devices(List<DeviceData> devices) {
    _devices = devices;
    notifyListeners();
  }

  DeviceData _currentDeviceData = COMMON_DEVICES[0];

  DeviceData get currentDeviceData => _currentDeviceData;

  set currentDeviceData(DeviceData deviceData) {
    _currentDeviceData = deviceData;
    notifyListeners();
  }

  bool _isConsolePanelShow = false;

  get isConsolePanelShow => _isConsolePanelShow;

  set isConsolePanelShow(value) {
    _isConsolePanelShow = value;
    notifyListeners();
  }

  bool _isBuilding = false;

  get isBuilding => _isBuilding;

  set isBuilding(value) {
    _isBuilding = value;
    notifyListeners();
  }

  bool _isRunning = false;

  get isRunning => _isRunning;

  set isRunning(value) {
    _isRunning = value;
    notifyListeners();
  }

  ConsoleMessageList consoleMessageList = ConsoleMessageList([]);

  void _showOutput(String message, {bool error = false}) {
    consoleMessageList = ConsoleMessageList(
        consoleMessageList.value..add(ConsoleMessage(message, error)));
    notifyListeners();
  }

  void clearOutput() {
    consoleMessageList = ConsoleMessageList([]);
    notifyListeners();
  }

  Future<void> getFairDslList(BuildContext context) async {
    try {
      final response = await dartServices
          .getFairDslList(CommonRequest())
          .timeout(serviceCallTimeout);
      fairDslListResponse = response;
      notifyListeners();
      getCurrentFairDsl(context);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCurrentFairDsl(BuildContext context) async {
    var currentPage = context.read<DartEditorModel>().currentPagePath;
    var jsonPath = '';
    var jsPath = '';
    if (fairDslListResponse.result.length > _currentSelectIndex) {
      var selectedItem = fairDslListResponse.result[_currentSelectIndex];
      jsonPath = selectedItem.jsonPath;
      jsPath = selectedItem.jsPath;
    }
    getFairDsl(currentPage, jsonPath, jsPath);
  }

  Future<void> getFairDsl(
      String currentPage, String jsonPath, String jsPath) async {
    try {
      final request = GetFairDslRequest()
        ..pageName = currentPage
        ..jsonPath = jsonPath
        ..jsPath = jsPath;
      final response =
          await dartServices.getFairDsl(request).timeout(serviceCallTimeout);
      _jsonEditor.document.value = response.json;
      _jsonEditor.resize();
      var jsVal = response.js;
      var jsValFormat = js.context.callMethod('js_beautify', [jsVal, 1, '\t']);
      _javascriptEditor.document.value = jsValFormat;
      _javascriptEditor.resize();
    } catch (e) {
      print(e);
    }
  }

  /**
   * 初始化javascript编辑器
   */
  Editor initJavascriptEditor(String viewType) {
    final html.HtmlElement element = html.DivElement();
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      return element;
    });
    // Set up CodeMirror
    return _javascriptEditor =
        codeMirrorFactory.createFromElement(element, options: codeMirrorOptions)
          ..theme = 'darkpad'
          ..mode = 'javascript'
          ..readOnly = true
          ..showLineNumbers = true;
  }

  /**
   * 初始化json编辑器
   */
  Editor initJsonEditor(String viewType) {
    final html.HtmlElement element = html.DivElement();
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      return element;
    });
    // Set up CodeMirror
    return _jsonEditor =
        codeMirrorFactory.createFromElement(element, options: codeMirrorOptions)
          ..theme = 'darcula'
          ..mode = 'application/json'
          ..readOnly = true
          ..showLineNumbers = true;
  }

  /**
   * 初始化Fair Dsl预览的IFrame
   */
  void initFairDslPreviewFrame(String viewType) {
    // Set up the iframe.
    _frame = html.IFrameElement()..style.border = 'none';
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      return _frame;
    });
  }

  Future<bool> handleFairCompile(BuildContext context) async {
    if (isBuilding) {
      return false;
    }
    isBuilding = true;
    final compileRequest = CompileRequest()..source = 'fullDartSource';
    try {
      await dartServices
          .fairCompile(compileRequest)
          .timeout(Duration(seconds: 3 * 60));
      getFairDslList(context);
      clearOutput();
      return true;
    } catch (e) {
      final message = e is ApiRequestError ? e.message : '$e';
      clearOutput();
      _showOutput('Error compiling... \n$message', error: true);
      if (!isConsolePanelShow) {
        isConsolePanelShow = true;
      }
      return false;
    } finally {
      isBuilding = false;
    }
  }

  Future<String> handleFairRun() async {
    if (isRunning) {
      return '';
    }
    isRunning = true;
    final compileRequest = CompileRequest()..source = 'fullDartSource';
    try {
      final response = await dartServices
          .fairRun(compileRequest)
          .timeout(Duration(seconds: 3 * 60));
      clearOutput();
      return response.result;
    } catch (e) {
      final message = e is ApiRequestError ? e.message : '$e';
      clearOutput();
      _showOutput('Error running... \n$message', error: true);
      if (!isConsolePanelShow) {
        isConsolePanelShow = true;
      }
      return '';
    } finally {
      isRunning = false;
    }
  }
}
