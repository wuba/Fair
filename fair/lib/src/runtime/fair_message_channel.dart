import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

typedef VoidMsgCallback = void Function();
typedef StringMsgCallback = void Function(String msg);

final DynamicLibrary dl = Platform.isAndroid
    ? DynamicLibrary.open('libfairflutter.so')
    : DynamicLibrary.open('FairFFI.framework/FairFFI');

final String JS_LOADER = 'com.wuba.fair/js_loader';
final String COMMON_MESSAGE_CHANNEL = 'com.wuba.fair/common_message_channel';

class FairMessageChannel {
  // Pointer<Utf8> Function(Pointer<Utf8>) invokeJSCommonFuncSync = dl
  //     .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
  //         'invokeJSCommonFuncSync')
  //     .asFunction();
  Pointer<Utf8> Function(Pointer<Utf8>) invokeJSCommonFuncSync = null;

  BasicMessageChannel<String> _commonChannel;
  MethodChannel _methodChannel;

  factory FairMessageChannel() {
    return _msg;
  }

  static final FairMessageChannel _msg = FairMessageChannel._internal();

  FairMessageChannel._internal() {
    _initMessageChannel();
  }

  void _initMessageChannel() {
    _commonChannel ??=
        BasicMessageChannel(COMMON_MESSAGE_CHANNEL, StringCodec());
    _methodChannel ??= MethodChannel(JS_LOADER);

    _commonChannel.setMessageHandler((String message) async {
      _callback?.call(message);
      return 'reply from dart';
    });

    _methodChannel.setMethodCallHandler((call) async {});
  }

  StringMsgCallback _callback;

  void setMessageHandler(StringMsgCallback callback) {
    _callback = callback;
  }

  Future<dynamic> loadJS(String path, StringMsgCallback callback) {
    return _methodChannel.invokeMethod('loadMainJs',path);
  }

  Future<dynamic> release(VoidMsgCallback callback) {
    return _methodChannel.invokeMethod('releaseMainJs');
  }

  Future<String> sendCommonMessage(dynamic msg) async {
    return _commonChannel.send(msg);
  }

  dynamic sendCommonMessageSync(dynamic msg) =>
      invokeJSCommonFuncSync.call(msg);
}
