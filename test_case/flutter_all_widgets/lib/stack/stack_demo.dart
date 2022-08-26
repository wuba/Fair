import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StackDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.red,
                ),
                Container(
                  height: 170,
                  width: 170,
                  color: Colors.blue,
                ),
                Container(
                  height: 140,
                  width: 140,
                  color: Colors.yellow,
                )
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/stack/lib_stack_stack_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
