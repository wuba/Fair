/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair_example/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 相机，权限demo
class PermissionSamplePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PermissionSamplePageState();
}

class PermissionSamplePageState extends State<PermissionSamplePage> {
  @override
  Widget build(BuildContext context) {
    return FairWidget(
      name: 'PermissionSamplePage',
      path:
          //'assets/fair/lib_src_page_plugins_permission_sample_permission_page.fair.json'

          Assets
              .assets_fair_lib_src_page_plugins_permission_sample_permission_page_fair_json,
    );
  }
}
