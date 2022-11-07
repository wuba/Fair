
import '../../convertorV2.dart';
String a = convertFunction('''
void test() {
// var s = r'In a raw string, not even \n gets special treatment.';
}
    ''');

void main() {
  print(a);
}