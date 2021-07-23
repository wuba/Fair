/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:fair_example/src/page/home_page.dart';
import 'package:fair_example/src/page/list/sample_list_with_dynamic_cell_page.dart';
import 'package:fair_example/src/page/logic_home_page.dart';
import 'package:fair_example/src/page/modules.dart';
import 'package:fair_example/src/page/plugins/net/fair_plugin.dart';
import 'package:fair_example/src/page/plugins/net/pic/net_demo_pic.dart';
import 'package:fair_example/src/page/plugins/net/pic/net_demo_pic2.dart';
import 'package:fair_example/src/page/plugins/net/pic/net_demo_pic_fair.dart';
import 'package:fair_example/src/page/plugins/net/sampe_list_view_src.dart';
import 'package:fair_example/src/page/plugins/permission/fair_permission_plugin.dart';
import 'package:fair_example/src/page/sugers/sugers_home_page.dart';
import 'package:flutter/material.dart';
import 'src/proxy/list_proxy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //
  // FairPluginDispatcher.registerPlugin('FairNet', FairNet());
  // FairPluginDispatcher.registerPlugin('WBPermission', WBPermission());
  //
  // Runtime().loadCoreJs().then((value) => _runApp());
  FairApp.runApplication(
    _getApp(),
    plugins: {
      'FairNet': FairNet(),
      'WBPermission': WBPermission(),
    },
  );
}

void _runApp() {
  runApp(FairApp(
    modules: {
      ShowFairAlertModule.tagName: () => ShowFairAlertModule(),
    },
    delegate: {
      'listLoadMore': (ctx, _) => ListDelegate(),
    },
    child: MaterialApp(
      home: HomePage(),
      routes: {
        'sample_dynamic_page': (_) => SampleWanAndroidPageSrc(),
        'sample_list_with_dynamic_cell_page': (_) => DynamicCellPage(),
        'sample_logic_home_page': (_) => LogicHomePage(),
        'sample_logic_pic_net_demo': (_) => PicNetDemoFairPage(),
        'sample_suger_list_page': (_) => SugerListPage(),
        'fair_page': (context) =>
            FairWidget(
                name: _getParams(context, 'name'),
                path: _getParams(context, 'path'),
                data: {'fairProps': jsonEncode(_getParams(context, 'data'))}),
      },
    ),
  ));
}

_getParams(BuildContext context, String key) =>
    (ModalRoute.of(context).settings.arguments is Map)
        ? (ModalRoute.of(context).settings.arguments as Map)[key]
        : null;

dynamic _getApp() => FairApp(
      modules: {
        ShowFairAlertModule.tagName: () => ShowFairAlertModule(),
      },
      delegate: {
        'listLoadMore': (ctx, _) => ListDelegate(),
      },
      child: MaterialApp(
        home: HomePage(),
        routes: {
          'sample_dynamic_page': (_) => SampleWanAndroidPageSrc(),
          'sample_list_with_dynamic_cell_page': (_) => DynamicCellPage(),
          'sample_logic_home_page': (_) => LogicHomePage(),
          'sample_logic_pic_net_demo': (_) => PicNetDemoFairPage(),
          'fair_page': (context) => FairWidget(
              name: _getParams(context, 'name'),
              path: _getParams(context, 'path'),
              data: {'fairProps': jsonEncode(_getParams(context, 'data'))}),
        },
      ),
    );
