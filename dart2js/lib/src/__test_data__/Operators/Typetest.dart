

import '../../convertorV2.dart';

// as 关键字 被舍弃
String a = convertFunction('''
void main(){
(employee as Person).firstName = 'Bob';
}
    ''');

void main() {
print(a);
}