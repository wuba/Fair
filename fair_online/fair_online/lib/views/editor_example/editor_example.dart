import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/views/editor_example/example.dart';
import 'package:fair_online/views/editor_example/example2.dart';
import 'package:fair_online/views/editor_example/example1.dart';
import 'package:fair_online/views/editor_example/editor_dialog.dart';
import 'package:flutter/material.dart';

class EditorExample extends StatefulWidget {
  @override
  State<EditorExample> createState() => _EditorExampleState();
}

class _EditorExampleState extends State<EditorExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: 500,
          child: Column(
            children: [
              MaterialButton(
                minWidth: 100,
                height: 50,
                child: Text("example"),
                color: Colors.green,
                onPressed: () {
                  Dialogs.show(EditorDialog(Example()));
                },
              ),
              SizedBox(
                height: 100,
              ),
              MaterialButton(
                minWidth: 100,
                height: 50,
                child: Text("example1"),
                color: Colors.blue,
                onPressed: () {
                  Dialogs.show(EditorDialog(Example1()));
                },
              ),
              SizedBox(
                height: 100,
              ),
              MaterialButton(
                minWidth: 100,
                height: 50,
                color: Colors.red,
                child: Text("example2"),
                onPressed: () {
                  Dialogs.show(EditorDialog(Example2()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
