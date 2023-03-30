import 'dart:core';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@FairPatch()
class SugarTabBarPage extends StatefulWidget {
  final dynamic fairProps;

  SugarTabBarPage({Key? key, required this.fairProps}) : super(key: key);

  @override
  State<SugarTabBarPage> createState() => _SugarTabBarPageState();
}

class _SugarTabBarPageState extends State<SugarTabBarPage> {
  @FairProps()
  late List fairProps;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fair TabBar'),
          automaticallyImplyLeading: false, // 隐藏左侧按钮
          actions: [
            IconButton(onPressed: Sugar.onTapEmpty(), icon: Icon(Icons.search)),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text('All', style: TextStyle(fontSize: 20)),
              ),
              Tab(
                child: Text('Active', style: TextStyle(fontSize: 20)),
              ),
              Tab(
                child: Text('Inactive', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _allTabList(),
            ListView.builder(
              itemBuilder: _activeItemBuilder,
              itemCount: 3,
            ),
            _allTabList(),
          ],
        ),
      ),
    );
  }

  /// All && Inactive customScrollView
  Widget _allTabList() {
    return Container(
      color: Colors.grey[400],
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                Sugar.nullableIndexedWidgetBuilder(
                  (context, index) => Container(
                    height: 140,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                      ),
                      // clipBehavior: Clip.hardEdge,
                      // color: Colors.amber,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 120,
                                  height: 120,
                                  padding: EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                        'https://gd-hbimg.huaban.com/bb8f4ae6711528dc754799afe6b95d438481265d245ac-ROmreT_fw658',
                                        fit: BoxFit.cover),
                                  )),
                              Container(
                                padding: EdgeInsets.all(10),
                                // color: Colors.blue,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('$index',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text('SubTitle-SubTitle'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.radio_button_on_outlined),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                childCount: 3),
          ),
        ],
      ),
    );
  }

  /// Active 假动作 ListView.builder
  Widget _activeItemBuilder(context, index) {
    return Center(
      child: Text("It's _activeItemBuilder here"),
    );
  }
}
