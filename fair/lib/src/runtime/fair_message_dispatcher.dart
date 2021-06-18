import 'dart:convert';
import 'dart:developer';

import 'package:fair/src/runtime/fair_runtime_impl.dart';

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
      return _dispatchMessage(message);
    });
  }

  String _dispatchMessage(String message) {
    var data = json.decode(message);
    var pageName = data['pageName'];
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
