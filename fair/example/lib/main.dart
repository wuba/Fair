/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair_example/src/page/list/sample_list_with_logic.dart';
import 'package:fair_example/src/page/modules.dart';
import 'package:fair_example/src/page/plugins/net/fair_plugin.dart';
import 'package:fair_example/src/page/plugins/net/sampe_list_view_src.dart';
import 'package:fair_example/src/page/plugins/permission/fair_permission_plugin.dart';
import 'package:flutter/material.dart';

import 'src/page/fair_example_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //todo 是否可以通过注解的方式注册
  FairPluginDispatcher.registerPlugin('FairNet', FairNet());
  FairPluginDispatcher.registerPlugin('WBPermission', WBPermission());

  Runtime().loadCoreJs().then((value) => _runApp());
}

void _runApp() {
  runApp(FairApp(
    modules: {
      ShowFairAlertModule.tagName: () => ShowFairAlertModule(),
    },
    child: MaterialApp(
      // home: FairWidget(
      //   // todo：测试demo
      //   // name: 'widget_method_demo',
      //   // path: 'assets/bundle/lib_widget_method_demo.json',
      //   // data: {
      //   //   'index2': 3,
      //   //   'index3': 4,
      //   // },
      //   // name: 'hello_world',
      //   // path: 'assets/bundle/lib_src_page_hello_world.fair.bin',
      //   name: 'hello_world',
      //   jsPath: 'assets/js/lib_src_page_sample_page_with_logic.js',
      //   path: 'assets/bundle/lib_src_page_hello_world.fair.json',
      // )
      home: JRListWidget(),
      routes: {
        'sample_dynamic_page': (_) => SampleWanAndroidPageSrc(),
        'sample_list_with_dynamic_cell_page': (_) => DynamicCellPage(),
      },
    ),
  ));
}
