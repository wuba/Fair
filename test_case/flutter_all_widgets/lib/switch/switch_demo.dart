import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SwitchDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<SwitchDemo> {
  var _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SwitchDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Switch(
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/switch/lib_switch_switch_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
