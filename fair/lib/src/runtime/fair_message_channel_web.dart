/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

@JS()
library fair_core;

import 'dart:convert';
import 'dart:html';

import 'package:fair/src/runtime/plugin/plugin_dispatcher.dart';
import 'package:flutter/services.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

import 'fair_runtime_declaration.dart';

typedef VoidMsgCallback = void Function();
typedef StringMsgCallback = String? Function(String? msg);

class FairMessageChannel {
  factory FairMessageChannel() {
    return _msg;
  }

  static final FairMessageChannel _msg = FairMessageChannel._internal();
  MethodChannel? basicMethodChannel;

  FairMessageChannel._internal() {
    _initMessageChannel();
  }

  void _initMessageChannel() {
    setProperty(
        window, 'jsInvokeFlutterChannel', allowInterop(jsInvokeFlutterChannel));
  }

  /// js调用dart
  Future<void> jsInvokeFlutterChannel(
      String invokeData, StringMsgCallback callback) async {
    var data = json.decode(invokeData);
    var funcName = data['funcName']?.toString();

    if (funcName == 'invokePlugin') {
      var p = await FairPluginDispatcher.dispatch(invokeData);
      return p;
    }
    var result = _callback?.call(invokeData);
    callback.call(result);
  }

  StringMsgCallback? _callback;

  void setMessageHandler(StringMsgCallback callback) {
    _callback = callback;
  }

  Future<dynamic> loadJS(String args, StringMsgCallback? callback) {
    var map = jsonDecode(args);
    if (map[FairMessage.PAGE_NAME] != 'loadCoreJs') {
      var scriptElement = ScriptElement();
      scriptElement.innerText = map[FairMessage.PATH];
      document.head?.children.add(scriptElement);
    }
    return Future.value(null);
  }

  Future<dynamic> release(String args, VoidMsgCallback? callback) {
    return Future.value(null);
  }

  Future<String?> sendCommonMessage(dynamic msg) async {
    dynamic reply = sendCommonMessageSync(msg);
    return Future.value(reply);
  }

  dynamic sendCommonMessageSync(dynamic msg) {
    return invokeJSFunc(msg);
  }
}

@JS('invokeJSFunc')
external dynamic invokeJSFunc(String args);
