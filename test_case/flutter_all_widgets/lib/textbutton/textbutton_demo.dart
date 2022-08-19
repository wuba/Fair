import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class TextButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextButtonDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                print('click text button');
              },
              child: Text('Click'),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/textbutton/lib_textbutton_textbutton_fair.fair.json',
              data: {
                'fairProps': jsonEncode({'content': 'Fair Click'})
              },
            ),
          )
        ],
      ),
    );
  }
}
