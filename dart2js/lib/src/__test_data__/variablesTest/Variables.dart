import '../../convertorV2.dart';

String a = convertFunction('''
void test() {
    var name = 'Bob';
    
    Object obj = 'Obj';
    
    int? lineCount;
    int  line2 = 0;
    
    late String description;
    description = 'Feijoada!';
    
    final fiName = 'Bob'; // Without a type annotation
    final String nickname = 'Bobby';
    
    const bar = 1000000; // Unit of pressure (dynes/cm2)
    const double atm = 1.01325 * bar; // Standard atmosphere
   
    var foo = const [];
    final bar = const [];
    const baz = []; // Equivalent to `const []`
  
   const Object i = 3; // Where i is a const Object with an int value...
   const list = [i as int]; // Use a typecast.
   // const map = {if (i is int) i: 'int'}; // Use is and collection if.
   // const set = {if (list is List<int>) ...list}; // ...and a spread.
  
    foo = [1, 2, 3]; // Was const []
}
    ''');

void main() {
  print(a);
}