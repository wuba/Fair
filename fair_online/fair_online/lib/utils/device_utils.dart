import 'dart:js' as js;

import 'package:fair_online/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';

class DeviceUtils {
  static late String _fingerId;

  static void requestFingerId(VoidCallback callback) {
    SPUtil.initialized().then((prefs) {
      String? storageFingerId = SPUtil.getString("finger_id");
      if (storageFingerId == null) {
        js.context["onFingerIdOk"] = (String id) {
          // Future.delayed(Duration(milliseconds: 1000)).then((value) {
          SPUtil.setString("finger_id", id);
          _fingerId = id;
          callback.call();
          // });
        };
        js.context.callMethod("requestFingerId");
      } else {
        _fingerId = storageFingerId;
        callback.call();
      }
    });
  }

  static String getFingerId() => _fingerId;
}
