import '../../convertorV2.dart';

String a = convertFunction('''
bool fun1(int p1) {
  return _nobleGases[p1] != null;
}


    ''');

void main() {
  print(a);
}