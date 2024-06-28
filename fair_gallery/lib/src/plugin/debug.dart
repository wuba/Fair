import 'package:fair/fair.dart';
import 'package:flutter/foundation.dart';

mixin DebugPlugin implements FairCommonPluginMixin {
  Future<dynamic> jsPrint(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          if (kDebugMode) {
            debugPrint('来自js的参数:$requestMap');
          }
          return null;
        },
      );
}
