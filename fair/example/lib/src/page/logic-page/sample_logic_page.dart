/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import '../../model/bean/list_with_logic_bean.dart';
import 'package:flutter/material.dart';
part 'sample_logic_page.js.dart';

@FairPatch()
class SampleLogicPage extends StatefulWidget {
  SampleLogicPage(dynamic data) {
    fairProps = data;
  }

  @override
  State<StatefulWidget> createState() {
    // 配置代理，由于使用Part方式，需要重构State的数据驱动部分，实现原生和动态的一致
    return FairStateWarpper(_State());
  }
}

class _State extends State<SampleLogicPage> {
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
            child: Icon(Icons.add),
            onPressed: onTapText,
          )
        ],
      ),
    );
  }
}
