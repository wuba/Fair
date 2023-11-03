import 'dart:ui';

import 'package:best_flutter_ui_templates/model/homelist.dart';
import 'package:fair/fair.dart';
import 'package:flutter/widgets.dart';

class HomeListProxy extends FairDelegate {
  HomeListProxy({
    this.listData,
    this.callBack,
  });

  final HomeList? listData;
  final VoidCallback? callBack;

  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['imagePath'] = () => listData?.imagePath;
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['callBack'] = callBack!;
    return fun;
  }
}
