/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:fair_example/src/page/home_page.dart';
import 'package:fair_example/src/page/modules.dart';
import 'package:fair_example/src/page/plugins/net/fair_plugin.dart';
import 'package:fair_example/src/page/plugins/permission/fair_permission_plugin.dart';
import 'package:flutter/material.dart';
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

dynamic _getApp() => FairApp(
      modules: {
        ShowFairAlertModule.tagName: () => ShowFairAlertModule(),
      },
      delegate: {
        'ListLoadMore': (ctx, _) => ListDelegate(),
      },
      child: MaterialApp(
        home: HomePage(),
        routes: {
          'fair_page': (context) => FairWidget(
              name: _getParams(context, 'name'),
              path: _getParams(context, 'path'),
              data: {'fairProps': jsonEncode(_getParams(context, 'data'))}),
        },
      ),
    );
