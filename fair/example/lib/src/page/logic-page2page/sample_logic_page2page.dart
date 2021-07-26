/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

part 'sample_logic_page2page.js.dart';

@FairPatch()
class SampleLogicPage2Page extends StatefulWidget {

  SampleLogicPage2Page(dynamic data) {
    fairProps = data;
  }

  @override
  State<StatefulWidget> createState() {
    // 配置代理，由于使用Part方式，需要重构State的数据驱动部分，实现原生和动态的一致
    return FairStateWarpper(_State());
  }
}

class _State extends State<SampleLogicPage2Page> {
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
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.open_in_new),
            onPressed: () {
              Navigator.pushNamed(context, 'fair_page', arguments: {
                'name': '逻辑动态界面跳转&传值',
                'path':
                    'assets/bundle/lib_src_page_logic-page_sample_logic_page.fair.json',
                'data': {'pageName': getTitle()}
              });
            },
          )
        ],
      ),
    );
  }
}
