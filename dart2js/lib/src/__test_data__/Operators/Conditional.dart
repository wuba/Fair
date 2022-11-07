import '../../convertorV2.dart';

// as 关键字 被舍弃
String a = convertFunction('''
void main(){
var visibility = isPublic ? 'public' : 'private';
var x= name ?? 'Guest';
String playerName(String? name) => name ?? 'Guest';
}
    ''');

void main() {
  print(a);
}