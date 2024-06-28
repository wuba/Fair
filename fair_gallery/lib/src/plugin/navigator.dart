import 'package:fair/fair.dart';
import 'package:fair_gallery/main.dart';
import 'package:flutter/material.dart';

mixin NavigatorPlugin implements FairCommonPluginMixin {
  /// method
  /// modeName
  /// parameter
  Future<dynamic> navigate(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          final method = requestMap['method'];
          final arguments = requestMap['arguments'];
          final routeName = requestMap['routeName'];
          final result = requestMap['result'];
          final route = requestMap['route'];

          NavigatorState navigatorState = MyApp.navigatorKey.currentState!;
          switch (method) {
            case 'pushNamed':
              return await navigatorState.pushNamed<dynamic>(
                routeName,
                arguments: arguments,
              );
            case 'pushReplacementNamed':
              return await navigatorState
                  .pushReplacementNamed<dynamic, dynamic>(
                routeName,
                arguments: arguments,
                result: result,
              );
            case 'pop':
              navigatorState.pop<dynamic>(result);
              break;
            case 'popUntil':
              navigatorState.popUntil(((page) {
                return page.settings.name == route;
              }));
              break;
            default:
          }
          return null;
        },
      );
}
