import 'package:dio/dio.dart';
import 'package:fair_example/src/page/plugins/fair_common_plugin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('测试 fair-net插件', () {
    FairCommonPlugin().http({
      'method': 'GET',
      'url': 'https://www.baidu.com',
      'callback': (resp) {
        print('返回结果:$resp');
      },
    });
  });
}
