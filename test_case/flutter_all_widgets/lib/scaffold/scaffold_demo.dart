import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class ScaffoldDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScaffoldDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Scaffold(
              body: Center(
                child: Text('fair'),
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/scaffold/lib_scaffold_scaffold_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
