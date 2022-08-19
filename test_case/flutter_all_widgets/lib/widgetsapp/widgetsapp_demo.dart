import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetsAppDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WidgetsAppDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: WidgetsApp(
              color: const Color(0xFFFFFFFF),
              onGenerateRoute: (RouteSettings settings) {
                return CupertinoPageRoute<void>(
                  settings: settings,
                  builder: (BuildContext context) {
                    return CupertinoTabView(
                      builder: (BuildContext context) => const Text('home'),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: FairWidget(
              path:
                  'assets/bundle/widgetsapp/lib_widgetsapp_widgetsapp_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
