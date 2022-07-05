
import 'package:flutter/widgets.dart';

class WidgetItem{


  String title;
  Widget className;

  @override
  String toString() {
    return 'WidgetItem{title: $title, className: $className}';
  }

  WidgetItem(this.title, this.className);
}