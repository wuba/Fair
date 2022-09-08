import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class AnimatedOpacityPage extends StatefulWidget{
  const AnimatedOpacityPage({Key key}) : super(key: key);

  @override
  _AnimatedOpacityPageState createState() => _AnimatedOpacityPageState();

}
class _AnimatedOpacityPageState extends State<AnimatedOpacityPage>{
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedOpacity(
          opacity: opacityLevel,
          duration: Sugar.isDuration(seconds: 4),
          child: const FlutterLogo(),
        ),
        ElevatedButton(
          onPressed: _changeOpacity,
          child: const Text('Fade Logo'),
        ),
      ],
    );
  }

}