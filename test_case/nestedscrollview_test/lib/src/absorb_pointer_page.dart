import 'package:flutter/material.dart';
import 'package:fair/fair.dart';

@FairPatch()
class MyStatelessWidget extends StatelessWidget {
   void _chekbutton(){
    print('点击了按钮1');
  }
   void _chekbutton2(){
     print('点击了按钮2');
   }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          height: 100.0,
          child: ElevatedButton(
            onPressed: _chekbutton,
            child: Text('按钮1'),
          ),
        ),
        SizedBox(
          width: 100.0,
          height: 200.0,
          child: AbsorbPointer(
            absorbing:false,
            child: ElevatedButton(
              style: Sugar.isButtonStyle(
               backgroundColor: Sugar.colorsWithOpacity(Color(0xffff602f), 0.5),
              ),
              onPressed: _chekbutton2,
              child: Text('按钮2'),
            ),
          ),
        ),
      ],
    );
  }
}
