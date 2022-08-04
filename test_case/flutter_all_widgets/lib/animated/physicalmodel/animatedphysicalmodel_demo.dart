
import 'package:fair/fair.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlutterAnimatedPhysicalModelPage(),
            FairWidget(
              path: 'assets/bundle/animated/lib_animated_physicalmodel_animatedphysicalmodel_widget.fair.json',
            )
          ],
        ),
      )
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
        ElevatedButton(
          child: Text('Flutter 动画'),
          onPressed: (){
            setState(() {
              _animated = !_animated;
            });
          },
        ),
      ],
    );
  }

}