import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class RawKeyboardListenerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RawKeyboardListenerDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (key) => print('key label:${key.data.keyLabel}'),
                child: Container(
                  color: Colors.blue,
                )),
          ),
          Expanded(
            child: FairWidget(
              path:
                  'assets/bundle/raw/lib_raw_keyboard_listener_raw_keyboard_listener_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
