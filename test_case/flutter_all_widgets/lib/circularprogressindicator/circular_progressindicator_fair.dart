import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairCircularProgressIndicator extends StatefulWidget {
  dynamic fairProps;

  FairCircularProgressIndicator({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairCircularProgressIndicatorState();
}

class _FairCircularProgressIndicatorState
    extends State<FairCircularProgressIndicator> with TickerProviderStateMixin {
  AnimationController controller;

  @FairProps()
  var fairProps;

  @override
  void initState() {
    fairProps = widget.fairProps;

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _getTime()),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int _getTime() {
    return fairProps['time'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Fair Linear progress indicator',
              style: Theme.of(context).textTheme.bodyText1),
          CircularProgressIndicator(
            value: controller.value,
            semanticsLabel: 'Linear progress indicator',
          )
        ],
      ),
    );
  }
}
