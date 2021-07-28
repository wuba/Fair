import 'dart:io';

import 'package:fair/fair.dart';
import 'package:fair_example/src/page/plugins/permission/fair_permission_plugin.dart';
import 'package:fair_example/src/page/plugins/permission/fair_take_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@FairPatch()
class PermissionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PermissionPageState();
}

class PermissionPageState extends State<PermissionPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('图片选择'),
        ),
        body: Container(
          child: Column(
            children: [
              Sugar.ifEqual('$picUrl', '',
                  trueValue: Image.network(
                    'https://img.58cdn.com.cn/logo/58/252_84/logo-o.png',
                    width: 1000,
                    height: 500,
                  ),
                  falseValue: Image.file(
                    File('$picUrl'),
                    width: 1000,
                    height: 500,
                  )),
              Text('点击按钮拍照'),
              MaterialButton(
                color: Colors.grey[350],
                onPressed: () {
                  requestPermission();
                },
                child: Text(
                  '相机',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.grey[350],
                onPressed: () {
                  selectFromAlbum();
                },
                child: Text(
                  '相册',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isGranted = false;
  String picUrl =
      '/storage/emulated/0/Android/data/fair.example/files/Pictures/80e10da6-2599-4935-b26b-ae59857fdf175734646925196256918.jpg';

  void requestPermission() {
    WBPermission().requestPermission({
      'pageName': '#FairKey#',
      'args': {
        'type': 'Permission_Photo',
        'Granted': (resp) {
          isGranted = true;
          takePhoto();
        },
        'Restricted': (resp) {
          isGranted = false;
          takePhoto();
        },
      }
    });
  }

  void selectFromAlbum() {
    FairPhotoSelector().getPhoto({
      'pageName': '#FairKey#',
      'args': {
        'type': 'album',
        'success': (resp) {
          picUrl = resp;
          setState(() {});
        },
        'failure': () {
          //用户获取图片失败
        },
      }
    });
  }

  void takePhoto() {
    FairPhotoSelector().getPhoto({
      'pageName': '#FairKey#',
      'args': {
        'type': 'photo',
        'success': (resp) {
          picUrl = resp;
          print('picUrl'+picUrl);
          setState(() {});
        },
        'failure': () {
          //用户获取图片失败
        },
      }
    });
  }
}
