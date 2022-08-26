import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class TabBarDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  final List<String> _tabValues = [
    'Fair 一期',
    'Fair 二期',
    'Fair 三期',
  ];

  TabController _controller;

  @override
  void initState() {
    _controller = TabController(
      length: _tabValues.length,
      vsync: ScrollableState(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scaffold(
              appBar: AppBar(
                title: Text('TabBarDemo'),
                bottom: TabBar(
                  tabs: _tabValues.map((f) {
                    return Text(f);
                  }).toList(),
                  controller: _controller,
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.black,
                  indicatorWeight: 5.0,
                  labelStyle: TextStyle(height: 2),
                ),
              ),
              body: TabBarView(
                  controller: _controller,
                  children: _tabValues.map((f) {
                    return Center(
                      child: Text(f),
                    );
                  }).toList())),
        ),
        Expanded(
          child: FairWidget(
            path: 'assets/bundle/tab/lib_tab_tabbar_tabbar_fair.fair.json',
            data: {'fairProps': jsonEncode({})},
          ),
        )
      ],
    );
  }
}
