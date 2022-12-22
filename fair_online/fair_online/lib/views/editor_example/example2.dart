import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/drag_resize/drag_resize_widget.dart';
import 'package:fair_online/editor/component/analyze_widget.dart';
import 'package:fair_online/editor/component/editor_panel_widget.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/component/flutter_editor_widget.dart';
import 'package:fair_online/editor/component/preview_widget.dart';
import 'package:fair_online/models/editor_example_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Example2 extends StatefulWidget {
  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  late FlutterEditorController controller;

  @override
  void initState() {
    super.initState();
    controller = FlutterEditorController(key: "example2");
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    final isShow = context
        .select<EditorExampleModel, bool>((value) => value.isEditorPanelShow);
    return LayoutBuilder(builder: (context, dimens) {
      return Row(
        children: [
          ///左边 代码编辑器+面板
          Container(
            width: dimens.maxWidth * 2 / 5,
            height: dimens.maxHeight,
            child: DragResizeWidget(
              dragHideMode: isShow ? null : DragHideMode.second,
              dragWidgetSize: 6,
              dragWidgetColor: theme.bg2,
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
                            EditorExampleModel model = context.read();
                            model.isEditorPanelShow = !model.isEditorPanelShow;
                          },
                          isExpand: isShow,
                          isExpandEnabled: true),
                    );
                  }),
            ),
          ),
          Builder(builder: (context) {
            final rightWidth = dimens.maxWidth * 3 / 5;
            return Container(
              width: rightWidth,
              height: dimens.maxHeight,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      color: Colors.white70,
                      width: rightWidth / 2,
                      height: 500,

                      ///预览
                      child: Preview(
                        controller: controller,
                      ),
                    ),
                  ),

                  ///run按钮
                  ValueListenableBuilder<bool>(
                      valueListenable: controller.isRunningNotifier,
                      builder: (context, value, child) {
                        return ElevatedButton.icon(
                            icon: value
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          theme.accent1Darker),
                                      backgroundColor: theme.grey,
                                      strokeWidth: 3.0,
                                    ),
                                  )
                                : Icon(
                                    Icons.play_arrow,
                                    size: 20,
                                  ),
                            label: Text('Run'),
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(100, 50)),
                              backgroundColor: MaterialStateProperty.all(
                                  value ? theme.bg2 : theme.accent1),
                            ),
                            onPressed: () {
                              controller.handleRun();
                            });
                      }),

                  ///analyze视图
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          width: 420,
                          height: 400,
                          child: Analyze(controller: controller)))
                ],
              ),
            );
          })
        ],
      );
    });
  }
}
