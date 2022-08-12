import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairPositionedTransitionPage extends StatefulWidget {
  dynamic fairProps;

  FairPositionedTransitionPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairPositionedTransitionPageState();
}

class _FairPositionedTransitionPageState
    extends State<FairPositionedTransitionPage>
    with SingleTickerProviderStateMixin {
  @FairProps()
  var fairProps;

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
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PositionedTransition(
            rect: _animation,
            child: Container(
              color: Colors.green,
            )));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
