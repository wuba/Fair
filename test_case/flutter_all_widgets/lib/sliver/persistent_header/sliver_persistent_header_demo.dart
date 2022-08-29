import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SliverPersistentHeaderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverPersistentHeaderDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  delegate: FairSliverPersistentHeaderDelegate(),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 3),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      color: Colors.primaries[index % Colors.primaries.length],
                    );
                  }, childCount: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path:
                  'assets/bundle/sliver/lib_sliver_persistent_header_sliver_persistent_header_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}

class FairSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text('Fair SliverPersistentHeader Demo',
            style: TextStyle(color: Colors.white)));
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      false; // 如果内容需要更新，设置为true
}
