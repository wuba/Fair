import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class RefreshIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RefreshIndicatorDemoState();
}

class _RefreshIndicatorDemoState extends State<RefreshIndicatorDemo> {
  var _list = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RefreshIndicatorDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _list.add(_list.length + 1);
                });
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('fair ${_list[index]}'),
                  );
                },
                itemExtent: 50,
                itemCount: _list.length,
              ),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/refresh_indicator/lib_refresh_indicator_refresh_indicator_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
