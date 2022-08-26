import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class RadioDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RadioDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Radio(
              value: 1,
              groupValue: [1, 2, 3],
              onChanged: (value) {
                print('$value');
              },
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/radio/lib_radio_radio_fair.fair.json',
              data: {
                'fairProps': jsonEncode({
                  'value': 1,
                  'groupValue': [1, 2, 3]
                })
              },
            ),
          )
        ],
      ),
    );
  }
}
