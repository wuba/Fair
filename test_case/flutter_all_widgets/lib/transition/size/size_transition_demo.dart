import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SizeTransitionDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SizeTransitionDemoState();
}

class _SizeTransitionDemoState extends State<SizeTransitionDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = Tween(begin: .1, end: .5).animate(_animationController);

    //开始动画
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SizeTransitionDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizeTransition(
              sizeFactor: _animation,
              axis: Axis.horizontal,
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
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
