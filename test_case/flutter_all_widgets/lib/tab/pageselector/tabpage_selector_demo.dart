import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class TabPageSelectorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabPageSelectorDemoState();
}

class _TabPageSelectorDemoState extends State<TabPageSelectorDemo> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('TabPageSelectorDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: TabPageSelector(
                    controller: _controller,
                    color: Colors.white,
                    selectedColor: Colors.red,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      Container(
                        color: Colors.blue,
                      ),
                      Container(
                        color: Colors.red,
                      ),
                      Container(
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/tab/lib_tab_pageselector_tabpage_selector_fair.fair.json',
              data: {'fairProps': jsonEncode({})},
            ),
          )
        ],
      ),
    );
  }
}
