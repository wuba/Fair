import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class AnimatedPositionedPage extends StatefulWidget {
  const AnimatedPositionedPage({Key key}) : super(key: key);

  @override
  _AnimatedPositionedPage createState() => _AnimatedPositionedPage();
}

class _AnimatedPositionedPage extends State<AnimatedPositionedPage> {
  bool selected = false;
  var mWidth=50.0;
  var mHeight=350.0;
  void _changePositioned() {
    print('点击了');
    setState(() {
      selected = !selected;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 350,
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            width: Sugar.ifEqualBool(selected, trueValue: 200.0, falseValue: 50.0),
            height: Sugar.ifEqualBool(selected, trueValue: 50.0, falseValue: 200.0),
            top: Sugar.ifEqualBool(selected, trueValue: 50.0, falseValue: 150.0),
            duration: Sugar.isDuration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: GestureDetector(
              onTap: _changePositioned,
              child: Container(
                color: Colors.blue,
                child: const Center(child: Text('Tap me')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
