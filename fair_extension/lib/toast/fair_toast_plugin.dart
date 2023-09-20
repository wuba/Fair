import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FairToast extends IFairPlugin {
  ///定义FlutterToast的一些入参枚举映射
  static const LENGTH_SHORT = 'LENGTH_SHORT';
  static const LENGTH_LONG = 'LENGTH_LONG';
  static const TOP = 'TOP';
  static const BOTTOM = 'BOTTOM';
  static const CENTER = 'CENTER';
  static const TOP_LEFT = 'TOP_LEFT';
  static const TOP_RIGHT = 'TOP_RIGHT';
  static const BOTTOM_LEFT = 'BOTTOM_LEFT';
  static const BOTTOM_RIGHT = 'BOTTOM_RIGHT';
  static const CENTER_LEFT = 'CENTER_LEFT';
  static const CENTER_RIGHT = 'CENTER_RIGHT';
  static const SNACKBAR = 'SNACKBAR';
  static const NONE = 'NONE';

  static final FairToast _fairToast = FairToast._internal();

  FairToast._internal();

  factory FairToast() {
    return _fairToast;
  }

  static void show({
    required String msg,
    Toast? toastLength,
    double? fontSize,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      fontSize: fontSize ?? 16.0,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.black,
      textColor: textColor ?? Colors.white,
    );
  }

  static void _show(dynamic map) async {
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
    var msg = args['msg'];
    var toastLength = args['toastLength'];
    var fontSize = args['fontSize'];
    var gravity = args['gravity'];
    var backgroundColor = args['backgroundColor'];
    var textColor = args['textColor'];
    await Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: _parseFairToastLength(toastLength) ?? Toast.LENGTH_SHORT,
      fontSize: double.tryParse(fontSize.toString()) ?? 16.0,
      gravity: _parseFairToastGravity(gravity) ?? ToastGravity.BOTTOM,
      backgroundColor: backgroundColor != null
          ? Color(int.parse(backgroundColor.toString()))
          : Colors.black,
      textColor: textColor != null
          ? Color(int.parse(textColor.toString()))
          : Colors.white,
    );
  }

  static Toast? _parseFairToastLength(String? fairToastLength) {
    switch (fairToastLength) {
      case LENGTH_SHORT:
        return Toast.LENGTH_SHORT;
      case LENGTH_LONG:
        return Toast.LENGTH_LONG;
    }
    return null;
  }

  static ToastGravity? _parseFairToastGravity(String? fairToastGravity) {
    switch (fairToastGravity) {
      case TOP:
        return ToastGravity.TOP;
      case BOTTOM:
        return ToastGravity.BOTTOM;
      case CENTER:
        return ToastGravity.CENTER;
      case TOP_LEFT:
        return ToastGravity.TOP_LEFT;
      case TOP_RIGHT:
        return ToastGravity.TOP_RIGHT;
      case BOTTOM_LEFT:
        return ToastGravity.BOTTOM_LEFT;
      case BOTTOM_RIGHT:
        return ToastGravity.BOTTOM_RIGHT;
      case CENTER_LEFT:
        return ToastGravity.CENTER_LEFT;
      case CENTER_RIGHT:
        return ToastGravity.CENTER_RIGHT;
      case SNACKBAR:
        return ToastGravity.SNACKBAR;
      default:
        ToastGravity.NONE;
    }
    return null;
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('show', () => _show);
    return functions;
  }
}
