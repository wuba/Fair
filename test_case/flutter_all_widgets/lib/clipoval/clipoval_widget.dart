
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairClipOvalPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_FairClipOvalPageState();

}

class _FairClipOvalPageState extends State<FairClipOvalPage>{
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.5,
        child: Container(
          height: 250,
          width: 150,
          child: Image.asset(
            'assets/images/qixi.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}