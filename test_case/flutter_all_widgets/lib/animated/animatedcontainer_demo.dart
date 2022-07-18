import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedContainer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterAnimatedContainerPage(),
          FairWidget(
            path: 'assets/bundle/animatedcontainer/lib_animated_animatedcontainer_widget.fair.json',
          )
        ],
      )
    );
  }

}

class FlutterAnimatedContainerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlutterAnimatedContainerPage();

}

class _FlutterAnimatedContainerPage
    extends State<FlutterAnimatedContainerPage> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          width: selected ? 200.0 : 100.0,
          height: selected ? 100.0 : 200.0,
          color: selected ? Colors.red : Colors.blue,
          alignment: selected? Alignment.center:AlignmentDirectional.topCenter,
            duration:Duration(seconds:2),
            curve:Curves.fastOutSlowIn,
          child: FlutterLogo(size: 75,),
        ),
      ),
    );
  }

}