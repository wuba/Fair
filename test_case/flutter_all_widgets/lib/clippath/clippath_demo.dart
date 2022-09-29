

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 * 根据路径进行裁剪
 */
class ClipPathDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClipPath'),
      ),
      body: Column(
        children: [
          FlutterClipPathPage(),
          FairWidget(
            path: 'assets/bundle/clippath/lib_clippath_clippath_widget.fair.json',
          )
        ],
      ),
    );
  }

}

class FlutterClipPathPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ClipPath.shape(
      shape: StadiumBorder(),
      child: Container(
        height: 150,
        width: 250,
        child: Image.asset(
          'assets/images/qixi.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}