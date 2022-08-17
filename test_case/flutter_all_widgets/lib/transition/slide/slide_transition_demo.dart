import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SlideTransitionDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SlideTransitionDemoState();
}

class _SlideTransitionDemoState extends State<SlideTransitionDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = Tween(begin: Offset(0.0,0.0), end: Offset(1.0,1.0)).animate(_animationController);

    //开始动画
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SlideTransitionDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
              height: 100,
              width: 100,
              child: SlideTransition(
                position: _animation,
                child: Container(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: '',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
