
import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


@FairPatch()
class FairAnimatedPositionedPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FairAnimatedPositionedPageState();

}

class _FairAnimatedPositionedPageState extends State<FairAnimatedPositionedPage>{

  bool selected = false;


  void _setSelected(){
    setState(() {
      selected= !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 350,
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            width: Sugar.ifEqualBool(selected, trueValue: 200.0, falseValue: 50.0),
            height: Sugar.ifEqualBool(selected, trueValue: 50.0, falseValue: 200.0),
            top: Sugar.ifEqualBool(selected, trueValue: 50.0, falseValue: 150.0),
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: GestureDetector(
              onTap: _setSelected,
              child: Container(
                color: Colors.blue,
                child: const Center(child: Text('Fair Tap Me'),),
              ),
            ),)
        ],
      ),
    );
  }

}