
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class AnimatedAlignDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedAlign'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterAnimatedAlignPage(),
          FairWidget(
            path: 'assets/bundle/animated/lib_animatedalign_animatedalign_widget.fair.json',
            data: {},
          )
        ],
      ),
    );
  }

}

class FlutterAnimatedAlignPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_FlutterAnimatedAlignPageState();

}

class _FlutterAnimatedAlignPageState extends State<FlutterAnimatedAlignPage>{
  
  bool _selected = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:(){
          setState(() {
            _selected = !_selected;
          });
        },
      child: Center(
        child: Container(
          width: 250.0,
          height: 250.0,
          color: Colors.red,
          child: AnimatedAlign(
            alignment: _selected? Alignment.topRight:Alignment.bottomLeft,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: FlutterLogo(size: 50.0,),
          ),
        ),
      ),
    );
  }

}
