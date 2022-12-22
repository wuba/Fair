import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/drag_resize/drag_resize_widget.dart';
import 'package:fair_online/editor/editing/editor.dart';
import 'package:fair_online/models/fair_dsl_model.dart';
import 'package:fair_online/views/fair_dsl_editor/console_panel.dart';
import 'package:fair_online/views/fair_dsl_editor/fair_dsl_code_editor_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FairDslCodeEditor extends StatefulWidget {
  @override
  State<FairDslCodeEditor> createState() => FairDslCodeEditorState();
}

class FairDslCodeEditorState extends State<FairDslCodeEditor> {
  static const String javascriptEditorViewType = 'javascript-editor';
  static const String jsonEditorViewType = 'json-editor';
  static const String fairDslPreviewViewType = 'fair-dsl-preview';

  late Editor javascriptEditor;
  late Editor jsonEditor;

  @override
  void initState() {
    super.initState();
    final fairDslModel = context.read<FairDslModel>();
    javascriptEditor =
        fairDslModel.initJavascriptEditor(javascriptEditorViewType);
    jsonEditor = fairDslModel.initJsonEditor(jsonEditorViewType);
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    bool isShow =
        context.select<FairDslModel, bool>((value) => value.isConsolePanelShow);
    return DragResizeWidget(
      dragHideMode: isShow ? null : DragHideMode.second,
      dragWidgetSize: 6,
      dragWidgetColor: theme.divider,
      axis: Axis.vertical,
      firstChildBuilder: DragResizeChildBuilder(
          weight: 3,
          minSize: 100,
          builder: (context, width, height) {
            jsonEditor.setSize(width, height);
            javascriptEditor.setSize(width, height);
            return FairDslCodeEditorView(this);
          }),
      secondChildBuilder: DragResizeChildBuilder(
          weight: 1,
          minSize: 36,
          builder: (context, width, height) {
            return Container(
              color: theme.bg3,
              child: ConsolePanel(),
            );
          }),
    );
  }
}
