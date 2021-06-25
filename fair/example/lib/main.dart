/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair_example/src/fair_plugin.dart';
import 'package:fair_example/src/page/hello_world_proxy2.dart';
import 'package:fair_example/src/page/list/sample_list_with_logic.dart';
import 'package:fair_example/src/page/modules.dart';
import 'package:fair_example/src/page/plugins/net/sampe_list_view_src.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FairPluginDispatcher.registerPlugin('FairNet', FairNet());
  runApp(FairApp(
    delegate: {
      // 'hello_world': (ctx, _) => HelloWorldDelegate(),
      'hello_world': (ctx, _) => HelloWorldDelegate2(),
      'hello_world2': (ctx, _) => HelloWorldDelegate2(),
    },
    modules: {
      ShowFairAlertModule.tagName: () => ShowFairAlertModule(),
    },
    child: MaterialApp(
      home: FairWidget(
        name: 'hello_world',
        jsPath: 'file:///android_asset/lib_src_page_sample_page_with_logic.js',
        path: 'assets/bundle/lib_src_page_hello_world.fair.json',
      ) /*HelloWorldPage()*/,
      routes: {
        'sample_dynamic_page': (_) => SampleWanAndroidPageSrc(),
        'sample_list_with_dynamic_cell_page': (_) => DynamicCellPage(),
      },
    ),
  ));
}
