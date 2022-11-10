import '../../convertorV2.dart';

String a = convertFunction('''
void main(){
var paint = Paint()..color = Colors.black
  ..strokeCap = StrokeCap.round
  ..strokeWidth = 5.0;
  
 
}
    ''');

// 语法不支持报错
String b = convertFunction('''
void main(){
  querySelector('#confirm')?..text = 'Confirm' 
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'))
  ..scrollIntoView();
}
    ''');

void main() {
  print(a);
  print("-----------------------");
  print(b);
}