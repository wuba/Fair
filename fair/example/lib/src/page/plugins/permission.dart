import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fair/fair.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

mixin PermissionPlugin implements FairCommonPluginMixin {
  static final String Permission_Photo = 'Permission_Photo';
  static final String Permission_Phone = 'Permission_Phone';
  static final String Permission_Audio = 'Permission_Audio';
  Future<dynamic> requestPermission(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          var GrantedCallback = requestMap['Granted'];
          var RestrictedCallback = requestMap['Restricted'];
          var isGranted = false;
          var type = requestMap['type'];
          if (Permission_Photo == type) {
            if (!kIsWeb && Platform.isIOS) {
              isGranted = await Permission.photos.request().isGranted;
            } else {
              isGranted = await Permission.storage.request().isGranted;
            }
          }

          return {
            'isGranted': isGranted,
          };
        },
      );
}
