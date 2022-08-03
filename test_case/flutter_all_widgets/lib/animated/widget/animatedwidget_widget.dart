
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

@FairPatch()
class FairAnimatedWidgetPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FairAnimatedWidgetPageState();

}

class _FairAnimatedWidgetPageState extends State<FairAnimatedWidgetPage> with TickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpinningContainer(controller: _controller);
  }

}

class SpinningContainer extends AnimatedWidget {
  SpinningContainer({ Key key, AnimationController controller,
  }) : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _progress.value * 2.0 * math.pi,
      child: Container(width: 200.0, height: 200.0, color: Colors.green),
    );
  }
}