import '../2.dart';
import '../dir3/3.dart';

class One {
  static void foo(String value) {
    Two.bar(value);
    Three.bark(value);
  }
}