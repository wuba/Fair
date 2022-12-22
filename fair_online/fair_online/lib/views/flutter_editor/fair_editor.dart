import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/drag_resize/drag_resize_widget.dart';
import 'package:fair_online/base/components/fading_index_stack.dart';
import 'package:fair_online/editor/component/analyze_widget.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/models/app_model.dart';
import 'package:fair_online/models/dart_editor_model.dart';
import 'package:fair_online/views/fair_dsl_editor/fair_dsl_editor.dart';
import 'package:fair_online/views/flutter_editor/bottom_panel.dart';
import 'package:fair_online/views/flutter_editor/code_editor.dart';
import 'package:fair_online/views/flutter_editor/flutter_preview.dart';
import 'package:fair_online/views/page/page_main_page.dart';
import 'package:fair_online/views/use_code/use_code_list_page.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

///Flutter代码编辑器和FairDsl预览编辑器
class FairEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentFlutterEditorPage = context.select<AppModel, FlutterEditorPage>(
        (value) => value.currentFlutterEditorPage);
    return FadingIndexedStack(
      index: currentFlutterEditorPage == FlutterEditorPage.Flutter ? 0 : 1,
      children: [
        _FlutterEditor(),
        FairDslEditor(),
      ],
    );
  }
}

class _FlutterEditor extends StatefulWidget {
  @override
  _FlutterEditorState createState() => _FlutterEditorState();
}

class _FlutterEditorState extends State<_FlutterEditor> {
  late FlutterEditorController controller;

  _FlutterEditorState();

  @override
  void initState() {
    super.initState();
    controller = FlutterEditorController(key: "fair_editor");
    controller.runMode = RunMode.project;
    controller.sourceType = SourceType.filePath;
    context.read<DartEditorModel>()
      ..setLoadPageListener((pagePath) {
        controller.loadPage(pagePath);
      })
      ..setOnEditorResumeListener(() {
        controller.requestFocus();
      });
  }

  @override
  Widget build(BuildContext context) {
    double previewWidth = 400;
    AppTheme theme = context.watch();
    return LayoutBuilder(
      builder: (context, dimens) {
        final bottomPanelHeight = 30.0;
        final editorHeight = dimens.maxHeight - bottomPanelHeight;
        return Stack(
          children: [
            ///编辑界面
            Container(
              height: editorHeight,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  ///预览
                  Container(
                      width: previewWidth, child: FlutterPreview(controller)),
                  Container(
                    width: 8,
                    color: theme.divider,
                  ),
                  Flexible(
                    child: DragResizeWidget(
                      dragWidgetSize: 8,
                      dragWidgetColor: theme.divider,
                      axis: Axis.horizontal,

                      ///控制面板
                      firstChildBuilder: DragResizeChildBuilder(
                          weight: 1,
                          minSize: 300,
                          builder: (context, width, height) {
                            return Center(
                              child: Selector<AppModel, FlutterEditorLeftPanel>(
                                selector: (context, model) =>
                                    model.currentFlutterEditorLeftPanel,
                                builder: (context, value, child) {
                                  final index =
                                      value == FlutterEditorLeftPanel.Page
                                          ? 0
                                          : 1;
                                  return FadingIndexedStack(
                                    index: index,
                                    children: [
                                      ///页面面板
                                      PageMainPage(),
                                      UseCodeListPage(controller)
                                    ],
                                  );
                                },
                              ),
                            );
                          }),

                      ///代码编辑
                      secondChildBuilder: DragResizeChildBuilder(
                          weight: 2,
                          minSize: 0,
                          builder: (context, width, height) {
                            return CodeEditor(controller);
                          }),
                    ),
                  ),
                ],
              ),
            ),

            ///底部面板
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomPanel(
                  controller: controller, height: bottomPanelHeight),
            ),

            ///代码语法分析弹窗
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPanelHeight),
                child: PointerInterceptor(
                  child: Selector<DartEditorModel, bool>(
                      selector: (context, model) => model.showAnalyzeDialog,
                      builder: (context, showAnalyzeDialog, child) {
                        return Analyze(
                          controller: controller,
                          isShow: showAnalyzeDialog,
                        );
                      }),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
