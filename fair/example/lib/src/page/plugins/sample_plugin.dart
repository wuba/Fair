/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair_example/src/page/plugins/net/pic/net_demo_pic.dart';
import 'package:fair_example/src/page/plugins/permission/sample_permission_demo_page.dart';
import 'package:fair_example/src/page/plugins/permission/sample_permission_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'net/pic/net_demo_pic_fair.dart';

class SamplePluginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SamplePluginState();
}

class SamplePluginState extends State<SamplePluginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义插件'),
      ),
      body: ListView(
        children: [
          addItem('网络功能', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PicNetDemoFairPage()));
                // MaterialPageRoute(builder: (context) => PicNetDemoPage()));
          }),
          Container(height: 0.5, color: Color(0xFFE7EBEE)),
          addItem('拍照功能', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PermissionSamplePage()));
            // builder: (context) => PermissionPage()));
          }),
          Container(height: 0.5, color: Color(0xFFE7EBEE)),
        ],
      ),
    );
  }

  Widget addItem(String itemName, dynamic onPress) {
    return GestureDetector(
        child: Container(
            alignment: Alignment.centerLeft,
            color: Colors.white,
            height: 100,
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              itemName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.left,
            )),
        onTap: onPress);
  }
}
