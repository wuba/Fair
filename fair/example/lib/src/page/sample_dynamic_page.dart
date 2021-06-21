/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SampleDynamicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo DynamicWidget')),
      body: FairWidget(
        name: 'hello_world2',
        jsPath:'file:///android_asset/lib_src_page_sample_page_with_logic2.js',
        path: 'assets/bundle/lib_src_page_hello_world.fair.bin',
        // data: {
        //   'content': 'Red Box',
        //   'data.content': '张三',
        //   'data.content2': '李四',
        //   'data.url':
        //       'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2665922796,3139592461&fm=26&gp=0.jpg'
        // },
      ),
    );
  }
}
