/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';
import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

/// 拍摄照片
class FairPhotoSelector extends IFairPlugin {
  static final FairPhotoSelector _photoSelector = FairPhotoSelector._internal();

  FairPhotoSelector._internal();

  factory FairPhotoSelector() {
    return _photoSelector;
  }

  Future<dynamic> getPhoto(dynamic map) async {
    // {
    //   'className': 'PhotoSelector#getPhoto',
    //   'funcName': 'invokePlugin',
    //   'pageName': '页面名称',
    //   'args': {
    //     //用户自定义的参数
    //   }
    // }

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
    var successCallback = args['success'];
    var failureCallback = args['failure'];
    var type = args['type'];
    //用户可以自定义参数，通过参数确定图片的选择方式
    var photoPath;
    if ('photo' == type) {
      photoPath = await _onImageButtonPressed(ImageSource.camera);
    } else if ('album' == type) {
      photoPath = await _onImageButtonPressed(ImageSource.gallery);
    } else {
      //no-op
    }
    //需要判断发起方的请求是dart端还是js端
    if (isDart) {
      if (photoPath != null) {
        successCallback?.call(photoPath);
      } else {
        failureCallback?.call();
      }
    } else {
      var resp = {
        //pageName必传，因为每个pageName代表不同页面的作用域
        'pageName': pageName,
        'args': {
          'callId': callId,
          'photoPath': photoPath,
        }
      };
      return Future.value(jsonEncode(resp));
    }

    return Future.value();
  }

  Future<String> _onImageButtonPressed(ImageSource source,
      {BuildContext context}) async {
    final pickedFile = await _getPicker().getImage(
      source: source,
    );
    //获取照片路径成功
    return Future.value(pickedFile?.path);
  }

  ImagePicker _picker;

  ImagePicker _getPicker() {
    _picker ??= ImagePicker();
    return _picker;
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('getPhoto', () => getPhoto);
    return functions;
  }
}
