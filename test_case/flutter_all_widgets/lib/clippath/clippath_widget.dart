
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairClipPathPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _FlutterClipPathPageState();

}


class _FlutterClipPathPageState extends State{
  @override
  Widget build(BuildContext context) {
    return ClipPath.shape(
      shape: StadiumBorder(),
      child: Container(
        height: 150,
        width: 250,
        child: Image.asset(
          'assets/images/qixi.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}