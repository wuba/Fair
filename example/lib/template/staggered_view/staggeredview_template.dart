import 'package:fair/fair.dart';
import 'package:fair_extension/net/fair_net_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

@FairPatch()
class StaggeredItemView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StaggeredItemViewState();
}

class _StaggeredItemViewState extends State<StaggeredItemView> {
  final List<StaggeredViewModel> _listData = <StaggeredViewModel>[
    StaggeredViewModel('https://pic5.58cdn.com.cn/nowater/frs/n_v31ea165ec1cb846ca89a334fde9b78f2d.png',1.5)
  ];
  int _page = 0;

  /// 生命周期回调，函数名不可修改
  void onLoad() {
    requestData();
  }

  /// 生命周期回调，函数名不可修改
  void onUnload() {}

  void requestData() {
    _page++;
    FairNet.requestData(
        method: FairNet.GET,
        url:
            'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/3a0809703d09800b54491c4d1fc710da_staggeredview_data.json',
        data: {'page': _page},
        success: (resp) {
          if (resp == null) {
            return;
          }
          var data = resp['data'];
          data.forEach((item) {
            var dataItem = StaggeredViewModel('',1.5);
            try {
              dataItem.picUrl = item['imagePath'];
              dataItem.ratio = item['ratio'];
            } catch (e) {}
            _listData.add(dataItem);
          });
          setState(() {});
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
          trueValue: () => Center(
            child: Text(
              '加载中...',
            ),
          ),
          falseValue: () => StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              children: Sugar.map(
                _listData,
                builder: (StaggeredViewModel item) {
                  return AspectRatio(
                    aspectRatio: item.ratio,
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
  double ratio = 1.5;

  StaggeredViewModel(this.picUrl, this.ratio);
}
