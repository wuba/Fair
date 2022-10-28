import 'package:fair_dart2js/src/covert/convertFunction.dart';

/**
 * 测试 on 函数将被丢弃
 * */

String a = convertFunction('''
void testTry() {
  try {
    int a=1;
    int b=2;
    int c=a+b;
    print("1");
    throw FormatException('Expected at least 1 section');
  } on Exception catch (e,s) {
    print('111'+e);
  } catch (e) {
    print('222'+e);
  }
}
    ''');

void main() {
  print(a);
}
