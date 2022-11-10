import '../../convertorV2.dart';

String a = convertFunction('''
void main(){
var callbacks = [];
for (var i = 0; i < 2; i++) {
  callbacks.add(() => print(i));
}

for (final c in callbacks) {
  c();
}
var collection = [1, 2, 3];
collection.forEach(print); // 1 2 3
}
    ''');

void main() {
  print(a);
}