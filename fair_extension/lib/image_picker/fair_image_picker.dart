import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class FairImagePicker extends IFairPlugin {
  static final FairImagePicker _fairImagePicker = FairImagePicker._internal();
  static const String photo = 'photo';
  static const String album = 'album';

  FairImagePicker._internal();

  factory FairImagePicker() {
    return _fairImagePicker;
  }

  static Future<dynamic> getImage(
      {required String type,
      void Function(String resp)? success,
      void Function()? failure}) async {
    // 空实现，仅用dart端占位（实现见fair_image_picker.js）
  }

  static Future<dynamic> _getImage(dynamic map) async {
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
    var imagePath;
    if (photo == type) {
      imagePath = await _onImageButtonPressed(ImageSource.camera);
    } else if (album == type) {
      imagePath = await _onImageButtonPressed(ImageSource.gallery);
    }
    //需要判断发起方的请求是dart端还是js端
    if (isDart) {
      if (imagePath != null) {
        successCallback?.call(imagePath);
      } else {
        failureCallback?.call();
      }
    } else {
      var resp = {
        //pageName必传，因为每个pageName代表不同页面的作用域
        'pageName': pageName,
        'args': {
          'callId': callId,
          'imagePath': imagePath,
        }
      };
      return Future.value(jsonEncode(resp));
    }

    return Future.value();
  }

  static Future<String> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    final pickedFile = await _getPicker().getImage(
      source: source,
    );
    //获取照片路径成功
    return Future.value(pickedFile?.path);
  }

  static ImagePicker? _picker;

  static ImagePicker _getPicker() {
    _picker ??= ImagePicker();
    return _picker!;
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('getImage', () => _getImage);
    return functions;
  }
}
