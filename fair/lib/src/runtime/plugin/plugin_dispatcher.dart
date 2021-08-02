/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

import 'fair_plugin.dart';

class FairPluginDispatcher {
  static final pluginMap = <String, IFairPlugin>{};

  static Future<dynamic> dispatch(dynamic msg) async {
    dynamic obj;
    if (msg is Map) {
      obj = msg;
    } else {
      obj = jsonDecode(msg);
    }
    // var args = obj['args'];
    var className = obj['className']?.toString();

    if (className == null || className.isEmpty) {
      return null;
    }

    if (className.contains('#')) {
      className = className.split('#')[0];
    }

    if (pluginMap[className] != null) {
      // var d = await ;
      return pluginMap[className]?.invoke(msg);
    }
  }

  static void registerPlugin(String key, IFairPlugin plugin) {
    pluginMap[key] = plugin;
  }

  static void registerPlugins(Map<String, IFairPlugin> plugins) {
    pluginMap.addAll(plugins);
  }
}
