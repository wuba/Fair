import '../../convertorV2.dart';

String a = convertFunction('''
void main(){
if (isRaining()) {
  you.bringRainCoat();
} else if (isSnowing()) {
  you.wearJacket();
} else {
  car.putTopDown();
}
}
    ''');

void main() {
  print(a);
}