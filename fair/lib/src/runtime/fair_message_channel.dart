/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:fair/src/runtime/plugin/plugin_dispatcher.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

typedef VoidMsgCallback = void Function();
typedef StringMsgCallback = String? Function(String? msg);

final DynamicLibrary dl = Platform.isAndroid
    ? DynamicLibrary.open('libfairflutter.so')
    : DynamicLibrary.open('FairDynamicFlutter.framework/FairDynamicFlutter');

final String JS_LOADER = 'com.wuba.fair/js_loader';
final String COMMON_MESSAGE_CHANNEL = 'com.wuba.fair/common_message_channel';

class FairMessageChannel {
  Pointer<Utf8> Function(Pointer<Utf8>) invokeJSCommonFuncSync = dl
      .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
          'invokeJSCommonFuncSync')
      .asFunction();

  BasicMessageChannel<String>? _commonChannel;
  MethodChannel? _methodChannel;

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

    _commonChannel!.setMessageHandler((String? message) async {
      print('来自native端的消息：$message');
      //js 异步调用dart中的相关方法
      var data = json.decode(message??'');
      var funcName = data['funcName']?.toString();

      if (funcName == 'invokePlugin') {
        var p = await FairPluginDispatcher.dispatch(message);
        return p;
      }

      _callback?.call(message);
      return 'reply from dart';
    });

    _methodChannel!.setMethodCallHandler((call) async {});
  }

  StringMsgCallback? _callback;

  void setMessageHandler(StringMsgCallback callback) {
    _callback = callback;
  }

  Future<dynamic> loadJS(String args, StringMsgCallback? callback) {
    return _methodChannel!.invokeMethod('loadMainJs', args);
  }

  Future<dynamic> release(String args, VoidMsgCallback? callback) {
    return _methodChannel!.invokeMethod('releaseMainJs', args);
  }

  Future<String?> sendCommonMessage(dynamic msg) async {
    return _commonChannel!.send(msg);
  }

  dynamic sendCommonMessageSync(dynamic msg) =>
      invokeJSCommonFuncSync.call(msg);
}
