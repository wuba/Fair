import '../../convertorV2.dart';

String a = convertFunction('''

void main() {
void enableFlags({bool? bold, bool? hidden}){}

String say(String from, String msg, [String device = 'carrier pigeon']) {
  var result = '\$from says \$msg with a \$device';
  return result;
}

const list = ['apples', 'bananas', 'oranges'];
list.map((item) {
  return item.toUpperCase();
}).forEach((item) {
  print('\$item: \${item.length}');
});

list.map((item) => item.toUpperCase()).forEach((item) => print('\$item: \${item.length}'));

}


    ''');

void main() {
  print(a);
}