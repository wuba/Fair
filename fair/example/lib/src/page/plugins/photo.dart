import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fair/fair.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

mixin PhotoPlugin implements FairCommonPluginMixin {
  Future<dynamic> selectPhoto(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          var type = requestMap['type'];
          var photoPath;
          if ('photo' == type) {
            photoPath = await _onImageButtonPressed(ImageSource.camera);
          } else if ('album' == type) {
            photoPath = await _onImageButtonPressed(ImageSource.gallery);
          } else {
            //no-op
          }

          return {
            'photoPath': photoPath,
          };
        },
      );
  Future<String> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    final pickedFile = await _getPicker().getImage(
      source: source,
    );
    //获取照片路径成功
    return Future.value(pickedFile?.path);
  }

  ImagePicker? _picker;

  ImagePicker _getPicker() {
    _picker ??= ImagePicker();
    return _picker!;
  }
}
