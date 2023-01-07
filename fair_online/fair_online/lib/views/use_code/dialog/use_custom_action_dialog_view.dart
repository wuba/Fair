import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/views/use_code/dialog/use_custom_action_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UseCustomActionDialogView
    extends WidgetView<UseCustomActionDialog, UseCustomActionDialogState> {
  UseCustomActionDialogView(state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return LayoutBuilder(builder: (context, dimens) {
      double maxWidth = dimens.maxWidth * 0.6;
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
                      _buildItemPadding(10),

                      ///标题
                      Text(
                        state.customActionInfo.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      _buildItemPadding(10),

                      /// 简介
                      Text(
                        state.customActionInfo.desc.isEmpty
                            ? '空的'
                            : state.customActionInfo.desc,
                        maxLines: 2,
                        style: TextStyle(color: Color(0xff8B97A2)),
                      ),
                      _buildItemPadding(10),

                      /// tips
                      Text(
                        "提示：点击复制将代码（FairWidget）粘贴至使用的地方",
                        maxLines: 2,
                        style: TextStyle(color: Colors.orange),
                      ),
                      _buildItemPadding(10),

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
                                  viewType: UseCustomActionDialogState
                                      .copyEditorViewType,
                                );
                              })),
                            ],
                          ),
                        ),
                      ),
                      _buildItemPadding(10),
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
                                Clipboard.setData(
                                    ClipboardData(text: state.getActionCode()));
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                      _buildItemPadding(10),
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
