import '../dir3/3.dart';
import '../2.dart' as c;

class One {
  static void foo(String value) {
    c.Two.bar(value);
    Three.bark(value);
  }
}