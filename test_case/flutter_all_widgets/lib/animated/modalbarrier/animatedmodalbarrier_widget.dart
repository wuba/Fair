import 'package:fair/fair.dart';
import 'package:flutter/material.dart';


@FairPatch()
class FairAnimatedModalBarrierPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FairAnimatedModalBarrierPageState();

}

class _FairAnimatedModalBarrierPageState extends State<FairAnimatedModalBarrierPage> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = ColorTween(
        begin: Colors.red,
        end: Colors.blue)
        .animate(_animationController);

    //开始动画
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        child: AnimatedModalBarrier(
          barrierSemanticsDismissible: true,
          dismissible: true,
          color: _animation,
        ),
      ),
    );
  }


}