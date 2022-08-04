import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CupertinoTabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(json);
    return Scaffold(
      appBar: AppBar(
        title: Text("CupertionTabBar"),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 300,
            child: CupertinoTabBarPage(),
          ),
          Container(
            height: 300,
            child: FairWidget(
              path: 'assets/bundle/animated/lib_cupertino_tabbar_cupertino_tabbar_fair.fair.json',
                data: {
                  'fairProps':jsonEncode({'tabList':['首页','我的']})
                }
            ),
          )
        ],
      ),
    );
  }
}

class CupertinoTabBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CupertinoTabBarState();
}

class _CupertinoTabBarState extends State<CupertinoTabBarPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.deepPurple,
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.camera), label: '首页'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "我的"),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return Center(
              child: Text('Page of tab $index'),
            );
          },
        );
      },
    );
  }
}
