import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX
import 'package:ffi/ffi.dart';

import 'fair_message_channel.dart';
import 'fair_runtime_declaration.dart';

class Runtime implements IRuntime {
  final loadBaseJsConstant = [false];
  static final Runtime _runtime = Runtime._internal();
  final _callBacks = <String, RuntimeCallback>{};

  @override
  void bindCallback(String key, RuntimeCallback callback) {
    _callBacks[key] = callback;
  }

  factory Runtime() {
    return _runtime;
  }

  FairMessageChannel _channel;

  Runtime._internal() {
    init(true);

    _channel ??= FairMessageChannel();
    //接收setState()的信息
    _channel.setMessageHandler((message) {
      var data = json.decode(message);
      var className = data['pageName'];
      var call = _callBacks[className];
      call?.call(message);
      return null;
    });
  }

  @override
  void init(bool isDebug) {}

  @override
  void release(String pageName) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.FUNC_NAME] = FairMessage.RELEASE_JS;
    var msg = FairMessage(pageName, FairMessage.METHOD, map);
    _channel.release(jsonEncode(msg.from()), null);
  }

  @override
  Future<String> version() {
    return Future.value('{\'version\' : \'1.0.0\'}');
  }

  FairMessageChannel getChannel() {
    return _channel;
  }

  @override
  Future<dynamic> addScript(
      String pageName, String script, dynamic props) async {
    var scriptSource = await rootBundle.loadString(script);
    var fairProps;
    if (props != null && props['fairProps'] != null) {
      fairProps = props['fairProps'];
    } else {
      fairProps = '{}';
    }
    scriptSource =
        scriptSource.replaceFirst(new RegExp(r'#FairProps#'), fairProps);
    scriptSource =
        scriptSource.replaceAll(new RegExp(r'#FairKey#'), pageName);
    var map = <dynamic, dynamic>{};
    map[FairMessage.PATH] = scriptSource;
    map[FairMessage.PAGE_NAME] = pageName;
    //添加base js
    // await loadCoreJs();

    return _channel.loadJS(jsonEncode(map), null);
  }

  @override
  Future<dynamic> executeScript(String pageName, String script) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.LOAD_JS] = script;
    var msg = FairMessage(pageName, FairMessage.EVALUATE, map);
    var from = msg.from();
    var reply = Utf8.fromUtf8(
        _channel.sendCommonMessageSync(Utf8.toUtf8(jsonEncode(from))));
    return Future.value(reply);
  }

  @override
  Map<String, String> executeScriptSync(String pageName, String script) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.LOAD_JS] = script;
    var msg = FairMessage(pageName, FairMessage.VARIABLE, map);
    var from = msg.from();
    final Map<String, dynamic> reMap = jsonDecode(Utf8.fromUtf8(
        _channel.sendCommonMessageSync(Utf8.toUtf8(jsonEncode(from)))));
    return reMap;
  }

  @override
  Future<String> invokeMethod(
      String pageName, String funcName, List<dynamic> parameters) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.FUNC_NAME] = funcName;
    map[FairMessage.ARGS] = parameters;
    var msg = FairMessage(pageName, FairMessage.METHOD, map);
    var from = msg.from();
    var reply = _channel.sendCommonMessage(jsonEncode(from));
    // reply.then((value) => print('来自Native端的消息invokeMethod${value}'));

    return Future.value(reply);
  }

  @override
  String invokeMethodSync(
      String pageName, String funcName, List<dynamic> parameters) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.FUNC_NAME] = funcName;
    map[FairMessage.ARGS] = parameters;
    var msg = FairMessage(pageName, FairMessage.METHOD, map);
    var from = msg.from();
    return Utf8.fromUtf8(
        _channel.sendCommonMessageSync(Utf8.toUtf8(jsonEncode(from))));
  }

  @override
  Future<String> variables(
      String pageName, Map<dynamic, dynamic> variableNames) {
    var msg = FairMessage(pageName, FairMessage.VARIABLE, variableNames);
    var reply = _channel.sendCommonMessage(jsonEncode(msg.from()));
    return Future.value(reply);
  }

  @override
  String variablesSync(String pageName, Map<dynamic, dynamic> variableNames) {
    var msg = FairMessage(pageName, FairMessage.VARIABLE, variableNames);
    var from = msg.from();
    return Utf8.fromUtf8(
        _channel.sendCommonMessageSync(Utf8.toUtf8(jsonEncode(from))));
  }

  @override
  Map getBindVariableAndFuncSync(String pageName) {
    return jsonDecode(invokeMethodSync(pageName, 'getAllJSBindData', null));
  }

  @override
  Future<Map> getBindVariableAndFunc(String pageName) async {
    var r = await invokeMethod(pageName, 'getAllJSBindData', null);
    return Future.value(jsonDecode(r));
  }

  /*
   * 加载用户的基础配置 //todo 单线程模型修改是否会出现值不同步问题
   */
  Future<dynamic> loadCoreJs() async {
    //如果没有加载过js
    var map = <dynamic, dynamic>{};
    if (!loadBaseJsConstant[0]) {
      //用户配置的脚本，里面包含core_js以及用户的拓展
      var configJson =
          await rootBundle.loadString('assets/fair_basic_config.json');
      var basicConfig = jsonDecode(configJson);
      var path = basicConfig['coreJs']['path'];
      //加载基础js
      var baseJsSource = await rootBundle.loadString(path);
      //加载用户自定义的plugin
      var pluginJsSource = ' ';
      Map plugins = basicConfig['plugin'];

      if (plugins != null) {
        Iterable<String> keys = plugins.keys;
        for (var k in keys) {
          pluginJsSource =
              pluginJsSource + '  ' + await rootBundle.loadString(plugins[k]);
        }
      }
      loadBaseJsConstant[0] = true;
      map[FairMessage.PATH] = baseJsSource + ' ' + pluginJsSource;
      map[FairMessage.PAGE_NAME] = 'loadCoreJs';
    }

    if (map.isEmpty) {
      return Future.value(null);
    }
    return _channel.loadJS(jsonEncode(map), null);
  }
}
