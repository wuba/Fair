import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/base_styled_button.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/components/styled_text_input.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/api_call_model.dart';
import 'package:fair_online/utils/string_utils.dart';
import 'package:fair_online/views/api_call_page/api_call_constants.dart';
import 'package:fair_online/views/api_call_page/api_call_page.dart';
import 'package:fair_online/views/api_call_page/popup_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class ApiCallAddPageView extends WidgetView<ApiCallPage, ApiCallPageState> {
  ///view所需的高度
  final double requiredWidth;

  ///view所需的高度
  final double requiredHeight;
  final AppTheme theme;

  final _nameController = TextEditingController();
  final _urlController = TextEditingController();

  ApiCallAddPageView(
    ApiCallPageState state, {
    required this.requiredWidth,
    required this.requiredHeight,
    required this.theme,
  }) : super(state);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.bg3,
      child: Center(
        child: Container(
          width: requiredWidth,
          height: requiredHeight,
          decoration: BoxDecoration(
              color: theme.bg1,
              borderRadius: BorderRadius.all(Radius.circular(Corners.dialog))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getHeader(context),
              _getContent(context),
            ],
          ),
        ),
      ),
    );
  }

  ///头部标题 + 右侧按钮
  Widget _getHeader(BuildContext context) {
    final model = context.read<ApiCallModel>();

    return Container(
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Icon(Icons.arrow_back_ios_rounded),
                onTap: () {
                  model.changeAddView(false);
                },
              ),
              HSpace(Insets.l),
              Text(
                BEHAVIOR_API_CALL_ADD,
                style: TextStyles.H1,
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseStyledBtn(
                minWidth: 160,
                minHeight: 60,
                bgColor: theme.accent2,
                hoverColor: theme.accent1,
                child: Row(
                  children: [
                    Text(
                      BEHAVIOR_IMPORT_JSON,
                      style: TextStyles.Btn.textColor(theme.txt),
                    ),
                    GestureDetector(
                      child: Icon(Icons.question_mark_rounded),
                      onTap: () => Dialogs.show(
                        OkCancelDialog(
                          message: SAMPLE_JSON_TEMPLATE,
                          onOkPressed: () => Navigator.pop(context),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () async {
                  model.importJson(onError: () {
                    Dialogs.show(
                      OkCancelDialog(
                        message: COMMON_UNKNOWN_JSON_TIPS,
                        onOkPressed: () => Navigator.pop(context),
                      ),
                    );
                  });
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
                    BEHAVIOR_SAVE,
                    style: TextStyles.Btn.textColor(theme.txt),
                  ),
                  onPressed: () async {
                    //请求接口，成功后再切换页面
                    if (model.apiCallAddModel.params
                        .any((tuple) => tuple.item1.isEmpty)) {
                      Dialogs.show(
                        OkCancelDialog(
                          message: COMMON_EMPTY_PARAMS_TIPS,
                          onOkPressed: () => Navigator.pop(context),
                        ),
                      );
                      return;
                    }

                    //待编辑的api
                    if (model.isEdit) {
                      final editApiName = model.beEditApi?.name ?? '';
                      if (editApiName.isNotEmpty == true) {
                        //编辑的话需要先删除旧数据
                        final deleteResult =
                            await model.deleteApiCall(editApiName);
                        if (deleteResult == null ||
                            deleteResult.error.message.isNotEmpty) {
                          Dialogs.show(
                            OkCancelDialog(
                              message: deleteResult?.error.message ??
                                  COMMON_BEHAVIOR_ERROR_TIPS.format('编辑'),
                              onOkPressed: () => Navigator.pop(context),
                            ),
                          );
                          return;
                        }
                      }
                    }

                    final targetParams = model.apiCallAddModel.params
                        .map(
                          (tuple) => ApiCallParamsInfo()
                            ..key = tuple.item1
                            ..type = tuple.item2
                            ..value = tuple.item3,
                        )
                        .toList();

                    final result = await model.addApiCall(
                        model.apiCallAddModel.name,
                        model.apiCallAddModel.method,
                        model.apiCallAddModel.url,
                        targetParams);
                    if (result == null || result.error.message.isNotEmpty) {
                      Dialogs.show(
                        OkCancelDialog(
                          message: result?.error.message ??
                              COMMON_BEHAVIOR_ERROR_TIPS.format('添加'),
                          onOkPressed: () => Navigator.pop(context),
                        ),
                      );
                      return;
                    } else {
                      await model.getAllApiCall();
                      model.changeAddView(false);
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  ///添加具体内容
  Widget _getContent(BuildContext context) => Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.xl),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            _getNameArea(context),
            _getMethodArea(context),
            _getUrlArea(context),
            ..._getParamsArea(context),
            SliverPadding(padding: EdgeInsets.only(bottom: Insets.xl))
          ],
        ),
      ));

  ///api name 区域
  Widget _getNameArea(BuildContext context) {
    final apiName = context
        .select<ApiCallModel, String>((value) => value.apiCallAddModel.name);
    return SliverToBoxAdapter(
      child: Container(
        width: requiredWidth / 2,
        height: requiredHeight / 10,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              API_NAME,
              style: TextStyles.Body1.textColor(theme.greyWeak),
            ),
            Container(
              width: Sizes.sideBarLg,
              child: StyledFormTextInput(
                controller: _nameController
                  ..text = apiName
                  ..selection = TextSelection.fromPosition(TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: apiName.length)),
                onChanged: (name) =>
                    context.read<ApiCallModel>().updateApiContent(name: name),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///api method type 区域
  Widget _getMethodArea(BuildContext context) => SliverToBoxAdapter(
        child: Container(
          width: requiredWidth / 2,
          height: requiredHeight / 10,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                API_METHOD_TYPE,
                style: TextStyles.Body1.textColor(theme.greyWeak),
              ),
              Container(
                width: Sizes.sideBarLg,
                child: PopupListWidget(
                  onChanged: (change) {
                    context
                        .read<ApiCallModel>()
                        .updateApiContent(method: change ?? 'Get');
                  },
                  selectors: METHOD_SELECTOR,
                  defaultSelector: context.select<ApiCallModel, String>(
                      (value) => value.apiCallAddModel.method),
                ),
              )
            ],
          ),
        ),
      );

  ///api url 区域
  Widget _getUrlArea(BuildContext context) {
    final apiUrl = context
        .select<ApiCallModel, String>((value) => value.apiCallAddModel.url);
    return SliverToBoxAdapter(
      child: Container(
        width: requiredWidth / 2,
        height: requiredHeight / 10,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              API_URL,
              style: TextStyles.Body1.textColor(theme.greyWeak),
            ),
            Container(
              width: Sizes.sideBarLg,
              child: StyledFormTextInput(
                controller: _urlController
                  ..text = apiUrl
                  ..selection = TextSelection.fromPosition(TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: apiUrl.length)),
                onChanged: (url) =>
                    context.read<ApiCallModel>().updateApiContent(url: url),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///api params 区域
  List<Widget> _getParamsArea(BuildContext context) => [
        _getParamsHeaderArea(context),
        SliverPadding(padding: EdgeInsets.only(bottom: Insets.xl)),
        ..._getParamsContentArea(context),
      ];

  /// api params 头部区域
  Widget _getParamsHeaderArea(BuildContext context) => SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(API_PARAMS_TITLE,
                style: TextStyles.Body1.textColor(theme.greyWeak)),
            Container(
              width: Sizes.sideBarLg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseStyledBtn(
                    minWidth: 160,
                    minHeight: 42,
                    bgColor: theme.bg1,
                    hoverColor: theme.greyWeak,
                    outlineColor: theme.greyWeak,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: .5,
                        color: theme.greyWeak,
                      ),
                      borderRadius: Corners.s8Border,
                    ),
                    child: Text(
                      BEHAVIOR_ADD_PARAMS,
                      style: TextStyles.Btn.textColor(theme.txt),
                    ),
                    onPressed: () {
                      // 添加params
                      context.read<ApiCallModel>().addEmptyParamsItem();
                    },
                  ),
                  _getDeleteIcon(context, deleteAll: true),
                ],
              ),
            ),
          ],
        ),
      );

  /// api params 内容区域
  List<Widget> _getParamsContentArea(BuildContext context) {
    final _paramsSize = context.select<ApiCallModel, int>(
        (value) => value.apiCallAddModel.params.length);
    final _params =
        context.select<ApiCallModel, List<Tuple3<String, String, String>>>(
            (value) => value.apiCallAddModel.params);
    print('Blues ===> show params:$_params');
    if (_paramsSize == 0) {
      return [];
    } else {
      return <Widget>[
        for (int i = 0; i < _params.length; i++)
          SliverPadding(
            padding: EdgeInsets.only(left: Insets.xl),
            sliver: _getParamsItem(context, i),
          )
      ];
    }
  }

  ///api params 添加区域
  Widget _getParamsItem(BuildContext context, int index) => SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getCell(context, API_NAME, index, column: 1),
                _getCell(context, API_PARAMS_VALUE_TYPE, index, column: 2),
                _getCell(context, API_PARAMS_DEFAULT_VALUE, index, column: 3),
              ],
            )),
            Container(
              child: _getDeleteIcon(context, index: index),
              margin: EdgeInsets.only(top: Insets.l, left: Insets.l),
            ),
          ],
        ),
      );

  ///api params里 name模块
  ///[index]表示params所在行
  ///[column]表示params所在列
  Widget _getCell(
    BuildContext context,
    String title,
    int index, {
    required int column,
  }) {
    final currentParams =
        context.select<ApiCallModel, Tuple3<String, String, String>>(
            (value) => value.apiCallAddModel.params[index]);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Insets.sm),
            child: Text(title),
          ),
          Container(
            width: Sizes.sideBarSm,
            child: column == 2
                ? Container(
                    width: Sizes.sideBarLg,
                    child: PopupListWidget(
                      onChanged: (value) {
                        context.read<ApiCallModel>().updateParamsValue(
                            index, currentParams.withItem2(value));
                      },
                      selectors: DART_TYPE_SELECTOR,
                      defaultSelector: currentParams.item2,
                    ),
                  )
                : StyledFormTextInput(
                    controller: TextEditingController()
                      ..text = (column == 1
                          ? currentParams.item1
                          : currentParams.item3)
                      ..selection = TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: (column == 1
                              ? currentParams.item1
                              : currentParams.item3).length)),
                    onChanged: (value) {
                      context.read<ApiCallModel>().updateParamsValue(
                          index,
                          column == 1
                              ? currentParams.withItem1(value)
                              : currentParams.withItem3(value));
                    },
                  ),
          )
        ],
      ),
    );
  }

  ///删除icon
  Widget _getDeleteIcon(BuildContext context,
          {bool deleteAll = false, int? index}) =>
      Container(
        child: TransparentBtn(
          child: Icon(deleteAll ? Icons.delete : Icons.highlight_off_rounded),
          onPressed: () {
            // 删除api call item
            final model = context.read<ApiCallModel>();
            if (deleteAll) {
              model.deleteAllParamsItem();
            } else {
              model.deleteParamsItem(index!);
            }
          },
        ),
      );
}
