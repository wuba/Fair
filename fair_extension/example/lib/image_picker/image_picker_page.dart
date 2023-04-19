import 'dart:io';

import 'package:fair/fair.dart';
import 'package:fair_extension/image_picker/fair_image_picker.dart';
import 'package:fair_extension/permission/fair_permission_plugin.dart';
import 'package:flutter/material.dart';

@FairPatch()
class ImagePickerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImagePickerPageState();
}

class ImagePickerPageState extends State<ImagePickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImagePicker Example'),
      ),
      body: Column(
        children: [
          Sugar.ifEqualBool(isDataEmpty(),
              trueValue: () => Image.network(
                'https://img.58cdn.com.cn/logo/58/252_84/logo-o.png',
                width: 500,
                height: 250,
              ),
              falseValue: () => Image.file(
                File(picUrl),
                width: 500,
                height: 250,
              )),
          const Text('点击按钮拍照'),
          MaterialButton(
            color: Colors.grey,
            onPressed: requestPermission,
            child: const Text(
              '相机',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.grey,
            onPressed: selectFromAlbum,
            child: const Text(
              '相册',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isDataEmpty() {
    return picUrl.isEmpty;
  }

  bool isGranted = false;
  String picUrl = '';

  void requestPermission() {
    FairPermission.requestPermission(
        type: FairPermission.permissionPhoto,
        granted: () {
          isGranted = true;
          takePhoto();
        },
        restricted: () {
          isGranted = false;
          takePhoto();
        });
  }

  void selectFromAlbum() {
    FairImagePicker.getImage(
        type: FairImagePicker.album,
        success: (resp) {
          picUrl = resp;
          setState(() {});
        },
        failure: () {
          //用户获取图片失败
        });
  }

  void takePhoto() {
    FairImagePicker.getImage(
        type: FairImagePicker.photo,
        success: (resp) {
          picUrl = resp;
          setState(() {});
        },
        failure: () {
          //用户获取图片失败
        });
  }
}
