import 'package:fair/fair.dart';

/// 模拟耗时操作
mixin FuturePlugin implements FairCommonPluginMixin {
  Future<dynamic> futureDelayed(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          int seconds = requestMap['seconds'];
          await Future.delayed(Duration(seconds: seconds));
          return null;
        },
      );
}
