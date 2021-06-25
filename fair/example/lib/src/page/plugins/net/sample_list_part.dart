part of 'sampe_list_view_src.dart';

void requestNet() {
  var map = {
    'className': 'hello_world',
    'method': 'GET',
    'url': 'https://www.baidu.com',
    'complete': (params) {
      // console.log('测试成功回调' + params)
    },
    'error': (params) {
      // console.log('测试失败回调' + params)
    }
  };

  FairNet().request(jsonEncode(map));
}
