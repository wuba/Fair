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

  dynamic photoPermission(par) async {
    print('WBPermission.photoPermission$par');
    var requestPar = jsonDecode(par);
    var args = requestPar['args'];
    var pageName = requestPar['pageName'];
    var id = args['id'];

    var responseMap = {
      'id': id,
      'pageName': pageName,
    };
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted) {
        responseMap['data'] = 'Granted';
      } else {
        responseMap['data'] = 'Restricted';
      }
    } else {
      if (await Permission.storage.request().isGranted) {
        responseMap['data'] = 'Granted';
      } else {
        responseMap['data'] = 'Restricted';
      }
    }
    return Future.value(jsonEncode(responseMap));
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('photoPermission', () => photoPermission);
    return functions;
  }
}
