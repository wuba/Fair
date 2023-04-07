/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair_example/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PicNetDemoFairPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PicNetDemoFairPageState();
}

class PicNetDemoFairPageState extends State<PicNetDemoFairPage> {
  // String path =
  //     'assets/fair/lib_src_page_plugins_net_pic_net_demo_pic.fair.json';
  String path =
      //'assets/fair/lib_src_page_plugins_net_pic_net_demo_pic2.fair.json'

      Assets.assets_fair_lib_src_page_plugins_net_pic_net_demo_pic2_fair_json;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FairWidget(
        name: 'pic_name',
        path: path,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            path = Assets
                .assets_fair_lib_src_page_plugins_net_pic_net_demo_pic_fair_json;
            // 'assets/fair/lib_src_page_plugins_net_pic_net_demo_pic.fair.json';
          });
        },
      ),
    );
  }
}
