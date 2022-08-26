import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSlideTransitionPage extends StatefulWidget {
  dynamic fairProps;

  FairSlideTransitionPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSlideTransitionPageState();
}

class _FairSlideTransitionPageState extends State<FairSlideTransitionPage>
    with SingleTickerProviderStateMixin {
  @FairProps()
  var fairProps;

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
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 100,
      width: 100,
      child: SlideTransition(
        position: _animation,
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
