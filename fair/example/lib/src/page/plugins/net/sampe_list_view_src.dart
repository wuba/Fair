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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.amber[0],
          child: ListView.builder(
            padding: EdgeInsets.only(left: 20, right: 20),
            itemCount: 100,
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

  Widget getItem(var id) {
    List goodsList = <GoodsDesc>[];
    goodsList.add(GoodsDesc(boldText: '汤臣一品 -> $id', normalText: ''));
    goodsList.add(GoodsDesc(boldText: '', normalText: '上海浦东新区陆家嘴'));
    goodsList.add(GoodsDesc(boldText: '90000', normalText: '万'));
    var louPanDetail = LouPanDetail(
        id: 1,
        number: 100 * 20,
        type: 0,
        goodsId: 111,
        imgUrl:
            'http://pic1.ajkimg.com/display/anjuke/d6e675-%E5%8E%A6%E9%97%A8%E6%B5%8B%E8%AF%95%E5%85%AC%E5%8F%B8/3ed05d79ec1de21e4fbbaf146573985a-800x570.jpg',
        goodsDesc: goodsList);

    // 动态化效果
    return Center(
      child: Container(
          height: 250,
          alignment: Alignment.centerLeft,
          color: Colors.white,
          constraints: BoxConstraints(minHeight: 80),
          child: FairWidget(
            name: 'fairPage$id',
            path:
                'assets/bundle/lib_src_page_sample_page_stateful_cell.fair.json',
            jsPath: 'assets/js/lib_src_page_sample_page_stateful_cell.js',
            data: {'fairProps': json.encode(louPanDetail)},
          )),
    );
  }
}
