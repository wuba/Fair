import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// 网络请求自定义插件,是否考虑通过注解标识出来
class WBPermission extends IFairPlugin {
  static final WBPermission _wbPermission = WBPermission._internal();
  static final String Permission_Photo = 'Permission_Photo';
  static final String Permission_Phone = 'Permission_Phone';
  static final String Permission_Audio = 'Permission_Audio';

  WBPermission._internal();

  factory WBPermission() {
    return _wbPermission;
  }

  Future<dynamic> requestPermission(map) async {
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
    var GrantedCallback = args['Granted'];
    var RestrictedCallback = args['Restricted'];
    var type=args['args'];
    //用户可以自定义参数，通过参数确定图片的选择方式
    var isGranted = false;
    if(Permission_Photo==type){
      if (Platform.isIOS) {
        isGranted = await Permission.photos.request().isGranted;
      } else {
        isGranted = await Permission.storage.request().isGranted;
      }
    }
    //需要判断发起方的请求是dart端还是js端
    if (isDart) {
      if (isGranted) {
        GrantedCallback?.call(true);
      } else {
        RestrictedCallback?.call(false);
      }
    } else {
      var resp = {
        //pageName必传，因为每个pageName代表不同页面的作用域
        'pageName': pageName,
        'args': {
          'callId': callId,
          'isGranted': true,
        }
      };
      return Future.value(jsonEncode(resp));
    }

    return Future.value();
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('requestPermission', () => requestPermission);
    return functions;
  }
}
