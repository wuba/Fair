import '../../convertorV2.dart';

String a = convertFunction('''
void test() {
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};
}
    ''');

void main() {
  print(a);
}