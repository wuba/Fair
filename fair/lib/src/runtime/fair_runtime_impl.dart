/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';
import 'package:fair/fair.dart';
import 'package:flutter/services.dart';
import 'fair_message_channel.dart' if (dart.library.html) 'fair_message_channel_web.dart';
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

  MethodChannel getBasicChannel(){
    return _channel!.basicMethodChannel!;
  }

  FairMessageChannel? _channel;

  Runtime._internal() {
    init(true);

    _channel ??= FairMessageChannel();
    //接收setState()的信息
    _channel!.setMessageHandler((message) {
      var data = json.decode(message ?? '');
      var className = data['pageName'];
      var call = _callBacks[className];
      call?.call(message);
      return null;
    });
  }

  void setJsLoadListener(){

  }

  @override
  void init(bool isDebug) {}

  @override
  void release(String? pageName) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.FUNC_NAME] = FairMessage.RELEASE_JS;
    var msg = FairMessage(pageName, FairMessage.METHOD, map);
    _channel?.release(jsonEncode(msg.from()), null);
  }

  @override
  Future<String> version() {
    return Future.value('{\'version\' : \'1.0.0\'}');
  }

  FairMessageChannel getChannel() {
    return _channel!;
  }

  @override
  Future<dynamic> addScript(String pageName, String scriptSource, dynamic props) async {
    // var scriptSource = await rootBundle.loadString(script);
    var fairProps;
    if (props != null && props['fairProps'] != null) {
      fairProps = props['fairProps'];
    } else {
      fairProps = '{}';
    }
    scriptSource = scriptSource.replaceFirst(RegExp(r'#FairProps#'), fairProps);
    scriptSource = scriptSource.replaceAll(RegExp(r'#FairKey#'), pageName);
    var map = <dynamic, dynamic>{};
    map[FairMessage.PATH] = scriptSource;
    map[FairMessage.PAGE_NAME] = pageName;
    return _channel!.loadJS(jsonEncode(map), null);
  }

  @override
  Future<dynamic> executeScript(String pageName, String script) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.LOAD_JS] = script;
    var msg = FairMessage(pageName, FairMessage.EVALUATE, map);
    var from = msg.from();
    var reply = _channel!.sendCommonMessageSync(jsonEncode(from));
    return Future.value(reply);
  }

  @override
  Map<String, String> executeScriptSync(String pageName, String script) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.LOAD_JS] = script;
    var msg = FairMessage(pageName, FairMessage.VARIABLE, map);
    var from = msg.from();
    final Map<String, String> reMap = jsonDecode(_channel!.sendCommonMessageSync(jsonEncode(from)));
    return reMap;
  }

  @override
  Future<String> invokeMethod(String pageName, String funcName, List<dynamic>? parameters) async {
    var map = <dynamic, dynamic>{};
    map[FairMessage.FUNC_NAME] = funcName;
    map[FairMessage.ARGS] = parameters;
    var msg = FairMessage(pageName, FairMessage.METHOD, map);
    var from = msg.from();
    var reply = _channel!.sendCommonMessage(jsonEncode(from));
    return await reply ?? '';
  }

  @override
  String invokeMethodSync(String pageName, String funcName, List<dynamic>? parameters) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.FUNC_NAME] = funcName;
    map[FairMessage.ARGS] = parameters;
    var msg = FairMessage(pageName, FairMessage.METHOD, map);
    var from = msg.from();
    return _channel!.sendCommonMessageSync(jsonEncode(from));
  }

  @override
  Future<String> variables(String pageName, Map<dynamic, dynamic> variableNames) async{
    var msg = FairMessage(pageName, FairMessage.VARIABLE, variableNames);
    var reply = _channel!.sendCommonMessage(jsonEncode(msg.from()));
    return await reply ?? '';
  }

  @override
  String variablesSync(String pageName, Map<dynamic, dynamic> variableNames) {
    var msg = FairMessage(pageName, FairMessage.VARIABLE, variableNames);
    var from = msg.from();
    return _channel!.sendCommonMessageSync(jsonEncode(from));
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
   * 加载用户的基础配置
   */
  Future<dynamic> loadCoreJs() async {
    var map = <dynamic, dynamic>{};
    if (!loadBaseJsConstant[0]) {
      var baseJsSource = '';
      /*
       * 读取基础配置内容
       */
      var coreConfigJson = await rootBundle.loadString('packages/fair/assets/fair_home.json');
      var coreConfig = jsonDecode(coreConfigJson)['coreJs'];
      Iterable<String> coreKeys = coreConfig.keys;
      for (var key in coreKeys) {
        baseJsSource += '${await rootBundle.loadString(coreConfig[key])} ;';
      }

      /*
       * 读取用户配置的内容
       * 例如用户配置的插件，或者用户的其它拓展等，该配置json名称固定
       */
      var pluginJsSource = ' ';
      try {
        var customConfigJson = await rootBundle.loadString('assets/fair_basic_config.json');
        var customConfig = jsonDecode(customConfigJson);
        //加载用户自定义的plugin
        Map<String, dynamic>? plugins = customConfig['plugin'];

        if (plugins != null) {
          var keys = plugins.keys;
          for (var k in keys) {
            pluginJsSource = pluginJsSource + ' ; ' + await rootBundle.loadString(plugins[k]);
          }
        }
      } catch (e) {
        //用户可能会自定义js拓展，但是不需要使用dart的功能
        if (FairPluginDispatcher.pluginMap.isNotEmpty) {
          print('##没有配置fair_basic_config.json文件,请检查文件是否配置或者名称是否正确##');
        }
      }
      loadBaseJsConstant[0] = true;
      map[FairMessage.PATH] = baseJsSource + ' ; ' + pluginJsSource;
      map[FairMessage.PAGE_NAME] = 'loadCoreJs';
    }

    if (map.isEmpty) {
      return Future.value(null);
    }
    return _channel!.loadJS(jsonEncode(map), null);
  }
}
