
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 *
 * 交叉淡入：让2个组件在切换时出现交叉渐入的效果，
 * 因此AnimatedCrossFade需要设置2个子控件、动画时间和显示第几个子控件
 *
 */
class AnimatedCrossFadeDemo extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedCrossFade'),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlutterAnimatedCrossFade(),
            FairWidget(
              path: 'assets/bundle/animated/lib_animated_crossfade_animatedcrossfade_widget.fair.json',
            )
          ],
        ),
      )
    );
  }

}


class FlutterAnimatedCrossFade extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_FlutterAnimatedCrossFadePageState();

}

class _FlutterAnimatedCrossFadePageState extends State<FlutterAnimatedCrossFade>{

  bool _first = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedCrossFade(
          duration: const Duration(seconds: 3),
          firstChild: const FlutterLogo(style: FlutterLogoStyle.horizontal, size: 100.0),
          secondChild: const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
          crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
        ElevatedButton(
          child: Text('切换'),
          onPressed: () {
            setState(() {
              _first= !_first;
            });
          },
        ),
      ],
    );
  }

}
