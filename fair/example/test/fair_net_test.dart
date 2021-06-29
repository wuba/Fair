import 'package:dio/dio.dart';
import 'package:fair_example/src/page/plugins/net/fair_plugin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('测试 fair-net插件', () {
    FairNet().request({
      'method': 'GET',
      'baseOptions': BaseOptions(method: 'GET'),
      'header': {},
      'url': 'https://www.baidu.com',
      'complete': (resp) {
        print('返回结果:$resp');
      },
      'error': (resp) {
        print('返回结果:$resp');
      }
    });
  });
}
