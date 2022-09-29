
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 * 尺寸限制类容器,约束子组件的最大宽高和最小宽高
 */
class ConstrainedBoxDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConstrainedBox'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterConstrainedBoxPage(),
          FairWidget(
            path: 'assets/bundle/constrainedbox/lib_constrainedbox_constrainedbox_widget.fair.json',
          )
        ],
      ),
    );
  }

}

class FlutterConstrainedBoxPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 60, maxWidth: 200),
      child: Container(height: 300, width: 300, color: Colors.red),
    );
  }

}