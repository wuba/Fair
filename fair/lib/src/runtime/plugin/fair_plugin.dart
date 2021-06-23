import 'dart:convert';

abstract class IFairPlugin {
  final c = <String, Function>{};

  dynamic invoke(dynamic par);

  String getMethodName(dynamic par) {
    var a = jsonDecode(par);
    var obj = a['args'];
    var name = obj['className']?.toString();

    if (name.contains('#')) {
      var list = name.split('#');
      if (list.length >= 2) {
        return list[1];
      }
    }

    return '';
  }

  void registerMethod(String k, Function f) {
    c[k] = f;
  }
}
