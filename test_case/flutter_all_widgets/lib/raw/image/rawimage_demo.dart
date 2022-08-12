import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class RawImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RawImageDemo'),
      ),
      body: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            child: RawImage(),
          ),
          Container(
            width: 200,
            height: 200,
            child: FairWidget(
              path: 'assets/bundle/raw/lib_raw_image_rawimage_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
