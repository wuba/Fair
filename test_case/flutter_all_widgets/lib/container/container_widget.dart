
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairContainerPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FairContainerPageState();

}

class _FairContainerPageState extends State<FairContainerPage>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10.0),
//        color: Colors.amber[600],不支持此写法
        color: Colors.amber,
        width: 48.0,
        height: 48.0,
      ),
    );
  }

}