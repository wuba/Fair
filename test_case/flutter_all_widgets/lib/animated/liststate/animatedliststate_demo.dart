
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

import 'animatedliststate_flutter.dart';

/**
 * 列表数据变化试的过度动画
 */
class AnimatedListStateDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "AnimatedListStateDemo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      home: Scaffold(
        appBar: AppBar(title: Text('AnimatedListStateDemo'),),
        body: Column(
          children: [
            GestureDetector(
              child: Text('Flutter AnimatedListState'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>FlutterAnimatedListStatePage()));
              },
            ),
            GestureDetector(
              child: Text('Flutter AnimatedListState'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>FairWidget(
                  path: 'assets/bundle/animated/lib_animated_liststate_animatedliststate_widget.fair.json',
                )));
              },
            ),
          ],
        )
      )
    );
  }

}
