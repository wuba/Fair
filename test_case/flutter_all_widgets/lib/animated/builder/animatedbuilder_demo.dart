import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBuilderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedBuilder'),
      ),
      body: FlutterAnimatedBuilderPage(),
    );
  }
}

class FlutterAnimatedBuilderPage extends StatefulWidget {
  const FlutterAnimatedBuilderPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlutterAnimatedBuilderPageState();
}

class _FlutterAnimatedBuilderPageState extends State<FlutterAnimatedBuilderPage>
    with TickerProviderStateMixin {
    AnimationController _controller;

   @override
  void initState() {
     _controller = AnimationController(
       duration: Duration(seconds: 10),
       vsync: this,
     )..repeat();
    super.initState();
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
