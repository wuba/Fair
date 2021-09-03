import '../2.dart' as b;
class Three {
  static void bark(String value) {
    print(value);
    b.Two.bar(value);
  }
}