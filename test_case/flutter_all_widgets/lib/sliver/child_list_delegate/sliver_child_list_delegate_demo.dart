import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SliverChildListDelegateDemo extends StatelessWidget {
  List<Widget> _getChildren() {
    final result = <Widget>[];
    for (int i = 0; i < 10; i++) {
      result.add(Card(
        child: Container(
          alignment: Alignment.center,
          color: Colors.primaries[(i % 18)],
          child: Text(''),
        ),
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverChildListDelegateDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(_getChildren()),
                ),
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/sliver/lib_sliver_child_list_delegate_sliver_child_list_delegate_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
