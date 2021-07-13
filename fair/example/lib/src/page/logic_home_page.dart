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
              Navigator.pushNamed(context, 'sample_logic_dynamic_page',
                  arguments: {'pageName': '界面动态'});
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
