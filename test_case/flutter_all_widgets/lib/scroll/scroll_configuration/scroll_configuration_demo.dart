import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class ScrollConfigurationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollConfigurationDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Text('Item$index');
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: 50,
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/scroll/lib_scroll_scroll_configuration_scroll_configuration_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
