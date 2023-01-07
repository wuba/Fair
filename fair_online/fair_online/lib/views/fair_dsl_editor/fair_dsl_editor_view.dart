import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/drag_resize/drag_resize_widget.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/views/fair_dsl_editor/fair_dsl_code_editor.dart';
import 'package:fair_online/views/fair_dsl_editor/fair_dsl_dashboard.dart';
import 'package:flutter/material.dart';

import 'fair_dsl_editor.dart';
import 'fair_dsl_preview.dart';

class FairDslEditorView extends WidgetView<FairDslEditor, FairDslEditorState> {
  FairDslEditorView(FairDslEditorState state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);

    return Container(
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          ///预览
          Container(
            width: 400,
            child: FairDslPreview(),
          ),
          Container(
            width: 8,
            color: theme.divider,
          ),
          Flexible(
            child: DragResizeWidget(
              dragWidgetSize: 8,
              dragWidgetColor: theme.divider,
              axis: Axis.horizontal,

              /// 控制面板
              firstChildBuilder: DragResizeChildBuilder(
                  weight: 1,
                  minSize: 300,
                  builder: (context, width, height) {
                    return Center(
                      child: FairDslDashboard(),
                    );
                  }),

              /// DSL预览
              secondChildBuilder: DragResizeChildBuilder(
                  weight: 2,
                  minSize: 400,
                  builder: (context, width, height) {
                    return FairDslCodeEditor();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
