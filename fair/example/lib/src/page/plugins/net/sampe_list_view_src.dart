import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:fair_example/src/model/bean/loupan_bean.dart';
import 'package:fair_example/src/page/plugins/net/fair_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'sample_list_part.dart';

///  FairWidget作为列表的加载效果
class SampleWanAndroidPageSrc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SampleWanAndroidPageSrcState();
}

class SampleWanAndroidPageSrcState extends State<SampleWanAndroidPageSrc> {
  @override
  void initState() {
    super.initState();
    requestNet(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title: Text('建议release或profile模式'),),
        body: Container(
          color: Colors.amber[0],
          child: ListView.builder(
            padding: EdgeInsets.only(left: 20, right: 20),
            itemCount: resultMap.length,
            itemBuilder: (BuildContext context, int index) {
              return getItem(index);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: onTapText,
        ));
  }

  void onTapText() {}
}
