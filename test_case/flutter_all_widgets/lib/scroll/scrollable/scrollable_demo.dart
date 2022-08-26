import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class ScrollableDemo extends StatelessWidget {
  Widget _getBuilder(context, position) => ListView(
        children: <Widget>[
          Text('fair1'),
          Text('fair2'),
          Text('fair3'),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollableDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollable(viewportBuilder: _getBuilder),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/scroll/lib_scroll_scrollable_scrollable_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
