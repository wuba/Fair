import 'package:fair_example/src/page/logic-page/sample_logic_page.dart';
import 'package:fair_example/src/page/logic-page2page/sample_logic_page2page.dart';
import 'package:fair_example/src/page/sugers/ifequal_page.dart';
import 'package:fair_example/src/page/sugers/ifequalbool_page.dart';
import 'package:fair_example/src/page/sugers/ifrange_page.dart';
import 'package:fair_example/src/page/sugers/map_page.dart';
import 'package:fair_example/src/page/sugers/mapeach_page.dart';
import 'package:flutter/material.dart';

class SugerListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('逻辑语法糖'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            addItem('Sugar.ifEqual', () {
              Navigator.pushNamed(context, 'fair_page',
                  arguments: {'name': 'ifEqual', 'path': 'assets/bundle/lib_src_page_sugers_ifequal_page.fair.json', 'data': {'pageName': 'ifEqual'}});

              // 原生界面
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => IfEqualPage({'pageName': 'ifEqual'}),
              //     ));
            }),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('Sugar.ifEqualBool', () {
              // 原生界面
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //           IfEqualBoolPage({'pageName': 'ifEqualBool'}),
              //     ));
              Navigator.pushNamed(context, 'fair_page',
                  arguments: {'name': 'ifEqualBool', 'path': 'assets/bundle/lib_src_page_sugers_ifequalbool_page.fair.json', 'data': {'pageName': 'ifEqualBool'}});
            }),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('Sugar.ifRange', () {
              // 原生界面
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => IfRangePage({'pageName': 'ifRange'}),
              //     ));
              Navigator.pushNamed(context, 'fair_page',
                  arguments: {'name': 'ifRange', 'path': 'assets/bundle/lib_src_page_sugers_ifrange_page.fair.json', 'data': {'pageName': 'ifRange'}});
            }),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('Sugar.mapEach', () {
              // 原生界面
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => MapEachPage({'pageName': 'mapEach'}),
              //     ));
              Navigator.pushNamed(context, 'fair_page',
                  arguments: {'name': 'mapeach', 'path': 'assets/bundle/lib_src_page_sugers_mapeach_page.fair.json', 'data': {'pageName': 'mapeach'}});
            }),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('Sugar.map', () {
              // 原生界面
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => MapPage({'pageName': 'map'}),
              //     ));
              Navigator.pushNamed(context, 'fair_page',
                  arguments: {'name': 'map', 'path': 'assets/bundle/lib_src_page_sugers_map_page.fair.json', 'data': {'pageName': 'map'}});
            }),
          ],
        ));
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
