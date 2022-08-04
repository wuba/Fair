

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairAnimatedCrossFadePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FairAnimatedCrossFadePageState();

}

class _FairAnimatedCrossFadePageState extends State<FairAnimatedCrossFadePage>{

  bool _first = true;

  void _setFirst(){
    setState(() {
      _first= !_first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedCrossFade(
          duration: const Duration(seconds: 3),
          firstChild: const FlutterLogo(style: FlutterLogoStyle.horizontal, size: 100.0),
          secondChild: const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
          crossFadeState: Sugar.ifEqualBool(_first, trueValue: CrossFadeState.showFirst , falseValue: CrossFadeState.showSecond),
        ),
        ElevatedButton(
          child: Text('切换'),
          onPressed: _setFirst,
        ),
      ],
    );
  }

}