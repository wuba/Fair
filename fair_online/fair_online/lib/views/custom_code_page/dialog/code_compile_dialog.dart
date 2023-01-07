
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/views/custom_code_page/dialog/code_compile_dialog_widget.dart';
import 'package:flutter/cupertino.dart';

class CodeCompileDialog extends StatefulWidget {

  FlutterEditorController controller;
  CodeCompileDialog({required this.controller});

  @override
  State<StatefulWidget> createState() {
    return CodeCompileDialogState();
  }

}

class CodeCompileDialogState extends State<CodeCompileDialog> {

  @override
  void initState() {
    super.initState();
    widget.controller.handleRun();
  }

  @override
  Widget build(BuildContext context) {
    return CodeCompileDialogWidget(this);
  }

  FlutterEditorController getEditController() {
    return widget.controller;
  }

}