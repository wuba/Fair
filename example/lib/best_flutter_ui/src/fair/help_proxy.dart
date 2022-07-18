import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class HelpProxy extends FairDelegate {
  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['color'] = () => Colors.grey.withOpacity(0.6);
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['onTapButton'] = onTapButton;
    return fun;
  }

  void onTapButton() {}
}
