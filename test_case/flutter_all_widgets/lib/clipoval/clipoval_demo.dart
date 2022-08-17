
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 * 剪裁效果
 */
class ClipOvalDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClipOval'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterClipOvalPage(),
          FairWidget(path: 'assets/bundle/clipoval/lib_clipoval_clipoval_widget.fair.json',)
        ],
      ),
    );
  }

}

class FlutterClipOvalPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.5,
        child: Container(
          height: 250,
          width: 150,
          child: Image.asset(
            'assets/images/qixi.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}

