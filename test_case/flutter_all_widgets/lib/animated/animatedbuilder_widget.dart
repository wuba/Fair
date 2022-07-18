import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

@FairPatch()
class FairAnimatedBuilderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FairAnimatedBuilderPageState();
}

class _FairAnimatedBuilderPageState extends State<FairAnimatedBuilderPage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.green,
        child: Center(
          child: Text('Whee!'),
        ),
      ),
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }
}
