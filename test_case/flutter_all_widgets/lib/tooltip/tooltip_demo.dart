import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class TooltipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TooltipDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Tooltip(
              message: 'Fair Sample',
              child: Icon(Icons.book_online),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/tooltip/lib_tooltip_tooltip_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
