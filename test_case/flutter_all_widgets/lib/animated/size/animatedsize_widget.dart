

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairAnimatedSizePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FairAnimatedSizePageState();

}

class _FairAnimatedSizePageState extends State<FairAnimatedSizePage>{

  double _size = 100.0;
  bool _large = false;

  void _update(){
    setState(() {
      _size = _large ? 100.0 : 250.0 ;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _update,
      child: Container(
        color: Colors.amberAccent,
        child: AnimatedSize(
          curve: Curves.easeIn,
          duration: const Duration(seconds: 1),
          child: FlutterLogo(
            size: _size,
          ),
        ),
      ),
    );
  }

}