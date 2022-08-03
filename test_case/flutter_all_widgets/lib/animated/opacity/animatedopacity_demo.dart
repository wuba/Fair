import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 * 隐式的动画组件，它可以使子组件变的透明
 */
class AnimatedOpacityDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedOpacity'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlutterAnimatedOpacityPage(),
          FairWidget(
            path: 'assets/bundle/animated/lib_animated_opacity_animatedopacity_widget.fair.json',
          ),
        ],
      ),
    );
  }

}

class FlutterAnimatedOpacityPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FlutterAnimatedOpacityPageState();

}

class _FlutterAnimatedOpacityPageState extends State<FlutterAnimatedOpacityPage>{

  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: opacityLevel,
            duration: const Duration(seconds: 3),
            child: const FlutterLogo(size: 75,),
          ),
          ElevatedButton(
            onPressed: _changeOpacity,
            child: const Text('Flutter Click'),
          ),
        ],
      ),
    );
  }

}