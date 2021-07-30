/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:fair_example/src/page/home_page.dart';
import 'package:fair_example/src/page/logic-page2page/sample_logic_page2page.dart';
import 'package:fair_example/src/page/modules.dart';
import 'package:fair_example/src/page/plugins/net/fair_plugin.dart';
import 'package:fair_example/src/page/plugins/permission/fair_permission_plugin.dart';
import 'package:flutter/material.dart';
import 'src/page/dynamic_widget.dart';
import 'src/proxy/list_proxy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FairApp.runApplication(
    _getApp(),
    plugins: {
      'FairNet': FairNet(),
      'WBPermission': WBPermission(),
    },
  );
}

dynamic _getParams(BuildContext context, String key) =>
    (ModalRoute.of(context).settings.arguments is Map)
        ? (ModalRoute.of(context).settings.arguments as Map)[key]
        : null;

dynamic _getData(BuildContext context, String name) {
  var data =
      Map.from((ModalRoute.of(context).settings.arguments as Map)['data']);
  data.addAll({'pageName': name});
  return data;
}

dynamic _getApp() => FairApp(
      modules: {
        ShowFairAlertModule.tagName: () => ShowFairAlertModule(),
      },
      delegate: {
        'ListLoadMore': (ctx, _) => ListDelegate(),
      },
      child: MaterialApp(
        // home: DynamicWidget(content: 'DynamicWidget',),
        home: FairWidget(
            name: 'DynamicWidget',
            path: 'assets/bundle/lib_src_page_dynamic_widget.fair.json',
            data: {"fairProps": json.encode({})}),
        routes: {
          'native_page': (context) => SampleLogicPage2Page(_getData(context, _getParams(context, 'name'))), // 测试Fair跳转原生使用
          'fair_page': (context) => FairWidget(
                  name: _getParams(context, 'name'),
                  path: _getParams(context, 'path'),
                  data: {
                    'fairProps': jsonEncode(
                        _getData(context, _getParams(context, 'name')))
                  }),
        },
      ),
    );
