import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

import 'bottomnavigationbar_flutter.dart';

class BottomNavigationBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text('Flutter BottomNavigationBar'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlutterBottomNavigationBarPage()));
            },
          ),
          ElevatedButton(
            child: Text('Fair BottomNavigationBar'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FairWidget(
                            path:
                                'assets/bundle/bottomnavigationbar/lib_bottom_navigation_bar_bottomnavigationbar_widget.fair.json',
                          )));
            },
          ),
        ],
      ),
    );
  }
}
