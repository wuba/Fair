import 'package:fair/fair.dart';
import 'package:fair_extension/net/fair_net_plugin.dart';
import 'package:flutter/material.dart';

@FairPatch()
class NetworkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  final List<ItemData> _listData = <ItemData>[];
  int _page = 0;

  /// 生命周期回调，函数名不可修改
  void onLoad() {
    requestDataFromNet();
  }

  /// 生命周期回调，函数名不可修改
  void onUnload() {}

  void requestDataFromNet() {
    _page++;
    FairNet.requestData(
        method: FairNet.GET,
        url:
            'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/6f8e5d9e196cbaa4a46041928770b187_grid_data.json',
        data: {'page': _page},
        success: (resp) {
          if (resp == null) {
            return;
          }
          var data = resp['data'];
          data.forEach((item) {
            var dataItem = ItemData();
            dataItem.picUrl = item['imagePath'];
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
          title: const Text('Network Example'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: requestDataFromNet,
          child: const Icon(Icons.add),
        ),
        body: Sugar.ifEqualBool(isDataEmpty(),
            trueValue: () => const Center(
                  child: Text(
                    '加载中...',
                  ),
                ),
            falseValue: () => GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: Sugar.mapEach(_listData, (index, item) {
                    return AspectRatio(
                      aspectRatio: 1.5,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        child: Image.network(item.picUrl, fit: BoxFit.cover),
                      ),
                    );
                  }),
                )));
  }
}

class ItemData extends Object {
  String picUrl = '';
}
