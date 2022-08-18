import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SliverListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverListDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
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
              path:
                  'assets/bundle/sliver/lib_sliver_list_sliverlist_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
