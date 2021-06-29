import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:fair_example/src/model/bean/loupan_bean.dart';
import 'package:fair_example/src/model/bean/list_with_logic_bean.dart';
import 'package:fair_example/src/page/list/cells/sample_page_stateful_cell.dart';
import 'package:flutter/material.dart';

@FairPatch()
class DynamicCellPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<DynamicCellPage> {
  DemoList _response;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    var value =
        '{\"list\": [{ 			\"id\": \"0001\", 			\"type\": \"normal\", 			\"name\": \"58\" 		}, 		{ 			\"id\": \"fair_cell\", 			\"type\": \"fair\", 			\"name\": \"58\", 			\"path\": \"assets/bundle/lib_src_page_sample_page_stateful_cell.json\", 			\"data\": \"{ \\\"_id \\\":  \\\"10000 \\\"}\" 		}, 		{ 			\"id\": \"0001\", 			\"type\": \"normal\", 			\"name\": \"fair\" 		} 	], 	\"total\": 10 }';
    _response = DemoList.fromJson(jsonDecode(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LogicList'),
        ),
        body: Container(
            color: Colors.white,
            child: ListView.builder(
                padding: EdgeInsets.only(left: 20, right: 20),
                itemCount: _response.list.length,
                itemBuilder: (BuildContext context, int position) {
                  return getItem(_response.list[position]);
                })));
  }

  Widget getItem(var item) {
    if (item.type == 'fair') {
      List goodsList = List<GoodsDesc>();
      goodsList.add(GoodsDesc(boldText: '汤臣一品', normalText: ''));
      goodsList.add(GoodsDesc(boldText: '', normalText: '上海浦东新区陆家嘴'));
      goodsList.add(GoodsDesc(boldText: '90000', normalText: '万'));
      LouPanDetail louPanDetail = LouPanDetail(
          id: 1,
          number: 100 * 20,
          type: 0,
          goodsId: 111,
          imgUrl:
              'http://pic1.ajkimg.com/display/anjuke/d6e675-%E5%8E%A6%E9%97%A8%E6%B5%8B%E8%AF%95%E5%85%AC%E5%8F%B8/3ed05d79ec1de21e4fbbaf146573985a-800x570.jpg',
          goodsDesc: goodsList);

      // 动态化效果
      return Container(
          alignment: Alignment.centerLeft,
          color: Colors.white,
          height: 120,
          child: FairWidget(
            name: item.id,
            path: 'assets/bundle/lib_src_page_sample_page_stateful_cell.fair.json',
            jsPath:'assets/js/lib_src_page_sample_page_stateful_cell.js',
            data: {"fairProps": json.encode(louPanDetail)},
          ));

      // 原生实现效果
      // return Container(
      //     alignment: Alignment.centerLeft,
      //     color: Colors.white,
      //     height: 120,
      //     child: StatefulCell(louPanDetail)
      //     );

    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              color: Colors.white,
              height: 100,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(child: _getTitleText(item)),
                  GestureDetector(
                      onTap: () {}, child: Icon(Icons.phone_enabled, size: 30))
                ],
              )),
          Container(height: 0.5, color: Color(0xFFE7EBEE)),
        ],
      );
    }
  }

  Widget _getTitleText(var item) {
    return Text(
      item.name,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.left,
    );
  }
}
