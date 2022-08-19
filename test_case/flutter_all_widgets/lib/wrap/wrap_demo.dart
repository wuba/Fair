import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class WrapDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WrapDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Wrap(
              children: List.generate(10, (i) {
                double w = 50.0 + 10 * i;
                return Container(
                  color: Colors.primaries[i],
                  height: 50,
                  width: w,
                  child: Text('$i'),
                );
              }),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/wrap/lib_wrap_wrap_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
