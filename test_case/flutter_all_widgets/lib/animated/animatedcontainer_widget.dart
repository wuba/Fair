
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairAnimatedContainerPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FairAnimatedContainerPage();

}

class _FairAnimatedContainerPage extends State<FairAnimatedContainerPage>{

  bool selected = false;


  void _setSelect(){
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _setSelect,
      child: AnimatedContainer(
        width: Sugar.ifEqualBool(selected, trueValue: 200.0, falseValue: 100.0),
        height: Sugar.ifEqualBool(selected, trueValue: 100.0, falseValue: 200.0),
        color: Sugar.ifEqualBool(selected, trueValue: Colors.red, falseValue: Colors.blue),
        alignment:Sugar.ifEqualBool(selected, trueValue: Alignment.center, falseValue: AlignmentDirectional.topCenter),
          duration:Duration(seconds: 2),
          curve:Curves.fastOutSlowIn,
          child:const FlutterLogo(size: 75),
      ),
    );
  }

}