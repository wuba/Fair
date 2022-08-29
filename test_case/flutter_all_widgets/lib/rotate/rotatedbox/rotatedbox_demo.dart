import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class RotatedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RotatedBoxDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RotatedBox(
              quarterTurns: 1, //旋转90度(1/4圈)
              child: Container(
                color: Colors.green,
                child: Text("Hello world"),
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path:
                  'assets/bundle/rotate/lib_rotate_rotatedbox_rotatedbox_fair.fair.json',
              data: {
                'fairProps': jsonEncode({'quarterTurns': 1})
              },
            ),
          )
        ],
      ),
    );
  }
}
