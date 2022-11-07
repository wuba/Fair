import '../../convertorV2.dart';

String a = convertClassString('''

class Point {
  int count = 0;

  void inCreate(int num) {
    count += num;
  }

  bool isNice() {
    return count > 10;
  }
}
    ''');

void main() {
  print(a);
}
