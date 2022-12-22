import 'package:flutter/cupertino.dart';

class SimpleNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}

class SimpleValueNotifier<T> extends ValueNotifier<T> {
  SimpleValueNotifier(T value) : super(value);

  void notify() => notifyListeners();
}

class SomeProps with ChangeNotifier {
  bool value1 = false;

  void setV1(bool v) {
    value1 = v;
    notifyListeners();
  }
}
