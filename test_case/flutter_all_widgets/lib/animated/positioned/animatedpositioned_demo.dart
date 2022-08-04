
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedPositionedDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedPositioned'),
      ),
      body: Column(
        children: [
          FlutterAnimatedPositionedPage(),
          FairWidget(
            path: 'assets/bundle/animated/lib_animated_positioned_animatedpositioned_widget.fair.json',
          )
        ],
      ),
    );
  }

}

class FlutterAnimatedPositionedPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FlutterAnimatedPositionedPageState();

}

class _FlutterAnimatedPositionedPageState extends State<FlutterAnimatedPositionedPage>{

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 350,
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
              width: selected ? 200.0 : 50.0,
              height: selected? 50.0: 200.0,
              top: selected?50.0 : 150.0 ,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    selected= !selected;
                  });
                },
                child: Container(
                  color: Colors.blue,
                  child: const Center(child: Text('Flutter Tap Me'),),
                ),
              ),)
        ],
      ),
    );
  }

}

