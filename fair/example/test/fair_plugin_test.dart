import 'package:fair/fair.dart';
import 'package:test/test.dart';

Future<void> main() async {
  test('测试 fair-permission', () {
    FairPlugin.call({
      'className': 'className',
      'method': 'invokePlugin',
      'complete': (resp) {
        print('complete: $resp');
      },
      'error': (resp) {
        print('error: $resp');
      }
    });
  });
}
