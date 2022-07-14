

import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 * 吸收指针：
 * 禁止用户输入的控件，比如按钮点击、输入框输入、listview滚动，等同于他们将onPressed设置为null
 * AbsorbPointer可以提供多组件的统一控制，不需要单独为每个组件设置。
 *
 */
class AbsorbPointerDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AbsorbPointerDemo'),
      ),
      body: Column(
        children: [
          FlutterAbsorbPointerPage(),
          FairWidget(
            path: 'assets/bundle/absorbpointer/lib_absorbpointer_absorbpointer_widget.fair.json',
            data: {
              "fairProps":jsonEncode({'color':0x00aaaaaa})
            },
          )
        ],
      ),
    );
  }

}

class FlutterAbsorbPointerPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children:<Widget> [
        SizedBox(
          width: 200.0,
          height: 100.0,
          child: ElevatedButton(
            onPressed: (){
              print("click bg");
            },
            child: null,
          )
        ),
        SizedBox(
          width: 100.0,
          height: 200.0,
          child: AbsorbPointer(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue.shade200,),
              onPressed: (){
                print("click top");
              },
              child: null,
            ),
          )
        ),
      ],
    );
  }


}

