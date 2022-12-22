import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/views/page/widget/popup_window.dart';
import 'package:fair_online/views/use_code/use_code_list_page.dart';
import 'package:flutter/material.dart';

class UseComponentItemView extends StatelessWidget {
  CustomComponentInfo customCodeInfo;
  UseCodeListPageState state;
  int length;
  int index;

  UseComponentItemView(
      this.customCodeInfo, this.state, this.length, this.index);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimens) {
      double maxWidth = dimens.maxWidth;
      AppTheme theme = AppTheme.of(context);
      TextStyle titleText = TextStyles.T1.textColor(theme.txt);
      return Container(
        width: maxWidth,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            customCodeInfo.screenshot.isEmpty
                ? GestureDetector(
                    onTap: () {
                      _showScreenshotNotFoundTipDialog(context);
                    },
                    child: Container(
                      width: 80,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Image.asset(
                        "assets/images/ic_image_load_failed.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      _showScreenshotPreviewWindow(context, theme, index,
                          length, customCodeInfo.screenshot);
                    },
                    child: Container(
                      width: 80,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Image.network(
                        customCodeInfo.screenshot,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
            Container(
              width: maxWidth / 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  customCodeInfo.name,
                  style: titleText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                child: TransparentBtn(
                  onPressed: () {
                    state.showUseCustomWidgetDialog(customCodeInfo);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.accent1Darker,
                        border: Border.all(color: theme.divider, width: 3)),
                    child: Center(
                      child: Text(
                        '使用',
                        style: TextStyles.Body3.textColor(theme.txt),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      );
    });
  }

  void _showScreenshotNotFoundTipDialog(BuildContext context) {
    Dialogs.show(
      OkCancelDialog(
        message: '截图缺失，请在自定义组件编辑界面编译预览以上传截图~',
        onOkPressed: () => Navigator.pop(context),
      ),
    );
  }

  void _showScreenshotPreviewWindow(BuildContext context, AppTheme theme,
      int index, int length, String screenshot) {
    final RenderBox? button = context.findRenderObject() as RenderBox?;
    final RenderBox overlay =
        Overlay.of(context)?.context.findRenderObject() as RenderBox;
    var a = button?.localToGlobal(
        Offset(button.size.width - 8.0,
            button.size.height - (length - index) * 80),
        ancestor: overlay);
    var b = button?.localToGlobal(button.size.bottomLeft(Offset(81, 0.0)),
        ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a!, b!),
      Offset.zero & overlay.size,
    );
    showPopupWindow(
      context: context,
      fullWidth: false,
      isShowBg: true,
      position: position,
      elevation: 0.0,
      semanticLabel: "",
      child: Container(
        width: 300,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: theme.bg3,
            borderRadius: BorderRadius.circular(Corners.s8),
            border: Border.all(color: theme.txt, width: 0.2)),
        child: Image.network(
          screenshot,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
