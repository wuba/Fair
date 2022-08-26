import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class ScrollbarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RowDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                reverse: false,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Text('$index'),
                    ),
                  );
                },
                itemCount: 30,
                itemExtent: 50,
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/scroll/lib_scroll_scrollbar_scrollbar_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
