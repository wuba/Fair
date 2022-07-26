
import 'package:flutter/material.dart';

/**
 * 动画组件:对PhysicalModel组件进行动画
 */
class AnimatedPhysicalModelDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedPhysicalModel'),
      ),
      body: Column(
        children: [
          FlutterAnimatedPhysicalModelPage(),
        ],
      ),
    );
  }

}

class FlutterAnimatedPhysicalModelPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FlutterAnimatedPhysicalModelPageState();

}

class _FlutterAnimatedPhysicalModelPageState extends State<FlutterAnimatedPhysicalModelPage>{

  bool _animated = false;

  _buildAnimatedPhysicalModel() {
    return AnimatedPhysicalModel(
      borderRadius: BorderRadius.circular(_animated ? 20 : 10),
      shape: BoxShape.rectangle,
      color: _animated ? Colors.blue : Colors.red,
      elevation: _animated ? 18 : 8,
      shadowColor: !_animated ? Colors.blue : Colors.red,
      child: Container(
        height: 100,
        width: 100,
      ),
      duration: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedPhysicalModel(),
        GestureDetector(
          child: Text('动画'),
          onTap: (){
            setState(() {
              _animated = !_animated;
            });
          },
        ),
      ],
    );
  }

}