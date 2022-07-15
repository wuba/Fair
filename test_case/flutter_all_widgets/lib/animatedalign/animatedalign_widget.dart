

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairAnimatedAlignPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FairAnimatedAlignPageState();

}

class _FairAnimatedAlignPageState extends State<FairAnimatedAlignPage>{

  bool _selected = false;

  void _setSelected(){
    setState(() {
      _selected = !_selected;
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:_setSelected,
      child: Center(
        child: Container(
          width: 250.0,
          height: 250.0,
          color: Colors.red,
          child: AnimatedAlign(
            alignment: Sugar.ifEqualBool(_selected, trueValue: Alignment.topRight, falseValue: Alignment.bottomLeft),
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: FlutterLogo(size: 50.0,),
          ),
        ),
      ),
    );
  }

}