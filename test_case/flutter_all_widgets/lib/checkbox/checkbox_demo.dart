import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class CheckboxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckBox"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlutterCheckboxPage(),
          FairWidget(
              path:
                  'assets/bundle/checkbox/lib_checkbox_checkbox_widget.fair.json',
              data: {'fairProps': jsonEncode({})})
        ],
      ),
    );
  }
}

class FlutterCheckboxPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlutterCheckboxState();
}

class _FlutterCheckboxState extends State<FlutterCheckboxPage> {
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    return Colors.red;
  }

  bool _getChecked(){
    return isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: _getChecked(),
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        onChanged: (value) {
          setState(() {
            isChecked = value;
          });
        });
  }
}
