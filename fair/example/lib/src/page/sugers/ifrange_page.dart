/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import '../../model/bean/list_with_logic_bean.dart';
import 'package:flutter/material.dart';

@FairPatch()
class IfRangePage extends StatefulWidget {
  var fairProps;

  IfRangePage(dynamic data) {
    fairProps = data;
  }

  @override
  State<StatefulWidget> createState() {
    return FairStateWarpper(_State());
  }
}

class _State extends State<IfRangePage> {
  @FairProps()
  var fairProps;

  var _list = [2, 4, 6, 8, 10];
  int _count = 0;

  String getTitle() {
    return fairProps['pageName'];
  }

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  void onTapText() {
    setData(fairProps['pageName'], {_count: _count++});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Sugar.ifRange(_count, _list,
                falseValue: Image.asset('assets/image/logo.png'),
                trueValue: Image.asset('assets/image/logo2.png')),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('_count = $_count'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('_count in  2, 4, 6, 8, 10,  update image !'),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.threesixty),
            onPressed: onTapText,
          )
        ],
      ),
    );
  }
}
