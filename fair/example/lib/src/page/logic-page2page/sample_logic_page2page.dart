/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class SampleLogicPage2Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Page2PageState();
  }
}

class _Page2PageState extends State<SampleLogicPage2Page> {

  var _count = 10;

  void onTapText() {
    _count = _count + 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('逻辑动态界面跳转&传值'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/logo.png'),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Text('$_count'),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            heroTag: 'add',
            onPressed: onTapText,
          ),
          FloatingActionButton(
            child: Icon(Icons.open_in_new),
            heroTag: 'open_in_new',
            onPressed: () {
              Navigator.pushNamed(context, 'fair_page', arguments: {
                'name': '逻辑动态界面跳转&传值',
                'path':
                    'assets/bundle/lib_src_page_logic-page2page_sample_logic_page2page.fair.json',
                'data': {'_count': 58}
              });
            },
          )
        ],
      ),
    );
  }
}
