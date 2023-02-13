import 'dart:core';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

import '../../fair_common.dart';

@FairPreviewPage()
@FairPatch()
class SugarTabBarPage extends StatefulWidget {
  SugarTabBarPage({Key? key}) : super(key: key);

  @override
  State<SugarTabBarPage> createState() => _SugarTabBarPageState();
}

class _SugarTabBarPageState extends State<SugarTabBarPage> {
  final List<TabBarModel> _listData = <TabBarModel>[];
  int _page = 0;

  @override
  void initState() {
    onLoad();
    super.initState();
  }

  /// 生命周期回调，函数名不可修改
  void onLoad() {
    requestData();
  }

  /// 生命周期回调，函数名不可修改
  void onUnload() {}

  void requestData() {
    _page++;
    FairNet().request({
      'pageName': '#FairKey#',
      'method': 'GET',
      'url':
          'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/81900c8ba18b20328389b43c729a251e_tabbar_data.json',
      'data': {'page': _page},
      'success': (resp) {
        if (resp == null) {
          return;
        }
        var data = resp['data'];
        data.forEach((item) {
          var dataItem = TabBarModel();
          try {
            dataItem.imagePath = item.imageUrl;
            dataItem.title = item.title;
          } catch (e) {
            dataItem.imagePath = item['imageUrl'];
            dataItem.title = item['title'];
          }
          _listData.add(dataItem);
        });
        setState(() {});
      }
    });
  }

  bool isDataEmpty() {
    return _listData.isEmpty;
  }

  String _getImagePath(int index) {
    return _listData[index].imagePath;
  }

  String _getTitle(int index) {
    return _listData[index].title;
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
                IconButton(
                    onPressed: Sugar.onTapEmpty(), icon: Icon(Icons.search)),
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
            body: Sugar.ifEqualBool(isDataEmpty(),
                trueValue: Center(
                  child: Text(
                    '加载中...',
                  ),
                ),
                falseValue: TabBarView(
                  children: <Widget>[
                    _allTabList(),
                    _getList(),
                    _allTabList(),
                  ],
                ))));
  }

  Widget _getList() {
    return Sugar.listBuilder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            height: 140,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
              ),
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
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(_getImagePath(index)),
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        // color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_getTitle(index),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('SubTitle-SubTitle'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// All && Inactive customScrollView
  Widget _allTabList() {
    return Container(
      color: Colors.grey[400],
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: Sugar.sliverChildBuilderDelegate(
              builder: (content, index) {
                return Container(
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
                );
              },
              childCount: 3, //findChildIndexCallback
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarModel extends Object {
  String imagePath = '';
  String title = '';
}
