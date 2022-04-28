import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  int state;
  TextStyle headline2;


  TextWidget(this.state, this.headline2);

  @override
  State<StatefulWidget> createState() {
    return _TextWidget();
  }
}

class _TextWidget extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text('${widget.state}', style: widget.headline2);
  }
}
