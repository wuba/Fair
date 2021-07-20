import 'package:fair_example/src/page/logic-page/sample_logic_page.dart';
import 'package:fair_example/src/page/logic-page2page/sample_logic_page2page.dart';
import 'package:flutter/material.dart';

class LogicHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('58 Fair'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            addItem('原生列表 + 卡片动态', () {
              Navigator.pushNamed(
                  context, 'sample_list_with_dynamic_cell_page');
            }),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('界面动态', () {
              // 动态界面
              Navigator.pushNamed(context, 'fair_page',
                  arguments: {'name': '界面动态', 'path': 'assets/bundle/lib_src_page_logic-page_sample_logic_page.fair.json', 'data': {'pageName': '界面动态'}});
              // 原生界面
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => SampleLogicPage({'pageName': '界面动态'}),
              // ));
            }),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('动态界面跳转&传值', () {
              // 动态界面跳转&传值
              // Navigator.pushNamed(context, 'fair_page',
              //     arguments: {'name': '动态界面跳转&传值', 'path': 'assets/bundle/lib_src_page_logic-page2page_sample_logic_page2page.fair.json', 'data': {'pageName': '动态界面跳转&传值'}});
              // 原生界面
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SampleLogicPage2Page({'pageName': '动态界面跳转&传值'}),
              ));
            }),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('自定义插件', () {}),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('DSL 逻辑语法糖', () {}),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('列表', () {}),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
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
