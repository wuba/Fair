import 'dart:convert';

import 'fair_plugin.dart';

class FairPluginDispatcher {
  static final pluginMap = <String, IFairPlugin>{};

  static dynamic dispatch(dynamic msg) {
    var obj = jsonDecode(msg);
    var className = obj['className']?.toString();

    if (className == null || className.isEmpty) {
      return null;
    }

    if (pluginMap[className] != null) {
      pluginMap[className].invoke(msg);
      return null;
    }
  }
}
