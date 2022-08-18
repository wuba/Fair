import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SliverFixedExtentListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverFixedExtentListDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverFixedExtentList(
                  itemExtent: 80.0,
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Card(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.primaries[(index % 18)],
                        child: Text(''),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/sliver/lib_sliver_fixed_extent_list_sliver_fixed_extent_list_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
