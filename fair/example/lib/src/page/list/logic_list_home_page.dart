/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair_example/src/page/list/cells/sample_list_with_dynamic_cell_page.dart';
import 'package:flutter/material.dart';
import 'load-more/sample_logic_loadmore_page.dart';

class LogicListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('动态列表'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            addItem('原生列表 + 动态卡片', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DynamicCellPage(),
                  ));
            }),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('LoadMore & PullRefresh', () {
              Navigator.pushNamed(context, 'fair_page',
                  arguments: {'name': 'ListLoadMore', 'path': 'assets/bundle/lib_src_page_list_load-more_sample_logic_loadmore_page.fair.json', 'data': {'pageName': 'ListLoadMore'}});

              // 原生界面
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => JRListWidget({'pageName': 'ListLoadMore'}),
              //     ));
            }),

            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            // addItem('ListView.separated', () {
            //   // 原生界面
            //   // Navigator.push(
            //   //     context,
            //   //     MaterialPageRoute(
            //   //       builder: (context) =>
            //   //           IfEqualBoolPage({'pageName': 'ifEqualBool'}),
            //   //     ));
            //   Navigator.pushNamed(context, 'fair_page',
            //       arguments: {'name': 'ifEqualBool', 'path': 'assets/bundle/lib_src_page_sugars_ifequalbool_page.fair.json', 'data': {'pageName': 'ifEqualBool'}});
            // }),
            // Container(height: 0.5, color: Color(0xFFE7EBEE)),
          ],
        ));
  }

  Widget addItem(String itemName, dynamic onPress) {
    return GestureDetector(
        child: Container(
            alignment: Alignment.centerLeft,
            color: Colors.white,
            height: 100,
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              itemName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.left,
            )),
        onTap: onPress);
  }
}
