import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/editor/component/editor_panel_widget.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/component/preview_widget.dart';
import 'package:fair_online/utils/color_utils.dart';
import 'package:fair_online/views/custom_code_page/dialog/code_compile_dialog.dart';
import 'package:flutter/material.dart';

class CodeCompileDialogWidget
    extends WidgetView<CodeCompileDialogWidget, CodeCompileDialogState> {
  CodeCompileDialogWidget(state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    FlutterEditorController controller = state.getEditController();
    return LayoutBuilder(builder: (context, dimens) {
      double maxWidth = dimens.maxWidth * 0.8;
      double maxHeight = dimens.maxHeight * 0.8;
      return NonScrollStyledDialog(
        shrinkWrap: false,
        bgColor: theme.bg2,
        padding: EdgeInsets.all(0),
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        useBlur: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TransparentBtn(
                      borderRadius: 20,
                      contentPadding: EdgeInsets.all(10),
                      bgColor: ColorUtils.shiftHsl(theme.surface, .1),
                      hoverColor: ColorUtils.shiftHsl(theme.surface, .1),
                      downColor: ColorUtils.shiftHsl(theme.surface, .2),
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close_rounded,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 10,
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          color: theme.bg3,
                          child: EditorPanel(controller: controller),
                        ),
                      ),
                      Container(
                        width: 10,
                        color: theme.divider,
                      ),
                      Flexible(
                        flex: 1,
                        child: ValueListenableBuilder<bool>(
                          builder: (context, value, child) {
                            return Stack(
                              children: [
                                if (value)
                                  Center(child: CircularProgressIndicator())
                                else
                                  Center(
                                    child: Text('初始化预览环境中，请稍等...'),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: Container(
                                    child: Preview(controller: controller),
                                  ),
                                ),
                              ],
                            );
                          },
                          valueListenable: controller.isRunningNotifier,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
