import 'package:fair/fair.dart';
import 'package:oktoast/oktoast.dart' as oktoast;

mixin ToastPlugin implements FairCommonPluginMixin {
  Future<dynamic> showToast(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          final msg = requestMap['msg'];
          oktoast.showToast(msg);
          return null;
        },
      );
}
