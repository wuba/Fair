import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/components/styled_text_input.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:flutter/material.dart';

import 'edit_dependency_dialog.dart';

class EditDependencyDialogView
    extends WidgetView<EditDependencyDialog, EditDependencyDialogState> {
  String inputVersion = "";

  EditDependencyDialogView(EditDependencyDialogState state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle titleText = TextStyles.T1.textColor(theme.txt);
    TextStyle contentText = TextStyles.T2.textColor(theme.txt);
    inputVersion = widget.version;
    return LayoutBuilder(builder: (context, dimens) {
      double maxWidth = dimens.maxWidth * 0.5;
      return StyledDialog(
        shrinkWrap: false,
        bgColor: theme.bg2,
        padding: EdgeInsets.all(0),
        maxWidth: maxWidth,
        child: Container(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Text("添加依赖", style: titleText),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: maxWidth,
                color: theme.bg1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 40),
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                "依赖名称：",
                                style: titleText,
                              ),
                            ),
                            Container(
                              width: 300,
                              child: Text(
                                widget.name,
                                style: titleText,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 40),
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                "依赖版本：",
                                style: titleText,
                              ),
                            ),
                            Container(
                              width: 300,
                              child: buildTextInput(context, "", inputVersion,
                                  (value) {
                                //文字改变
                                inputVersion = value;
                              },
                                  autoFocus: true,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Insets.l * 0.8,
                                      horizontal: Insets.l * 0.8)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(
                            top: 40, left: 20, right: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: StyledCard(
                                bgColor: theme.accent1Darker,
                                align: Alignment.center,
                                onPressed: () => state.cancel(),
                                child: Container(
                                  width: 140,
                                  child: Center(
                                    child: Text("取消", style: contentText),
                                  ),
                                ),
                              ),
                              margin: EdgeInsets.only(right: 20),
                            ),
                            StyledCard(
                              bgColor: theme.accent1Darker,
                              align: Alignment.center,
                              onPressed: () =>
                                  state.edit(widget.name, inputVersion),
                              child: Container(
                                width: 140,
                                child: Center(
                                  child: Text("确定", style: contentText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget buildTextInput(BuildContext context, String hint, String? initial,
      void Function(String)? onChanged,
      {bool autoFocus = false,
      EdgeInsets padding = StyledFormTextInput.kDefaultTextInputPadding,
      int? maxLines = 1,
      TextEditingController? controller}) {
    return StyledFormTextInput(
        controller: controller,
        hintText: hint,
        contentPadding: padding,
        autoFocus: autoFocus,
        initialValue: initial,
        maxLines: maxLines,
        textStyle: TextStyles.Body1.size(FontSizes.s18),
        onChanged: onChanged);
  }
}
