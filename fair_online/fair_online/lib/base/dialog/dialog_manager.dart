
import 'package:fair_online/editor/context.dart';
import 'package:flutter/material.dart';

class DialogManager {

  DialogManager._internal();

  factory DialogManager() => _instance;

  static late final DialogManager _instance = DialogManager._internal();

  List<String> dialogs = [];

  showCustomDialog(BuildContext context, String name, Widget widget) {
    if(dialogs.contains(name)) {
      return;
    }
    dialogs.add(name);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return widget;
    });
  }

  dismissDialog(BuildContext context, String name) {
    if(dialogs.contains(name)) {
      Navigator.of(context).pop();
      dialogs.remove(name);
    }
  }
}