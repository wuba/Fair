import '../../convertorV2.dart';

String a = convertFunction('''
void test() {
   var list = [1, 2, 3];
   var list2 = [
  'Car',
  'Boat',
  'Plane',
];

var list3 = [1, 2, 3];
var list4 = [0, ...list3];

var list2 = [0, ...?list];

var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];

var listOfStrings = ['#0', for (var i in listOfInts) '#\$i'];// 不支持
}
    ''');

void main() {
  print(a);
}