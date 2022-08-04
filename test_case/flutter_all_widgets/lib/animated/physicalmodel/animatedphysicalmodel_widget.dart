


import 'package:fair/fair.dart';
import 'package:flutter/material.dart';


@FairPatch()
class FairAnimatedPhysicalModelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>_FairAnimatedPhysicalModelPageState();

}

class _FairAnimatedPhysicalModelPageState extends State<FairAnimatedPhysicalModelPage>{

  bool _animated = false;

  _buildAnimatedPhysicalModel() {
    return AnimatedPhysicalModel(
      borderRadius: BorderRadius.circular(Sugar.ifEqualBool(_animated, trueValue: 20, falseValue: 10)),
      shape: BoxShape.rectangle,
      color:  Sugar.ifEqualBool(_animated, trueValue: Colors.blue , falseValue: Colors.red) ,
      elevation: Sugar.ifEqualBool(_animated, trueValue: 18, falseValue: 8),
      shadowColor: Sugar.ifEqualBool(_animated, trueValue: Colors.red, falseValue: Colors.blue),
      child: Container(
        height: 100,
        width: 100,
      ),
      duration: Duration(seconds: 1),
    );
  }

  void _setAnimated(){
    setState(() {
      _animated = !_animated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedPhysicalModel(),
        ElevatedButton(
          child: Text('Fair 动画'),
          onPressed: _setAnimated,
        ),
      ],
    );
  }

}
