import '../../convertorV2.dart';

String a = convertFunction('''
bool topLevel = true;

void main() {
  var insideMain = true;

  void myFunction() {
    var insideFunction = true;

    void fun1() {
      var insideNestedFunction = true;
    }
    void fun2() {
      var insideNestedFunction2 = true;
    }
    Function makeAdder(int addBy) {
      return (int i) => addBy + i;
    }
  }
}
    ''');

void main() {
  print(a);
}
