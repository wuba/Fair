import '../../convertorV2.dart';

String a = convertFunction('''
void test() {
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
var names = <String>{};
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);
}
    ''');

void main() {
  print(a);
}