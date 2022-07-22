

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairAnimatedOpacityPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FairAnimatedOpacityPageState();
}

class _FairAnimatedOpacityPageState extends State<FairAnimatedOpacityPage>{
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: opacityLevel,
          duration: const Duration(seconds: 3),
          child: const FlutterLogo(size: 75,),
        ),
        MaterialButton(
          onPressed: _changeOpacity,
          child: const Text('Fair Logo'),
        ),
      ],
    );
  }

}