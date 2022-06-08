import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

///使用FairPatch标记需要生成FairWidget的widget
@FairPatch()
class FairPropsWidget extends StatefulWidget {
  const FairPropsWidget({Key? key}) : super(key: key);

  @override
  State<FairPropsWidget> createState() => _FairPropsWidgetState();
}

class _FairPropsWidgetState extends State<FairPropsWidget> {

  ///接收data参数的变量需要使用FairProps注解标记
  @FairProps()
  var data;

  ///widget需要用的的变量请使用方法声明再使用
 String fairText(){
    return data["fairText"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text(fairText(),style: TextStyle(color: Colors.red,fontSize: 20),),
        ),
      ),
    );
  }
}
