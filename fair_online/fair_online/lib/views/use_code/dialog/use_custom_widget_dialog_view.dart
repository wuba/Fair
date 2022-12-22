import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/views/use_code/dialog/use_custom_widget_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UseCustomWidgetDialogView
    extends WidgetView<UseCustomWidgetDialog, UseCustomWidgetDialogState> {
  UseCustomWidgetDialogView(state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return LayoutBuilder(builder: (context, dimens) {
      double maxWidth = dimens.maxWidth * 0.8;
      double maxHeight = dimens.maxHeight;
      return NonScrollStyledDialog(
        shrinkWrap: false,
        bgColor: theme.bg3,
        padding: EdgeInsets.all(15),
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: maxHeight - Insets.lGutter * 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildItemPadding(15),

                      ///标题
                      Text(
                        state.customCodeInfo.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      _buildItemPadding(15),

                      /// 简介
                      Text(
                        state.customCodeInfo.desc.isEmpty
                            ? '空的'
                            : state.customCodeInfo.desc,
                        maxLines: 2,
                        style: TextStyle(color: Color(0xff8B97A2)),
                      ),
                      _buildItemPadding(15),

                      /// tips
                      Text(
                        "提示：点击复制将代码（FairWidget）粘贴至使用的地方",
                        maxLines: 2,
                        style: TextStyle(color: Colors.orange),
                      ),
                      _buildItemPadding(15),

                      /// 代码
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(child: LayoutBuilder(
                                  builder: (context, constraints) {
                                state.dartEditor.setSize(constraints.maxWidth,
                                    constraints.maxHeight);
                                Future.delayed(Duration(milliseconds: 100), () {
                                  state.dartEditor.resize();
                                });
                                return HtmlElementView(
                                  viewType: UseCustomWidgetDialogState
                                      .copyEditorViewType,
                                );
                              })),
                              Container(
                                width: 50,
                              ),
                              Container(
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  state.fairEditor.setSize(constraints.maxWidth,
                                      constraints.maxHeight);
                                  Future.delayed(Duration(milliseconds: 100),
                                      () {
                                    state.fairEditor.resize();
                                  });
                                  return HtmlElementView(
                                    viewType: UseCustomWidgetDialogState
                                        .fairWidgetEditorViewType,
                                  );
                                }),
                                width: dimens.maxWidth * 0.3,
                              )
                            ],
                          ),
                        ),
                      ),
                      _buildItemPadding(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              child: Text('取消'),
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(100, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all(theme.accent1),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          Container(
                            width: 20,
                          ),
                          ElevatedButton(
                              child: Text('</> 粘贴到代码编辑器'),
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(100, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all(theme.accent1),
                              ),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: state.customCodeInfo.fairWidgetCode));
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                      _buildItemPadding(15),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildItemPadding(double padding) {
    return Container(
      height: padding,
    );
  }
}
