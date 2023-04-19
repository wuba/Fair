import 'package:fair/fair.dart';
import 'package:fair_extension/image_picker/fair_image_picker.dart';
import 'package:fair_extension/navigator/fair_navigator_plugin.dart';
import 'package:fair_extension/net/fair_net_plugin.dart';
import 'package:flutter/widgets.dart';

import 'log/log.dart';
import 'permission/fair_permission_plugin.dart';
import 'toast/fair_toast_plugin.dart';
import 'url_launcher/fair_url_launcher_plugin.dart';

class FairExtension {

  /// global key for fair navigator plugin
  static final GlobalKey<NavigatorState> fairNavigatorKey = GlobalKey(debugLabel: 'fair_navigator');

  /// plugin dart config
  static final plugins = <String, IFairPlugin>{
    'FairLog': FairLog(),
    'FairPermission': FairPermission(),
    'FairImagePicker': FairImagePicker(),
    'FairToast': FairToast(),
    'FairUrlLauncher': FairUrlLauncher(),
    'FairNet': FairNet(),
    'FairNavigator': FairNavigator(),
  };

  /// plugin js config
  static final jsPlugins = <String, String>{
    'fair_log': 'packages/fair_extension/assets/plugin/fair_log_plugin.js',
    'fair_permission':
        'packages/fair_extension/assets/plugin/fair_permission.js',
    'fair_photo_selector':
        'packages/fair_extension/assets/plugin/fair_image_picker.js',
    'fair_toast': 'packages/fair_extension/assets/plugin/fair_toast_plugin.js',
    'fair_url_launcher':
        'packages/fair_extension/assets/plugin/fair_url_launcher_plugin.js',
    'fair_net': 'packages/fair_extension/assets/plugin/fair_net_plugin.js',
    'fair_navigator': 'packages/fair_extension/assets/plugin/fair_navigator_plugin.js'
  };

  /// register dart plugin
  static void registerPlugin(String key, IFairPlugin plugin) {
    plugins[key] = plugin;
  }

  /// register dart plugins
  static void registerPlugins(Map<String, IFairPlugin>? plugins) {
    if (plugins == null || plugins.isEmpty) {
      return;
    }
    FairExtension.plugins.addAll(plugins);
  }

  /// register js plugin
  static void registerJsPlugin(String key, String js) {
    jsPlugins[key] = js;
  }

  /// register js plugins
  static void registerJsPlugins(Map<String, String>? plugins) {
    if (plugins == null || plugins.isEmpty) {
      return;
    }
    jsPlugins.addAll(plugins);
  }
}
