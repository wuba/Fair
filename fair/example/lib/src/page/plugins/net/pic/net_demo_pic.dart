/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair_example/src/page/plugins/fair_common_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@FairPatch()
class PicNetDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PicNetDemoPageStateful();
  }
}

class _PicNetDemoPageStateful extends State {
  final _picData = PicData();

  void onClick() {
    var order_id = 10;
    FairCommonPlugin().http({
      'pageName': '#FairKey#',
      'method': 'GET',
      'url': 'https://www.wanandroid.com/banner/json',
      'data': {
        'order_id': order_id,
        'content': 'test',
        'aa': ['hello', 'world']
      },
      'callback': (resp) {
        if (resp == null) {
          return;
        }
        var data = resp['data'];
        String u = data[0]['imagePath'];
        _picData.picUrl = u;
        _picData.title = data[0]['title'];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('加载网络获取地址的图片'),
      ),
      body: Container(
        child: Column(
          children: [
            Image.network('${_picData.picUrl}', width: 500),
            Text(
              '${_picData.title}',
              maxLines: 3,
              style: TextStyle(color: Colors.blue, fontSize: 19),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_outlined),
        onPressed: onClick,
      ),
    );
  }
}

class PicData extends Object {
  String picUrl =
      'https://www.youxinpai.com/public/home/widget/services/4s/img/img_4s_4_0943ac1.jpg';
  String title = '';
  String content = '';
}
