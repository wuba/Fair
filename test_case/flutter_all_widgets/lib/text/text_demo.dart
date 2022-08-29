import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class TextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Text('Fair Sample'),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/text/lib_text_text_fair.fair.json',
              data: {
                'fairProps': jsonEncode({'content': 'Fair Sample'})
              },
            ),
          )
        ],
      ),
    );
  }
}
