import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/drag_resize/drag_resize_widget.dart';
import 'package:fair_online/editor/component/editor_panel_widget.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/component/flutter_editor_widget.dart';
import 'package:fair_online/models/dart_editor_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CodeEditor extends StatelessWidget {

  FlutterEditorController controller;

  CodeEditor(this.controller);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    bool isShow = context
        .select<DartEditorModel, bool>((value) => value.isEditorPanelShow);
    return DragResizeWidget(
      dragHideMode: isShow ? null : DragHideMode.second,
      dragWidgetSize: 6,
      dragWidgetColor: theme.divider,
      axis: Axis.vertical,
      firstChildBuilder: DragResizeChildBuilder(
          weight: 3,
          minSize: 100,
          builder: (context, width, height) {
            ///代码编辑器
            return FlutterEditor(controller: controller);
          }),
      secondChildBuilder: DragResizeChildBuilder(
          weight: 1,
          minSize: 36,
          builder: (context, width, height) {
            return Container(
              color: theme.bg3,

              ///面板
              child: EditorPanel(
                  controller: controller,
                  onArrowPressed: () {
                    DartEditorModel model = context.read();
                    model.isEditorPanelShow = !model.isEditorPanelShow;
                  },
                  isExpand: isShow,
                  isExpandEnabled: true),
            );
          }),
    );
  }
}