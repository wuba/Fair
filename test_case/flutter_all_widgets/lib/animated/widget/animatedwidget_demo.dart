
import 'package:flutter/material.dart';
import 'package:flutter_all_widgets/animated/widget/spinning_container.dart';

import 'animatedwidget_widget.dart';

class AnimatedWidgetDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Column(
        children: [
          FlutterAnimatedWidgetPage(),
          FairAnimatedWidgetPage(),
        ],
      ),
    );
  }

}

class FlutterAnimatedWidgetPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=> _FlutterAnimatedWidgetPageState();

}

class _FlutterAnimatedWidgetPageState extends State<FlutterAnimatedWidgetPage> with TickerProviderStateMixin{

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

