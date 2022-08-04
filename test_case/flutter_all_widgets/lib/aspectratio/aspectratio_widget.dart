

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 * 按比例显示
 */
@FairPatch()
class FairAspectRatioPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FairAspectRatioPageState();

}

class _FairAspectRatioPageState extends State<FairAspectRatioPage>{

  double _getWidth(){
    return double.infinity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      width: _getWidth(),
      height: 100.0,
      child: AspectRatio(
        aspectRatio: 16/9,
        child: Container(
          color: Colors.green,
          child: Text('Fair 按比例显示'),
        ),
      ),
    );
  }

}