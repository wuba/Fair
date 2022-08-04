
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class AspectRatioDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AspectRatio'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterAspectRatioPage(),
          FairWidget(
            path: 'assets/bundle/aspectratio/lib_aspectratio_aspectratio_widget.fair.json',
          )
        ],
      ),
    );
  }

}

class FlutterAspectRatioPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FlutterAspectRatioPage();

}

class _FlutterAspectRatioPage extends State<FlutterAspectRatioPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      width: double.infinity,
      height: 100.0,
      child: AspectRatio(
        aspectRatio: 16/9,
        child: Container(
          color: Colors.green,
          child: Text('Flutter 按比例显示'),
        ),
      ),
    );
  }

}