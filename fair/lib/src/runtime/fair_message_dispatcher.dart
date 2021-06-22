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
    _runtime.getChannel().setMessageHandler((String message) {
      var data = json.decode(message);
      var funcName = data['funcName']?.toString();
      var pageName = data['pageName'];
      var args = data['args'];

      if (funcName == null || funcName.isEmpty) {
        return 'error';
      }

      //当用户调用setData的时候相当于刷新了数据，通知刷新页更新
      if (funcName == 'setData') {
        _dispatchMessage(pageName, jsonEncode(args));
        return 'success';
      }

      //js 异步调用dart中的相关方法
      if (funcName == 'invokePlugin') {
        return FairPluginDispatcher.dispatch(jsonEncode(args));
      }

      return null;
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
