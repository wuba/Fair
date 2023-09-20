import 'dart:convert';
import 'dart:io';

import 'package:fair/fair.dart';
import 'package:permission_handler/permission_handler.dart';

class FairPermission extends IFairPlugin {
  static final FairPermission _fairPermission = FairPermission._internal();
  static const String permissionPhoto = 'Permission_Photo';
  static const String permissionPhone = 'Permission_Phone';
  static const String permissionAudio = 'Permission_Audio';

  FairPermission._internal();

  factory FairPermission() {
    return _fairPermission;
  }

  static Future<dynamic> requestPermission(
      {required String type,
      void Function()? granted,
      void Function()? restricted}) async {
    // 空实现，仅用dart端占位（实现见fair_permission.js）
  }

  static Future<dynamic> _requestPermission(map) async {
    if (map == null) {
      return;
    }
    var req;
    bool isDart;
    if (map is Map) {
      isDart = true;
      req = map;
    } else {
      isDart = false;
      req = jsonDecode(map);
    }
    var pageName = req['pageName'];
    var args = req['args'];
    var callId = args['callId'];
    var grantedCallback = args['granted'];
    var restrictedCallback = args['restricted'];
    var type = args['type'];
    //用户可以自定义参数，通过参数确定图片的选择方式
    var isGranted = false;
    if (permissionPhoto == type) {
      if (Platform.isIOS) {
        isGranted = await Permission.photos.request().isGranted;
      } else {
        isGranted = await Permission.storage.request().isGranted;
      }
    }
    //需要判断发起方的请求是dart端还是js端
    if (isDart) {
      if (isGranted) {
        grantedCallback?.call();
      } else {
        restrictedCallback?.call();
      }
    } else {
      var resp = {
        //pageName必传，因为每个pageName代表不同页面的作用域
        'pageName': pageName,
        'args': {
          'callId': callId,
          'isGranted': isGranted,
        }
      };
      return Future.value(jsonEncode(resp));
    }

    return Future.value();
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('requestPermission', () => _requestPermission);
    return functions;
  }
}
