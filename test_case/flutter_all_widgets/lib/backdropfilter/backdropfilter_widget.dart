
import 'dart:ui';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 * BackdropFilter:实现图片的高斯模糊处理
 */
@FairPatch()
class FairBackdropFilterPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_FairBackdropFilterPageState();

}

class _FairBackdropFilterPageState extends State<FairBackdropFilterPage>{

  Container _getContainer(){
    return Container(
      color: Colors.red.withOpacity(0),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
            width: 200,
            height: 300,
            child:Image.asset('assets/images/qixi.png')
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Center(
//            child: _getContainer(), Container color报错
          ),
        ),
      ],
    );
  }

}