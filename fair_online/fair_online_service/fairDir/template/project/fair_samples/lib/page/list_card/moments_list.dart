import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

import '../../fair_common.dart';

@FairPreviewPage()
@FairPatch()
class MomentsList extends StatefulWidget {
  const MomentsList({Key? key}) : super(key: key);

  @override
  State<MomentsList> createState() => _MomentsListState();
}

class _MomentsListState extends State<MomentsList> {
  final List<MomentsModel> _listData = <MomentsModel>[];
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
          'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/ed04fcaf655b79b1ae81ad2836ce67e9_moments_data.json',
      'data': {'page': _page},
      'success': (resp) {
        if (resp == null) {
          return;
        }
        var data = resp['data'];
        data.forEach((item) {
          var dataItem = MomentsModel();
          try {
            dataItem.avatar = item.avatar;
            dataItem.username = item.username;
            dataItem.content = item.content;
            dataItem.picture = item.picture;
            dataItem.likes = item.likes;
            dataItem.comments = item.comments;
          } catch (e) {
            dataItem.avatar = item['avatar'];
            dataItem.username = item['username'];
            dataItem.content = item['content'];
            dataItem.picture = item['picture'];
            dataItem.likes = item['likes'];
            dataItem.comments = item['comments'];
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

  String _getAvatar(int index) {
    return _listData[index].avatar;
  }

  String _getUsername(int index) {
    return _listData[index].username;
  }

  String _getContent(int index) {
    return _listData[index].content;
  }

  String _getPicture(int index) {
    return _listData[index].picture;
  }

  String _getLikes(int index) {
    return _listData[index].likes;
  }

  String _getComments(int index) {
    return _listData[index].comments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: Sugar.isNestedScrollViewHeaderSliversBuilder(
            context: context,
            innerBoxIsScrolled: false,
            headerSliverBuilder: <Widget>[
              SliverAppBar(
                pinned: true,
                stretch: true,
                expandedHeight: 200,
                snap: false,
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Image.network(
                    'https://pic3.58cdn.com.cn/nowater/frs/n_v30298bfe0255a4f42a38399e559dadd1e.png',
                    height: 22,
                    width: 22,
                  ),
                  onPressed: (() => {}),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 10, 2),
                        child: Text(
                          '欢迎来到妮妮朋友圈',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  //标题居中
                  centerTitle: true,
                  background: Image.network(
                    'https://img1.baidu.com/it/u=1500716295,3279382336&fm=253&fmt=auto&app=120&f=JPEG',
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ]),
        body: Container(
          color: Colors.white,
          child: Sugar.ifEqualBool(
            isDataEmpty(),
            trueValue: Center(
              child: Text(
                '加载中...',
              ),
            ),
            falseValue: Sugar.listBuilder(
                itemCount: dataLength(),
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(_getAvatar(index)),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    _getUsername(index),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                        color: Colors.black),
                                  )
                                ],
                              )),
                              Container(
                                width: 30,
                                height: 30,
                                child: Image.network(
                                    'https://pic6.58cdn.com.cn/nowater/frs/n_v33db8caaa95cc4d1eb9426e9b991bed34.png'),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  _getContent(index),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                      color: Colors.black),
                                ))
                              ],
                            ),
                          ),
                          Card(
                            child: Image(
                              image: NetworkImage(_getPicture(index)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Image.network(
                                          'https://pic7.58cdn.com.cn/nowater/frs/n_v35812c5fc830e49d991d5e17633729392.png'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      _getLikes(index),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Image.network(
                                          'https://pic4.58cdn.com.cn/nowater/frs/n_v3c264a2d3f9864ecabd8f05ee944ccafe.png'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      _getComments(index),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                          color: Colors.black54),
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image.network(
                                      'https://pic7.58cdn.com.cn/nowater/frs/n_v33e401d24fa6f44a1ac7a7d3319eef7e6.png'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class MomentsModel extends Object {
  String avatar = '';
  String username = '';
  String content = '';
  String picture = '';
  String likes = '';
  String comments = '';
}
