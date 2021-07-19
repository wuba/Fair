part of 'sampe_list_view_src.dart';

typedef RespCallback = void Function();

var resultMap = [];

void requestNet(RespCallback respCallback) {
  FairPlugin.call({
    'className': 'FairNet#request',
    'method': 'GET',
    'url': 'https://wanandroid.com/user_article/list/0/json',
    'complete': (resp) {
      print('FairPlugin.complete$resp');
      Map respMap;
      try {
        respMap = jsonDecode(resp);
        List m = jsonDecode(respMap['data'])['data']['datas'];
        resultMap.clear();

        for (var element in m) {
          resultMap.add(element);
        }
      } on Exception catch (e) {
        print('e$e');
      }

      respCallback();
    },
    'error': (resp) {
      print('FairPlugin.call.error: $resp');
    }
  });
}

Widget getItem(var id) {
  List goodsList = <GoodsDesc>[];
  goodsList.add(
      GoodsDesc(boldText: '${resultMap[id]['title']}-> $id', normalText: ''));
  goodsList.add(GoodsDesc(boldText: '', normalText: '上海浦东新区陆家嘴'));
  goodsList.add(GoodsDesc(boldText: '90000', normalText: '万'));
  var louPanDetail = LouPanDetail(
      id: 1,
      number: 100 * 20,
      type: 0,
      goodsId: 111,
      imgUrl:
          'http://pic1.ajkimg.com/display/anjuke/d6e675-%E5%8E%A6%E9%97%A8%E6%B5%8B%E8%AF%95%E5%85%AC%E5%8F%B8/3ed05d79ec1de21e4fbbaf146573985a-800x570.jpg',
      goodsDesc: goodsList);

  // 动态化效果
  return Center(
    child: Container(
        height: 250,
        alignment: Alignment.centerLeft,
        color: Colors.white,
        constraints: BoxConstraints(minHeight: 80),
        child: FairWidget(
          name: 'fairPage$id',
          path:
              'assets/bundle/lib_src_page_sample_page_stateful_cell.fair.json',
          data: {'fairProps': json.encode(louPanDetail)},
        )),
  );
}
