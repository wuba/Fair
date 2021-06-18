import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX
import 'package:ffi/ffi.dart';

import 'fair_runtime_declaration.dart';

final DynamicLibrary dl = Platform.isAndroid
    ? DynamicLibrary.open("libfairflutter.so")
    : DynamicLibrary.open("FairFFI.framework/FairFFI");

class FairRuntimeImpl implements IRuntime {
  static final FairRuntimeImpl _runtime = FairRuntimeImpl._internal();
  final _callBacks = <String, RuntimeCallback>{};

  @override
  void bindCallback(String key, RuntimeCallback callback) {
    _callBacks[key] = callback;
  }

  factory FairRuntimeImpl() {
    return _runtime;
  }

  BasicMessageChannel<String> _channel;
  Pointer<Utf8> Function(Pointer<Utf8>) invokeJSCommonFuncSync = dl
      .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
          'invokeJSCommonFuncSync')
      .asFunction();

  //为了测试Android
  FairRuntimeImpl._internal() {
    init(true);
    _channel ??=
        BasicMessageChannel('com.wuba.fair/loaderAndroid', StringCodec());

    _channel.setMessageHandler((String message) async {
      var data = json.decode(message);
      var className = data['className'];
      var call = _callBacks[className];
      call?.call(message);

      return 'success';
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

  BasicMessageChannel<String> getChannel() {
    return _channel;
  }

  @override
  void addScript(String script) {}

  @override
  Future<dynamic> executeScript(String pageName, String script) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.JS] = script;
    var msg = FairMessage(pageName, FairMessage.EVALUATE, map);
    var from = msg.from();
    var reply =
        Utf8.fromUtf8(invokeJSCommonFuncSync(Utf8.toUtf8(jsonEncode(from))));
    return Future.value(reply);
  }

  @override
  Map<String, String> executeScriptSync(String pageName, String script) {
    var map = <dynamic, dynamic>{};
    map[FairMessage.JS] = script;
    var msg = FairMessage(pageName, FairMessage.VARIABLE, map);
    var from = msg.from();
    final Map<String, dynamic> reMap = jsonDecode(
        Utf8.fromUtf8(invokeJSCommonFuncSync(Utf8.toUtf8(jsonEncode(from)))));
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
    var reply = _channel.send(jsonEncode(from));
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
    return Utf8.fromUtf8(invokeJSCommonFuncSync(Utf8.toUtf8(jsonEncode(from))));
  }

  @override
  Future<String> variables(
      String pageName, Map<dynamic, dynamic> variableNames) {
    var msg = FairMessage(pageName, FairMessage.VARIABLE, variableNames);
    var reply = _channel.send(jsonEncode(msg.from()));
    return Future.value(reply);
  }

  @override
  String variablesSync(String pageName, Map<dynamic, dynamic> variableNames) {
    var msg = FairMessage(pageName, FairMessage.VARIABLE, variableNames);
    var from = msg.from();
    return Utf8.fromUtf8(invokeJSCommonFuncSync(Utf8.toUtf8(jsonEncode(from))));
  }
}
