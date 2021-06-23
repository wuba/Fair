import 'dart:convert';

import 'fair_plugin.dart';

class FairPluginDispatcher {
  static final pluginMap = <String, IFairPlugin>{};

  static Future<dynamic> dispatch(dynamic msg) async {
    var obj = jsonDecode(msg);
    var className = obj['className']?.toString();

    if (className == null || className.isEmpty) {
      return null;
    }

    if (pluginMap[className] != null) {
      var d=await pluginMap[className].invoke(msg);
      return d ;
    }
  }
}
