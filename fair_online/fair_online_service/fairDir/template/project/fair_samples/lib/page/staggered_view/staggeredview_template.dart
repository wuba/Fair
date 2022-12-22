import 'package:fair/fair.dart';
import '../../fair_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

@FairPreviewPage()
@FairPatch()
class StaggeredItemView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StaggeredItemViewState();
}

class _StaggeredItemViewState extends State<StaggeredItemView> {
  final List<StaggeredViewModel> _listData = <StaggeredViewModel>[];
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
          'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/9e04cb323c425e6520cc2a3dea4b5793_staggeredview_data.json',
      'data': {'page': _page},
      'success': (resp) {
        if (resp == null) {
          return;
        }
        var data = resp['data'];
        data.forEach((item) {
          var dataItem = StaggeredViewModel();
          try {
            dataItem.picUrl = item.imagePath;
          } catch (e) {
            dataItem.picUrl = item['imagePath'];
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
          title: Text('StaggeredView模版'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: requestData,
          child: Icon(Icons.add),
        ),
        body: Sugar.ifEqualBool(
          isDataEmpty(),
          trueValue: Center(
            child: Text(
              '加载中...',
            ),
          ),
          falseValue: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              children: Sugar.map(
                _listData,
                builder: (StaggeredViewModel item) {
                  return AspectRatio(
                    aspectRatio: 1.5,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      child: Image.network(item.picUrl, fit: BoxFit.cover),
                    ),
                  );
                },
              )),
        ));
  }
}

class StaggeredViewModel extends Object {
  String picUrl = '';
}
