import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class RowDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RowDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Text('Fair Sample 1'),
                Text('Fair Sample 2'),
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/row/lib_row_row_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
