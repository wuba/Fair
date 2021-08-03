/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair_example/src/page/plugins/net/fair_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
 * 显示一个大暑的页面
 */
@FairPatch()
class PicDemoPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PicNetDemoPageStateful();
  }
}

class _PicNetDemoPageStateful extends State {
  String _picUrl =
      'https://bkimg.cdn.bcebos.com/pic/b3119313b07eca8065388426576e80dda144ac342596';
  String description = '''
大暑，二十四节气之一，夏季最后一个节气。每年的公历7月22日、23日之间，太阳到达黄历120°，是大暑节气。与小暑一样，大暑也是反映夏季炎热程度的节令，而大暑表示天气炎热至极。

中国古人将大暑分为三候：“一候腐草为萤；二候土润溽暑；三候大雨时行。”大暑节气正值“三伏天”里的“中伏”前后，是一年中最热的时期，气温最高，农作物生长最快，同时，很多地区的旱、涝、风灾等气象灾害也最为频繁。抢收抢种，抗旱排涝防台风和田间管理等任务很重。
  
大暑节气有晒伏姜、喝伏茶、烧伏香、送“大暑船”等习俗。此时天气湿热，很容易导致身体受潮湿气过重。养生既要懂得防暑降温，还要着重祛湿。  
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义插件'),
      ),
      body: Container(
        child: Column(
          children: [
            Image.network(
              _picUrl,
              width: 500,
              height: 150,
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
            ),
            Expanded(
              child: Text(
                description,
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
