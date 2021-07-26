part of 'net_demo_pic.dart';

void request() {
  FairNet().request({
    'method': 'GET',
    'url': 'http://www.baidu.com',
  });
}

class PicData extends Object {
  String picUrl =
      'https://www.youxinpai.com/public/home/widget/services/4s/img/img_4s_4_0943ac1.jpg';
  String title = '';
  String content = '';
}

PicData _picData = PicData();

void onClick() {
  FairNet().request({
    'pageName': '#FairKey#',
    'method': 'GET',
    'url': 'https://www.wanandroid.com/banner/json',
    'success': (resp) {
      if (resp == null) {
        return;
      }
      List data = resp['data'];
      String u = data[0]['imagePath'];
      _picData.picUrl = u;
      _picData.title = data[0]['title'];
      // setState(
      //   '#FairKey#',
      //   {
      //     _picData.title: data[0]['title'],
      //     _picData.picUrl: u,
      //   },
      // );
    }
  });
}
