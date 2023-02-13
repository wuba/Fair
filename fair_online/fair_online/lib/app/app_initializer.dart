import 'package:fair_online/editor/core/dependencies.dart';
import 'package:fair_online/editor/core/keys.dart';
import 'package:fair_online/editor/modules/dartservices_module.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/utils/sp_util.dart';
import 'package:flutter/foundation.dart';
import 'package:http/browser_client.dart';

const DEBUG_URL = 'http://127.0.0.1:8082/service/';
// TODO set release url
const RELEASE_URL = '';

class AppInitializer {
  void init() {
    Dependencies.setGlobalInstance(Dependencies());
    _initDartServices();
    //初始化web按键监听
    deps[Keys] = Keys();
  }

  void _initDartServices() {
    final client = SanitizingBrowserClient();
    deps[BrowserClient] = client;
    deps[DartservicesApi] =
        DartservicesApi(client, rootUrl: kDebugMode ? DEBUG_URL : RELEASE_URL);
  }

  static bool hasVisited() {
    var hasVisited = SPUtil.getBool('hasVisited');
    if (hasVisited ?? false) {
      return true;
    } else {
      SPUtil.setBool('hasVisited', true);
      return false;
    }
  }
}
