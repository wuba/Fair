import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SingleChildScrollViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SingleChildScrollViewDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(50, (index) {
                  return Container(
                    height: 150,
                    color: Colors.primaries[index % Colors.primaries.length],
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/scroll/lib_scroll_singlechild_scrollview_singlechild_scrollview_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
