import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class TableDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Table(
              children: [
                TableRow(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.blue),
                    children: [
                      TableCell(child: Text('Fair 一期')),
                      TableCell(child: Text('Fair 二期')),
                      TableCell(child: Text('Fair 三期')),
                    ]),
                TableRow(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.green),
                    children: [
                      TableCell(child: Text('布局动态化')),
                      TableCell(child: Text('逻辑动态化')),
                      TableCell(child: Text('变得更好用')),
                    ]),
                TableRow(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.yellow),
                    children: [
                      TableCell(child: Text('2020')),
                      TableCell(child: Text('2021')),
                      TableCell(child: Text('2022')),
                    ]),
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/table/lib_table_table_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
