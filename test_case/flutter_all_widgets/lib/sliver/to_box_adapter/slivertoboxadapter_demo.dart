import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SliverToBoxAdapterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SliverToBoxAdapterDemo'),
        ),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('复仇者联盟'),
                      background: Image.network(
                        'https://github.com/wuba/fair/raw/main/best-ui-template.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text('Fair'),
                  ),
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
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: FairWidget(
              path:
                  'assets/bundle/sliver/lib_sliver_to_box_adapter_slivertoboxadapter_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            )),
          ],
        ),
      ),
    );
  }
}
