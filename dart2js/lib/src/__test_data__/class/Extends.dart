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

class Child extends Point {
   Child(double x, double y) : super(x, y) {
    var m = 3;
  }
}
    ''');

void main() {
  print(a);
}
