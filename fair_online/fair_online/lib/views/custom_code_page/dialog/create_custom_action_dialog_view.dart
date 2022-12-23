import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/components/styled_text_input.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/editor/component/analyze_widget.dart';
import 'package:fair_online/editor/component/flutter_editor_widget.dart';
import 'package:fair_online/views/custom_code_page/dialog/create_custom_action_dialog.dart';
import 'package:flutter/material.dart';

class CreateCustomActionDialogView
    extends WidgetView<CreateCustomActionDialog, CreateCustomActionDialogState> {
  CreateCustomActionDialogView(state) : super(state);
  String inputName = "";
  String inputDesc = "";

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle titleText = TextStyles.T1.textColor(theme.txt).size(16);
    TextStyle contentText = TextStyles.T2.textColor(theme.txt);

    final inputCtr = TextEditingController();

    return LayoutBuilder(builder: (context, dimens) {
      double maxWidth = dimens.maxWidth * 0.8;
      double maxHeight = dimens.maxHeight * 0.8;
      return NonScrollStyledDialog(
        shrinkWrap: false,
        bgColor: theme.bg2,
        padding: EdgeInsets.all(0),
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        child: Stack(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(
                          top: 20, left: 30, right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('自定义Action', style: titleText),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 30),
                                child: StyledCard(
                                  onPressed: () => {
                                    Navigator.pop(context),
                                  },
                                  bgColor: theme.accent1Darker,
                                  align: Alignment.center,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text('取消', style: contentText),
                                  ),
                                ),
                              ),
                              Container(
                                child: StyledCard(
                                  onPressed: () async {
                                    bool success =
                                        await state.createNewComponent(
                                            inputName, inputDesc);
                                    if (success) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  bgColor: theme.accent1Darker,
                                  align: Alignment.center,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text('保存', style: contentText),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: maxHeight - 100,
                            color: theme.bg1,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        margin: EdgeInsets.only(top: 15),
                                        child: Center(
                                          child: Text('名称', style: titleText),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Container(
                                            child: buildNameWidget(context),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        margin: EdgeInsets.only(top: 15),
                                        child: Center(
                                          child: Text('使用简介', style: titleText),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Container(
                                              child: buildTextInput(
                                                  context,
                                                  '请输入Action简介',
                                                  widget.info?.desc ?? '', (v) {
                                            inputDesc = v;
                                          },
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: Insets.l * 0.8,
                                                      horizontal: Insets.l * 0.8),
                                                  maxLines: 5)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: maxWidth / 5 * 3,
                          height: maxHeight - 100,
                          child: FlutterEditor(controller: state.controller),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                child: Analyze(controller: state.controller),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget buildNameWidget(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle titleText = TextStyles.T1.textColor(theme.txt).size(16);
    if (widget.info == null) {
      //创建文件
      return buildTextInput(context, '请输入Action名', null, (v) {
        inputName = v;
      },
          autoFocus: true,
          padding: EdgeInsets.symmetric(
              vertical: Insets.l * 0.8, horizontal: Insets.l * 0.8));
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Text(widget.info!.name, style: titleText),
      );
    }
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
