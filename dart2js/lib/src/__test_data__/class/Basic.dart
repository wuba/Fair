import '../../convertorV2.dart';

String a = convertClassString('''

class Point {
  double x = 0;
  double y = 0;
}
    ''');

void main() {
  print(a);
}

