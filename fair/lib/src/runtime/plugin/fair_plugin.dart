/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

import 'package:fair/src/runtime/plugin/fair_common_plugin.dart';

abstract class IFairPlugin with FairCommonPluginMixin {
  Future<dynamic> invoke(dynamic par) async {
    var resp =
        await Function.apply(getRegisterMethods()[getMethodName(par)]!, [par]);
    return Future.value(resp);
  }

  String getMethodName(dynamic par) {
    dynamic a;
    if (par is Map) {
      a = par;
    } else {
      a = jsonDecode(par);
    }

    var name = a['className']?.toString() ?? '';

    if (name.contains('#')) {
      var list = name.split('#');
      if (list.length >= 2) {
        return list[1];
      }
    }

    return '';
  }

  Map<String, Function> getRegisterMethods();
}
