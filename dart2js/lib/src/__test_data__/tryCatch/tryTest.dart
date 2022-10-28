import 'package:fair_dart2js/src/covert/convertFunction.dart';
/**
 *  正常测试 try catch
 * */

String a = convertFunction('''
void testTry() {
  try {
    int a=1;
    int b=2;
    int c=a+b;
    print("1");
    throw FormatException('Expected at least 1 section');
  } catch (e,s) {
    print('111'+e);
  }
}
    ''');

void main() {
  print(a);
}
