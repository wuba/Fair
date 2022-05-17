import 'package:fair/fair.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class MyHomePageDelegate extends FairDelegate {

  void _incrementCounter() {
    context.read<Counter>().increment();
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_incrementCounter'] = _incrementCounter;
    return fun;
  }
}
