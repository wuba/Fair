import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSizeTransitionPage extends StatefulWidget {
  dynamic fairProps;

  FairSizeTransitionPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSizeTransitionPageState();
}

class _FairSizeTransitionPageState extends State<FairSizeTransitionPage>
    with SingleTickerProviderStateMixin {
  @FairProps()
  var fairProps;

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = Tween(begin: .0, end: .5).animate(_animationController);

    //开始动画
    _animationController.forward();
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RotationTransition(
      turns: _animation,
      child: Container(
        height: 200,
        width: 200,
        color: Colors.red,
      ),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
