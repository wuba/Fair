import 'package:fair/fair.dart';
import '../../fair_common.dart';
import 'package:flutter/material.dart';

@FairPreviewPage()
@FairPatch()
class PageViewTemplate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageViewTemplateState();
}

class _PageViewTemplateState extends State<PageViewTemplate> {
  final List<PageViewModel> _listData = <PageViewModel>[];
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
          var dataItem = PageViewModel();
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

  String _getText(int index) {
    return _listData[index].title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PageView模版'),
        ),
        body: Sugar.ifEqualBool(isDataEmpty(),
            trueValue: Center(
              child: Text(
                '加载中...',
              ),
            ),
            falseValue: PageView.custom(
              childrenDelegate: Sugar.sliverChildBuilderDelegate(
                builder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                          child: Image.network(_getImagePath(index),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Text(_getText(index)),
                    ],
                  );
                },
                childCount: 3,
              ),
            )));
  }
}

class PageViewModel extends Object {
  String imagePath = '';
  String title = '';
}
