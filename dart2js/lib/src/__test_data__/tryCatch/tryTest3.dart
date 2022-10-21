import 'package:fair_dart2js/src/covert/convertFunction.dart';

/**
 * 测试 finally 处理
 * */

String a = convertFunction('''
void testTry() {
  try {
    int a=1;
  } catch (e,s) {
    print('catch：'+e);
  } finally{
    print('finally...');
  }
}
    ''');

void main() {
  print(a);
}
