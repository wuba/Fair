
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairAnimatedDefaultTextStylePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_FairAnimatedDefaultTextStylePage();

}
class _FairAnimatedDefaultTextStylePage  extends State<FairAnimatedDefaultTextStylePage>{
  bool selected = false;

  void _setSelected(){
    setState(() {
      selected=!selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _setSelected,
      child: AnimatedDefaultTextStyle(
        child: Text("Fair Click Me"),
        style: Sugar.ifEqualBool(selected,
            trueValue: TextStyle(fontSize: 50, color: Colors.red, fontWeight: FontWeight.bold),
            falseValue: TextStyle(color: Colors.blue, fontSize: 24.0)),
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
        maxLines: 1,
      ),
    );
  }

}
