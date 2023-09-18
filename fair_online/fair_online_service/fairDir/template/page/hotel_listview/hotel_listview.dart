import 'package:fair/fair.dart';
import '../../fair_common.dart';
import 'package:flutter/material.dart';

@FairPreviewPage()
@FairPatch()
class @@PageName@@ extends StatefulWidget {
  @@PageName@@({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _@@PageName@@State();
}

class _@@PageName@@State extends State<@@PageName@@> {
  final List<HotelModel> _listData = <HotelModel>[];
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
    FairNet().requestData({
      'pageName': '#FairKey#',
      'method': 'GET',
      'url':
          'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/3be6c61070d3b48c8165af5d18464c0e_hotel_list_data.json',
      'data': {'page': _page},
      'success': (resp) {
        if (resp == null) {
          return;
        }
        var data = resp['data'];
        data.forEach((item) {
          var dataItem = HotelModel();
          try {
              dataItem.imagePath = item.imagePath;
              dataItem.titleTxt = item.titleTxt;
              dataItem.subTxt = item.subTxt;
              dataItem.dist = item.dist + ' km';
              dataItem.reviews = item.reviews + ' reviews';
              dataItem.perNight = item.perNight + '';
          } catch (e) {
              dataItem.imagePath = item['imagePath'];
              dataItem.titleTxt = item['titleTxt'];
              dataItem.subTxt = item['subTxt'];
              dataItem.dist = '${item['dist']} km';
              dataItem.reviews = '${item['reviews']} reviews';
              dataItem.perNight = '${item['perNight']}';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ListView.builder模版'),
        ),
        backgroundColor: Color(0xFFFEFEFE),
        body: Sugar.ifEqualBool(isDataEmpty(),
            trueValue: () => Center(
              child: Text(
                '加载中...',
              ),
            ),
            falseValue: () => Container(
              color: Color(0xFFFFFFFF),
              child: ListView(
                children: Sugar.map(_listData, builder: (HotelModel item) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 8, bottom: 16),
                    child: Container(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                AspectRatio(
                                  aspectRatio: 2,
                                  child: Image.network(item.imagePath,
                                      fit: BoxFit.cover),
                                ),
                                Container(
                                  color: Color(0xFFFFFFFF),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, top: 8, bottom: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  item.titleTxt,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      item.subTxt,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Icon(
                                                      Icons.location_on_rounded,
                                                      size: 12,
                                                      color: Color(0xFF54D3C2),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        item.dist,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        item.reviews,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16, top: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              item.perNight,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Text(
                                              '/per night',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Material(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Color(0xFF54D3C2),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )));
  }
}

class HotelModel extends Object {
  String imagePath = '';
  String titleTxt = '';
  String subTxt = '';
  String dist = '';
  String reviews = '';
  String perNight = '';
}
