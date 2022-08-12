import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class PositionedTransitionDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PositionedTransitionDemoState();
}

class _PositionedTransitionDemoState extends State<PositionedTransitionDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = RelativeRectTween(
            begin: RelativeRect.fromLTRB(10.0, 10.0, 10.0, 10.0),
            end: RelativeRect.fromLTRB(100.0, 100.0, 100.0, 100.0))
        .animate(_animationController);

    //开始动画
    _animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PositionedTransitionDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PositionedTransition(
                rect: _animation,
                child: Container(
                  color: Colors.green,
                )),
          ),
          Expanded(
            child: FairWidget(
              path:
                  'assets/bundle/popupmenubutton/lib_popupmenubutton_popupmenubutton_fair.fair.json',
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
