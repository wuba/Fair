/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair_example/assets.dart';
import 'package:flutter/material.dart';

@FairPatch()
class SampleLogicPage2Page extends StatefulWidget {
  var _props;

  SampleLogicPage2Page(this._props);

  @override
  State<StatefulWidget> createState() {
    return _Page2PageState();
  }
}

class _Page2PageState extends State<SampleLogicPage2Page> {
  @FairProps()
  var fairProps;

  var _count;
  var _name;

  void onTapText() {
    _count = _count + 1;
    setState(() {});
  }

  void onLoad() {
    _name = fairProps['pageName'];
    _count = fairProps['_count'];
  }

  @override
  void initState() {
    super.initState();
    fairProps = widget._props;
    onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
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
                'name': '动态界面&传值',
                'path':
                    'assets/fair/lib_src_page_logic-page2page_sample_logic_page2page.fair.json',

                // Assets
                //     .assets_fair_lib_src_page_logic_page2page_sample_logic_page2page_fair_json,
                'data': {'_count': 58}
              });
            },
          )
        ],
      ),
    );
  }
}
