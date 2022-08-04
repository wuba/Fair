import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedDefaultTextStyleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedDefaultTextStyle'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterAnimatedDefaultTextStylePage(),
          FairWidget(
            path: 'assets/bundle/animated/lib_animated_animateddefulttextstyle_widget.fair.json',
          )
        ],
      ),
    );
  }
}

class FlutterAnimatedDefaultTextStylePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _FlutterAnimatedDefaultTextStylePageState();
}

class _FlutterAnimatedDefaultTextStylePageState
    extends State<FlutterAnimatedDefaultTextStylePage> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected =!selected;
        });
      },
      child: AnimatedDefaultTextStyle(
        child: Text('Flutter click me'),
        style: selected
            ? TextStyle(
                fontSize: 50, color: Colors.red, fontWeight: FontWeight.bold)
            : TextStyle(color: Colors.blue, fontSize: 24.0),
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
        maxLines: 1,
      ),
    );
  }
}
