import 'package:example/public_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemplatePage extends StatelessWidget {
  TemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: Text('fair 模板代码'),
        ),
        body: ListView(
          children: [
            addItem('组件模板 ↓↓↓↓↓↓↓↓↓', () {}),
            addItem('Listview >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_hotel_listview_hotel_listview_template.fair.json');
            }),
            addItem('Scrollview >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_scrollview_home_scrollview.fair.json');
            }),
            addItem('Gridview >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_gridview_gridview_template.fair.json');
            }),
            addItem('PageView >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_pageview_pageview_template.fair.json');
            }),
            addItem('StaggeredView >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_staggered_view_staggeredview_template.fair.json');
            }),
            addItem('AppBar >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_appbar_appbar_template.fair.json');
            }),
            addItem('FAB >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_fab_fab_template.fair.json');
            }),
            addItem('Drawer >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_drawer_drawer_template.fair.json');
            }),
            addItem('页面模板 ↓↓↓↓↓↓↓↓↓', () {}),
            addItem('Login >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_login_page_login_page_template.fair.json');
            }),
            addItem('Detail >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_detail_page_fair_detail.fair.json');
            }),
            addItem('ListPage >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_list_page_list_page.fair.json');
            }),
            addItem('ListCard >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_list_card_moments_list.fair.json');
            }),
            addItem('TabBar >>>', () {
              showWidget(context,
                  fairArguments: {},
                  fairPath:
                      'assets/fair/lib_template_tabbar_page_tabbar_page.fair.json');
            }),
          ],
        ),
      ),
    );
  }

  void showWidget(BuildContext context, {fairPath, fairArguments}) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
      return PublicWidget(
        fairArguments: fairArguments,
        fairPath: fairPath,
      );
    }));
  }

  Widget addItem(String itemName, dynamic onPress) {
    return GestureDetector(
        child: Container(
            alignment: Alignment.centerLeft,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 0.5))),
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
