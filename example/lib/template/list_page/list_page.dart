import 'package:example/plugins/fair_common_plugin.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class ListDemoPage extends StatefulWidget {
  const ListDemoPage({Key? key}) : super(key: key);

  @override
  State<ListDemoPage> createState() => _ListDemoPageState();
}

class _ListDemoPageState extends State<ListDemoPage> {
  final List<ItemData> _listData = <ItemData>[];
  int _page = 0;

  /// 生命周期回调，函数名不可修改
  void onLoad() {
    requestData();
  }

  /// 生命周期回调，函数名不可修改
  void onUnload() {}

  void requestData() {
    _page++;
    FairCommonPlugin().http({
      'pageName': '#FairKey#',
      'method': 'GET',
      'url':
          'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/3b8ae7a4e0884b4d75b8094f6c83cd8c_list_page_data.json',
      'data': {'page': _page},
      'callback': (resp) {
        if (resp == null) {
          return;
        }
        var data = resp['data'];
        data.forEach((item) {
          var dataItem = ItemData();
          try {
            dataItem.icon = item.icon;
            dataItem.title = item.title;
            dataItem.subTitle = item.subTitle;
            dataItem.distance = item.distance;
          } catch (e) {
            dataItem.icon = item['icon'];
            dataItem.title = item['title'];
            dataItem.subTitle = item['subTitle'];
            dataItem.distance = item['distance'];
          }
          _listData.add(dataItem);
        });
        setState(() {});
      }
    });
  }

  int dataLength() {
    return _listData.length;
  }

  bool isDataEmpty() {
    return _listData.isEmpty;
  }

  String _getIcon(int index) {
    return _listData[index].icon;
  }

  String _getTitle(int index) {
    return _listData[index].title;
  }

  String _getSubTitle(int index) {
    return _listData[index].subTitle;
  }

  String _getDistance(int index) {
    return _listData[index].distance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size(Sugar.width(context), 44),
              child: const Material(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                  child: TextField(
                    controller: null,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.settings_input_component),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black12, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black12, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black12, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                  ),
                ),
              ),
            )),
        body: Container(
            color: Colors.white,
            child: Sugar.ifEqualBool(isDataEmpty(),
                trueValue: () => Center(
                      child: Text(
                        '加载中...',
                      ),
                    ),
                falseValue: () => ListView.builder(
                      itemCount: dataLength(),
                      itemBuilder: Sugar.indexedWidgetBuilder(
                          (context, index) => SizedBox(
                              height: 90.5,
                              width: Sugar.width(context),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            left: 15,
                                            bottom: 10,
                                            right: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.fitHeight,
                                                  image: NetworkImage(
                                                      _getIcon(index)))),
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _getTitle(index),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                _getSubTitle(index),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black26),
                                              ),
                                              Text(
                                                _getDistance(index),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.deepPurple),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child:
                                            Icon(Icons.chevron_right_rounded),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Container(
                                      color: Colors.black12,
                                      height: 0.5,
                                      width: Sugar.width(context),
                                    ),
                                  ),
                                ],
                              ))),
                    ))));
  }
}

class ItemData extends Object {
  String icon = '';
  String title = '';
  String subTitle = '';
  String distance = '';
}
