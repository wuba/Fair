import 'dart:convert';

import 'package:fair/fair.dart';

class FairLog extends IFairPlugin {
  static final FairLog _fairLog = FairLog._internal();

  FairLog._internal();

  factory FairLog() {
    return _fairLog;
  }

  static void log(Object? object) {
    print('FairLog >>> $object');
  }

  static void _log(dynamic map) async {
    if (map == null) {
      return;
    }
    var req;
    if (map is Map) {
      req = map;
    } else {
      req = jsonDecode(map);
    }
    var args = req['args'];
    log(args);
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('log', () => _log);
    return functions;
  }
}
