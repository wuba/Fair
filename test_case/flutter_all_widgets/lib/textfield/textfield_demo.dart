import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class TextFieldDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextFieldDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/textfield/lib_textfield_textfield_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
