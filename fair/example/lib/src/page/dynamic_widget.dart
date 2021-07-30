import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class DynamicWidget extends StatelessWidget {

  @FairProps()
  final String content;
  const DynamicWidget({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          content,
          style: TextStyle(fontSize: 30, color: Colors.yellow),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30, bottom: 30),
        color: Colors.redAccent,
        width: 300,
        height: 300,
      ),
    );
  }
}