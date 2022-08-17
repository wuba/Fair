import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SizedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SizedBoxDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: 60,
              width: 200,
              child: Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text('Fair Sample'),
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/sized/lib_sized_box_sized_box_fair.fair.json',
              data: {
                'fairProps': jsonEncode({
                  'height': 60,
                  'width': 200,
                })
              },
            ),
          )
        ],
      ),
    );
  }
}
