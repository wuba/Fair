import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SemanticsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SemanticsDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Semantics(
              child: Text('Fair Sample'),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/semantics/lib_semantics_semantics_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
