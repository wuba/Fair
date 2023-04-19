import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:fair_extension/fair_extension.dart';
import 'package:flutter/material.dart';

NavigatorState? get navigator => FairExtension.fairNavigatorKey.currentState;

class FairNavigator extends IFairPlugin {
  static final FairNavigator _fairToast = FairNavigator._internal();

  FairNavigator._internal();

  factory FairNavigator() {
    return _fairToast;
  }

  static void pushNamed({required String routeName, Object? arguments}) {
    navigator?.pushNamed(routeName, arguments: arguments);
  }

  static void pushFairPath(
      {required String fairPath, required String fairName, Object? arguments}) {
    navigator?.push(MaterialPageRoute(builder: (context) {
      return FairWidget(
          path: fairPath,
          name: fairName,
          data: {'fairProps': jsonEncode(arguments ?? {})});
    }));
  }

  static void pop() {
    navigator?.pop();
  }

  static void _pushNamed(dynamic map) async {
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
    var routeName = args['routeName'];
    var arguments = args['arguments'];
    await navigator?.pushNamed(routeName, arguments: arguments);
  }

  static void _pushFairPath(dynamic map) async {
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
    var fairPath = args['fairPath'];
    var fairName = args['fairName'];
    var arguments = args['arguments'];
    await navigator?.push(MaterialPageRoute(builder: (context) {
      return FairWidget(
          path: fairPath,
          name: fairName,
          data: {'fairProps': jsonEncode(arguments ?? {})});
    }));
  }

  static void _pop(dynamic map) async {
    if (map == null) {
      return;
    }
    var req;
    if (map is Map) {
      req = map;
    } else {
      req = jsonDecode(map);
    }
    navigator?.pop();
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('pushNamed', () => _pushNamed);
    functions.putIfAbsent('pushFairPath', () => _pushFairPath);
    functions.putIfAbsent('pop', () => _pop);
    return functions;
  }
}
