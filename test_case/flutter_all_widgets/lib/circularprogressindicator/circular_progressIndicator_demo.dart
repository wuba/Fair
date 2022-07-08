import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularProgressIndicatorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CircularProgressIndicator'),
      ),
      body: Column(
        children: [
          FlutterCircularProgressIndicator(),
          FairWidget(
            path: 'assets/bundle/circularprogressindicator/lib_cupertinoalertdialog_alert_dialog_fair.fair.json',
            data: {
              'fairProps': jsonEncode({'time': 5})
            },
          )
        ],
      ),
    );
  }
}

class FlutterCircularProgressIndicator extends StatefulWidget {
  FlutterCircularProgressIndicator({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _FlutterCircularProgressIndicatorState();
}

class _FlutterCircularProgressIndicatorState
    extends State<FlutterCircularProgressIndicator>
    with TickerProviderStateMixin {
    AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Linear progress indicator',
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
