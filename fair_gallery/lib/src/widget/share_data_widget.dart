import 'package:flutter/material.dart';

class ShareDataWidget extends StatelessWidget {
  const ShareDataWidget({
    super.key,
    required this.child,
    required this.data,
    this.index,
  });

  final dynamic data;
  final int? index;
  final Widget child;

  /// get data
  static dynamic of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<ShareDataWidget>()?.data;
  }

  static int? getIndex(BuildContext context) {
    return context.findAncestorWidgetOfExactType<ShareDataWidget>()?.index;
  }

  static dynamic getValue(BuildContext context, List<dynamic> keys,
      {dynamic defaultValue}) {
    var data = context.findAncestorWidgetOfExactType<ShareDataWidget>()?.data;
    if (data != null) {
      for (var key in keys) {
        if (data != null && data[key] != null) {
          data = data[key];
        }
      }
    }
    return data ?? defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
