import 'dart:convert';

import 'package:fair/fair.dart';

import 'fair_provider_core.dart';

class FairProvider extends IFairPlugin {
  static final FairProvider _fairProvider = FairProvider._internal();

  FairProvider._internal();

  factory FairProvider() {
    return _fairProvider;
  }

  static void notifyListeners({
    required String fairRuntimeTypeKey,
  }) {
    FairProviderPlugin.find<FairChangeNotifier>(fairRuntimeTypeKey).notify();
  }

  static void _notifyListeners(dynamic map) async {
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
    var jsonMap = jsonDecode(args['jsonMap']);
    var fairRuntimeTypeKey = jsonMap['fairRuntimeTypeKey'];
    notifyListeners(fairRuntimeTypeKey: fairRuntimeTypeKey);
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('notifyListeners', () => _notifyListeners);
    return functions;
  }
}
