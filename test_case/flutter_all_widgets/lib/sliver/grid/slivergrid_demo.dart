import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SliverGridDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverGridDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
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
              path: 'assets/bundle/sliver/lib_sliver_grid_slivergrid_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
