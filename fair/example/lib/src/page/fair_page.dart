/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FairPage extends StatelessWidget {
  String _route;
  var _data;

  FairPage(String route, {Map data}) {
    _route = route;
    _data = data;
  }

  @override
  Widget build(BuildContext context) {
    var jsPath = _route + '.js';
    var DSLPath = _route + '.json';
    return FairWidget(
      name: _route,
      jsPath: jsPath,
      path: DSLPath,
      data: {'fairProps': jsonEncode(_data)},
    );
  }
}
