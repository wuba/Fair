import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class TextWidget extends StatelessWidget {
  @FairWell('state')
  int state;
  @FairWell('headline2')
  TextStyle headline2;

  TextWidget(this.state, this.headline2);

  @override
  Widget build(BuildContext context) {
    return Text('$state', style: headline2);
  }
}
