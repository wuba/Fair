import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 * 具有颜色值变化的动画控件
 */
class AnimatedModalBarrierDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedModalBarrier'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterAnimatedModalBarrierPage(),
//          FairWidget(
//            path: 'assets/bundle/animatedmodalbarrier/',
//          )
        ],
      ),
    );
  }

}

class FlutterAnimatedModalBarrierPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FlutterAnimatedModalBarrierPageState();

}

class _FlutterAnimatedModalBarrierPageState extends State<FlutterAnimatedModalBarrierPage> with SingleTickerProviderStateMixin{

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
          semanticsLabel: "StackBarrier",
          barrierSemanticsDismissible: true,
          dismissible: true,
          color: _animation,
        ),
      ),
    );
  }


}