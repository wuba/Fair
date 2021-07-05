import 'dart:convert';

import 'package:fair/src/runtime/plugin/plugin_dispatcher.dart';

class FairPlugin {
  static int _fairPluginId = 0;
  static final Map<String, List<Function>> _callback = {};

  static void call(Map pluginParameter) {
    var completeCallback = pluginParameter.remove('complete');
    var errorCallback = pluginParameter.remove('error');

    var callId = _fairPluginId++;
    _callback['$callId'] = [completeCallback, errorCallback];

    var reqMap = {};
    try {
      reqMap['funcName'] = 'invokePlugin';
      reqMap['pageName'] = 'pageName';
      reqMap['args'] = {};
      reqMap['args']['args'] = pluginParameter;
      reqMap['args']['className'] = pluginParameter['className'];
      reqMap['args']['id'] = callId;
    } on Exception catch (e) {
      print('参数格式非法: $e');
    }

    FairPluginDispatcher.dispatch(jsonEncode(reqMap)).then((value) {
      var resp = jsonDecode(value);
      if (resp == null) return;
      var respId = '${resp['id']}';
      if (_callback[respId] == null || _callback[respId].isEmpty) {
        return;
      }
      var c = _callback.remove(respId);
      if (c == null) return;
      c[0].call(value);
    });
  }
}
