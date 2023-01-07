import '../../convertorV2.dart';

String a = convertClassString('''

class Point {
  double x = 0;
  double y = 0;
  Point(double x, double y) {
    this.x = x;
    this.y = y;
  }
}
    ''');

void main() {
  print(a);
}

