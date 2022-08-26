import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SliverPaddingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverPaddingDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(10),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      color: Colors.green,
                      child: Center(
                        child: Text('Fair'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/sliver/lib_sliver_padding_sliverpadding_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
