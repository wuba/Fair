import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class AnimatedSizeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedSize'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(child: FlutterAnimatedSizePage(),),
          Center(child: FairWidget(
            path: 'assets/bundle/animatedsize/lib_animated_size_animatedsize_widget.fair.json',
          ),)
        ],
      ),
    );
  }
}

class FlutterAnimatedSizePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlutterAnimatedSizePageState();
}

class _FlutterAnimatedSizePageState extends State<FlutterAnimatedSizePage> {
  double _size = 100.0;
  bool _large = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _size = _large ? 100.0 : 250.0  ;
          _large = !_large;
        });
      },
      child: Container(
        color: Colors.amberAccent,
        child: AnimatedSize(
          curve: Curves.easeIn,
          duration: const Duration(seconds: 1),
          child: FlutterLogo(
            size: _size,
          ),
        ),
      ),
    );
  }
}
