/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair_example/src/fair_plugin.dart';
import 'package:fair_example/src/page/hello_world_proxy2.dart';
import 'package:fair_example/src/page/modules.dart';
import 'package:flutter/material.dart';

import 'src/page/hello_world_proxy.dart';
import 'src/page/sample_dynamic_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FairPluginDispatcher.registerPlugin('FairNet',FairNet());
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
        // todo：测试demo
        // name: 'widget_method_demo',
        // path: 'assets/bundle/lib_widget_method_demo.json',
        // data: {
        //   'index2': 3,
        //   'index3': 4,
        // },
        // name: 'hello_world',
        // path: 'assets/bundle/lib_src_page_hello_world.fair.bin',

        name: 'hello_world',
        jsPath:'file:///android_asset/lib_src_page_sample_page_with_logic.js',
        path: 'assets/bundle/lib_src_page_hello_world.fair.bin',

      ) /*HelloWorldPage()*/,
      routes: {
        'sample_dynamic_page': (_) => SampleDynamicPage(),
      },
    ),
  ));
}
