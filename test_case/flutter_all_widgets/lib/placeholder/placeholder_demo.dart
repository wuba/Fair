import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class PlaceholderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlaceholderDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Placeholder(
              color: const Color(0xFF112233), // Blue Grey 700
              strokeWidth: 5.0,
              fallbackWidth: 200.0,
              fallbackHeight: 200.0,
            ),
          ),
          Expanded(
            child: FairWidget(
              path:
                  'assets/bundle/placeholder/lib_placeholder_placeholder_fair.fair.json',
              data: {
                'fairProps': jsonEncode({
                  'strokeWidth': '5.0',
                  'fallbackWidth': '200.0',
                  'fallbackHeight': '200.0',
                })
              },
            ),
          )
        ],
      ),
    );
  }
}
