import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class ThemeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThemeDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.red,
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Fair Sample'),
                ),
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/theme/lib_theme_theme_fair.fair.json',
              data: {
                'fairProps': jsonEncode({})
              },
            ),
          )
        ],
      ),
    );
  }
}
