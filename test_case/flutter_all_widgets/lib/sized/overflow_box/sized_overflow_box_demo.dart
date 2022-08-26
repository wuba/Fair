import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SizedOverflowBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SizedOverflowBoxDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue[50],
              child: SizedOverflowBox(
                size: const Size(100.0, 100.0),
                alignment: AlignmentDirectional.bottomStart,
                child: Container(height: 50.0, width: 150.0, color: Colors.blue,),
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/sized/lib_sized_overflow_box_sized_overflow_box_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
