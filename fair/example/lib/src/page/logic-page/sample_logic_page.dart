/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import '../../model/bean/list_with_logic_bean.dart';
import 'package:flutter/material.dart';

@FairPatch()
class SampleLogicPage extends StatefulWidget {
  var fairProps;

  SampleLogicPage(dynamic data) {
    fairProps = data;
  }

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<SampleLogicPage> {
  @FairProps()
  var fairProps;

  final DemoList _demoList = DemoList(list: List.empty(), total: 0);

  String getTitle() {
    return fairProps['pageName'];
  }

  void onTapText() {
    _demoList.total = _demoList.total! + 1;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  Widget _titleWidget() {
    return Text(getTitle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/logo.png'),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Text('${_demoList.total}'),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: onTapText,
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
