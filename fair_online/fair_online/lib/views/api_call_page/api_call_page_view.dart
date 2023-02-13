import 'package:fair_online/app/styles.dart';
import 'package:fair_online/base/components/buttons/base_styled_button.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/models/api_call_model.dart';
import 'package:fair_online/utils/string_utils.dart';
import 'package:fair_online/views/api_call_page/api_call_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api_call_page.dart';

class ApiCallPageView extends WidgetView<ApiCallPage, ApiCallPageState> {
  ///view所需的高度
  final double requiredWidth;

  ///view所需的高度
  final double requiredHeight;
  final AppTheme theme;

  ApiCallPageView(
    ApiCallPageState state, {
    required this.requiredWidth,
    required this.requiredHeight,
    required this.theme,
  }) : super(state);

  @override
  Widget build(BuildContext context) {
    final apiCallModel = context.read<ApiCallModel>();

    return Container(
      color: theme.bg3,
      child: Center(
        child: Container(
          width: requiredWidth,
          height: requiredHeight,
          decoration: BoxDecoration(
              color: theme.bg1,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: [
              _getHeader(context, apiCallModel),
              _getStableHeader1(),
              _getApiContent(context),
            ],
          ),
        ),
      ),
    );
  }

  ///头部标题 + 右侧按钮
  Widget _getHeader(BuildContext context, ApiCallModel model) => Container(
        constraints: BoxConstraints(minHeight: requiredHeight / 6),
        decoration: BoxDecoration(
            color: theme.bg2,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        padding: EdgeInsets.only(left: 30, right: 60),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              API_CALL_TITLE,
              style: TextStyles.H1,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseStyledBtn(
                  minWidth: 160,
                  minHeight: 60,
                  bgColor: theme.accent2,
                  hoverColor: theme.accent1,
                  child: Text(
                    BEHAVIOR_ADD_COMMON_HEADER,
                    style: TextStyles.Btn.textColor(theme.txt),
                  ),
                  onPressed: () {
                    //todo-blues 原型图没有这块的逻辑，待确认后续操作
                    Dialogs.show(
                      OkCancelDialog(
                        message: COMMON_FUNCTION_TIPS,
                        onOkPressed: () => Navigator.pop(context),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: BaseStyledBtn(
                    minWidth: 160,
                    minHeight: 60,
                    bgColor: theme.accent1,
                    hoverColor: theme.accent2,
                    child: Text(
                      BEHAVIOR_ADD_API_CALL,
                      style: TextStyles.Btn.textColor(theme.txt),
                    ),
                    onPressed: () {
                      model.changeAddView(true);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      );

  ///固定的头部标题栏
  Widget _getStableHeader1() => Container(
        constraints: BoxConstraints(minHeight: requiredHeight / 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: STABLE_TITLES
              .map((title) => Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyles.Body1.textColor(theme.greyWeak),
                      ),
                    ),
                  ))
              .toList()
            ..add(Expanded(
              child: Container(),
              flex: 1,
            )),
        ),
      );

  ///Api call内容
  Widget _getApiContent(BuildContext context) {
    final result = context
        .select<ApiCallModel, GetApiCallResponse>((value) => value.apiCalls);

    if (result.api.isEmpty) {
      return Center(
        child: Text(COMMON_EMPTY_TIPS),
      );
    }

    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: result.api.length,
            itemBuilder: (BuildContext context, int index) =>
                _getApiItem(context, result.api[index])));
  }

  Widget _getApiItem(
    BuildContext context,
    ApiCallInfo model,
  ) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //点击编辑api
          context
              .read<ApiCallModel>()
              .changeAddView(true, isEdit: true, editApiCallInfo: model);
        },
        child: Container(
          constraints: BoxConstraints(minHeight: requiredHeight / 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              _getItem(model.name),
              _getItem(model.method),
              _getItem(model.url),
              _getItem('JSON'),
              _getDeleteIcon(context, model)
            ],
          ),
        ),
      );

  Widget _getItem(String value) => Expanded(
        flex: 2,
        child: Center(
          child: Text(
            value,
            style: TextStyles.Body1,
          ),
        ),
      );

  ///删除icon
  Widget _getDeleteIcon(BuildContext context, ApiCallInfo info) => Expanded(
      flex: 1,
      child: Container(
        child: TransparentBtn(
          child: Icon(Icons.delete),
          onPressed: () async {
            //删除api call item
            final model = context.read<ApiCallModel>();
            final result = await model.deleteApiCall(info.name);
            if (result == null || result.error.message.isNotEmpty) {
              Dialogs.show(
                OkCancelDialog(
                  message: result?.error.message ??
                      COMMON_BEHAVIOR_ERROR_TIPS.format('删除'),
                  onOkPressed: () => Navigator.pop(context),
                ),
              );
            } else {
              model.getAllApiCall();
            }
          },
        ),
        margin: EdgeInsets.only(right: 60),
      ));
}
