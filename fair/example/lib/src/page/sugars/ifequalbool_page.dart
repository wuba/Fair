/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import '../../model/bean/list_with_logic_bean.dart';
import 'package:flutter/material.dart';

@FairPatch()
class IfEqualBoolPage extends StatefulWidget {
  var fairProps;

  IfEqualBoolPage(dynamic data) {
    fairProps = data;
  }

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<IfEqualBoolPage> {
  @FairProps()
  var fairProps;

  int _count = 0;

  String getTitle() {
    return fairProps['pageName'];
  }

  void onTapText() {
    _count = _count + 1;
    setState(() {});
  }

  bool _countCanMod2() {
    return _count % 2 == 1;
  }

  Widget _buildTitle() {
    return Text(getTitle());
  }

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sugar.ifEqualBool(_countCanMod2(),
            //     falseValue: Image.asset('assets/image/logo.png'),
            //     trueValue: Image.asset('assets/image/logo2.png')),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('_count = $_count'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('if _count % 2 == 1,  update image !'),
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
