import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX
import 'package:ffi/ffi.dart';

import 'fair_message_channel.dart';
import 'fair_runtime_declaration.dart';

class Runtime implements IRuntime {
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

    _channel.setMessageHandler((message) {
      var data = json.decode(message);
      var className = data['className'];
      var call = _callBacks[className];
      call?.call(message);
    });
  }

  @override
  void init(bool isDebug) {}

  @override
  void release() {}

  @override
  Future<String> version() {
    return Future.value('{\'version\' : \'1.0.0\'}');
  }

  FairMessageChannel getChannel() {
    return _channel;
  }

  @override
  Future<dynamic> addScript(String script) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.PATH] = script;
    var msg = FairMessage(null, FairMessage.LOAD_JS, map);
    return _channel.loadJS(jsonEncode(msg.from()), null);
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
}
