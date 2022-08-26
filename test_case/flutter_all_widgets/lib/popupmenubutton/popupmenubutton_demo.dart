import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class PopupmenuButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PopupmenuButtonDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'f',
                  child: Text('f'),
                ),
                PopupMenuItem<String>(
                  value: 'a',
                  child: Text('a'),
                ),
                PopupMenuItem<String>(
                  value: 'i',
                  child: Text('i'),
                ),
                PopupMenuItem<String>(
                  value: 'r',
                  child: Text('r'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/popupmenubutton/lib_popupmenubutton_popupmenubutton_fair.fair.json',
              data: {
                'fairProps': jsonEncode({
                  'item': ['f', 'a', 'i', 'r']
                })
              },
            ),
          )
        ],
      ),
    );
  }
}
