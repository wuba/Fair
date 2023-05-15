import 'package:fair/fair.dart';
import 'package:example/plugins/net/fair_net_plugin.dart';
import 'package:flutter/material.dart';

@FairPatch()
class HomeScrollView extends StatefulWidget {
  const HomeScrollView({Key? key}) : super(key: key);

  @override
  State<HomeScrollView> createState() => _HomeScrollViewState();
}

class _HomeScrollViewState extends State<HomeScrollView> {
  final List<HomeItemData> _listData = <HomeItemData>[];
  int _page = 0;

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
          'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/3158c2fc5e3ed9bc08b34f8d694c763d_home_scroll_data.json',
      'data': {'page': _page},
      'success': (resp) {
        if (resp == null) {
          return;
        }
        var data = resp['data'];
        data.forEach((item) {
          var dataItem = HomeItemData();
          try {
            dataItem.imagePath = item.imageUrl;
          } catch (e) {
            dataItem.imagePath = item['imageUrl'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Sugar.ifEqualBool(
      isDataEmpty(),
      trueValue: () => Center(
        child: Text(
          '加载中...',
        ),
      ),
      falseValue: () => CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('CustomScrollView模版'),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Flutter Best UI x Fair 最佳实践',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ),
          ),

          ///网格
          SliverGrid(
            gridDelegate: Sugar.sliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 2.0,
            ),
            delegate: Sugar.sliverChildBuilderDelegate(
                builder: (content, index) {
                  return AspectRatio(
                    aspectRatio: 1.5,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      child: Image.network(_getImagePath(index),
                          fit: BoxFit.cover),
                    ),
                  );
                },
                childCount: 4),
          ),

          ///列表
          SliverList(
            delegate: Sugar.sliverChildBuilderDelegate(
                builder: (content, index) {
                  return AspectRatio(
                    aspectRatio: 1.5,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      child: Image.network(_getImagePath(index),
                          fit: BoxFit.cover),
                    ),
                  );
                },
                childCount: 3),
          ),
        ],
      ),
    ));
  }
}

class HomeItemData extends Object {
  String imagePath = '';
}
