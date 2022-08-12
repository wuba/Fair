import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class ReorderableListViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReorderableListViewDemoState();
}

class _ReorderableListViewDemoState extends State<ReorderableListViewDemo> {
  var items = List.generate(20, (int i) => '$i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RefreshIndicatorDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView(
              children: <Widget>[
                for (String item in items)
                  Container(
                    key: ValueKey(item),
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.primaries[
                            int.parse(item) % Colors.primaries.length],
                        borderRadius: BorderRadius.circular(10)),
                  )
              ],
              onReorder: (int oldIndex, int newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                var child = items.removeAt(oldIndex);
                items.insert(newIndex, child);
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/reorderable_listview/lib_reorderable_listview_reorderable_listview_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
