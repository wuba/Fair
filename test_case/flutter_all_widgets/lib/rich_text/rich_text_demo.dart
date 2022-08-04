import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RichTextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RichTextDemo'),
      ),
      body:Column(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'Hello ',
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                  TextSpan(
                      text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' world!'),
                ],
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/richtext/lib_rich_text_rich_text_fair.fair.json',
              data: {'fairProps':jsonEncode({'content': 'Fair '})},
            ),
          )
        ],
      ),
    );
  }
}
