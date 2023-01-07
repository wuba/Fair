import '../../convertorV2.dart';

String a = convertFunction('''
void main(){
let b1 = 2 + 3 == 5;
let b2 = 2 - 3 == -1;
let b3 = 2 * 3 == 6;
let b4 = 5 / 2 == 2.5; // Result is a double
let b5 = 5 ~/ 2 == 2; // Result is an int （todo 不支持 ）
let b6 = 5 % 2 == 1; // Remainder


int a;
int b;

a = 0;
b = ++a; // Increment a before b gets its value.

a = 0;
b = a++; // Increment a AFTER b gets its value.

a = 0;
b = --a; // Decrement a before b gets its value.

a = 0;
b = a--; // Decrement a AFTER b gets its value.



}


    ''');

void main() {
  print(a);
}
