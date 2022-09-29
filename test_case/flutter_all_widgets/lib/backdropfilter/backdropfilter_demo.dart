
import 'dart:ui';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class BackdropFilterDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BackdropFilter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterBackdropFilterPage(),
          FairWidget(
            path: 'assets/bundle/backdropfilter/lib_backdropfilter_backdropfilter_widget.fair.json',
          )
        ],
      ),
    );
  }

}

class FlutterBackdropFilterPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_FlutterBackdropFilterPageState();

}

class _FlutterBackdropFilterPageState extends State<FlutterBackdropFilterPage>{
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 300,
          height: 400,
          child:Image.asset('assets/images/qixi.png')
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Center(
            child: Container(
              color: Colors.red.withOpacity(0),
            ),

          ),
        ),
      ],
    );
  }

}