/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';
import 'dart:developer';

import 'package:fair/src/runtime/fair_runtime_impl.dart';
import 'package:fair/src/runtime/plugin/plugin_dispatcher.dart';

abstract class FairMessageCallback<T> {
  void call(T t);

  String getMessageKey();
}

/// 分发不同FairWidget的消息
class FairHandler {
  final pageHistories = <String, FairMessageCallback<String>>{};
  final Runtime _runtime;

  FairHandler(this._runtime) {
    //接收native发送过来的消息，实际上是js发送的消息，通过native端透传过来
    _runtime.getChannel().setMessageHandler((String? message) {
      var data = json.decode(message??'');
      var funcName = data['funcName']?.toString();
      var pageName = data['pageName'];
      var args = data['args'];

      if (funcName == null || funcName.isEmpty) {
        return '';
      }

      //当用户调用setState的时候相当于刷新了数据，通知刷新页更新
      if (funcName == 'setState') {
        _dispatchMessage(pageName, jsonEncode(args));
        return '';
      }

      // //js 异步调用dart中的相关方法
      // if (funcName == 'invokePlugin') {
      //   FairPluginDispatcher.dispatch(jsonEncode(args))
      //       .then((value) => _runtime.getChannel().sendCommonMessage(value));
      //   return '';
      // }
      return '';
    });
  }

  String _dispatchMessage(String pageName, String message) {
    pageHistories[pageName]?.call(message);
    return 'Reply from Dart';
  }

  void register(FairMessageCallback<String> state) {
    log('register state: ${state.getMessageKey}');
    pageHistories[state.getMessageKey()] = state;
  }

  void unregister(FairMessageCallback<String> state) {
    var key = state.getMessageKey();
    log('unregister state: $key');
    pageHistories.remove(key);
  }
}
