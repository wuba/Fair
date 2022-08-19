import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class TransformDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TransformDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Transform(
              transform: Matrix4.rotationZ(0.5),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/transform/lib_transform_transform_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
