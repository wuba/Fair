
import 'package:fair/fair.dart';
import 'package:flutter/widgets.dart';
import 'package:animated_text_kit/src/rotate.dart';

class AnimateWidget extends StatelessWidget{

  const AnimateWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  RotateAnimatedTextKit(
        onTap: () => {},
        text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
        textStyle: TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
        textAlign: TextAlign.start,
        alignment: AlignmentDirectional.topStart
      // or Alignment.topLeft )
    );
  }

}