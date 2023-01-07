import 'dart:math';

import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/scrolling/styled_listview.dart';
import 'package:fair_online/base/components/simple_grid.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/components/styled_progress_spinner.dart';
import 'package:fair_online/base/components/styled_text_input.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/page_model.dart';
import 'package:fair_online/utils/color_utils.dart';
import 'package:fair_online/views/page/create/page_template_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef CreatePageCallback = void Function(String? pagePath, String? pageName);
typedef CreateTemplatePageCallback = void Function(
    String? pagePath, String? pageName, String? templateId);

class CreatePageDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreatePageDialogState();
  }
}

class CreatePageDialogState extends State<CreatePageDialog> {
  String? pagePath;
  String? pageName;

  @override
  void initState() {
    super.initState();
    var model = context.read<PageListModel>();
    model.getTemplatePageList();
  }

  @override
  Widget build(BuildContext context) {
    PageListModel model = context.watch<PageListModel>();
    AppTheme theme = context.watch();
    List<TemplatePageInfo> templatePages =
        model.getTemplatePagesResponse.result;
    return LayoutBuilder(builder: (_, constraints) {
      return NonScrollStyledDialog(
        shrinkWrap: false,
        maxWidth: constraints.maxWidth * 0.7,
        padding: EdgeInsets.only(
            left: Insets.lGutter, right: Insets.lGutter, top: Insets.lGutter),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('页面创建', style: TextStyles.T1.size(FontSizes.s18)),
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
                )
              ],
            ),
            VSpace(Insets.xs),
            Text('选择空页面或者模板页面创建新页面',
                style: TextStyles.Body2.textColor(theme.greyWeak)),
            VSpace(Insets.l),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Page Path',
                        style: TextStyles.Body1.textColor(theme.grey)),
                    VSpace(Insets.m),
                    Container(
                      width: constraints.maxWidth * 0.7 / 2 - 34,
                      child: buildTextInput(
                          context, 'Page Path, 示例: detail_page', null, (v) {
                        pagePath = v;
                      },
                          autoFocus: true,
                          padding: EdgeInsets.symmetric(
                              vertical: Insets.l * 0.8,
                              horizontal: Insets.l * 0.8)),
                    )
                  ],
                ),
                HSpace(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Page Name',
                        style: TextStyles.Body1.textColor(theme.grey)),
                    VSpace(Insets.m),
                    Container(
                      width: constraints.maxWidth * 0.7 / 2 - 34,
                      child: buildTextInput(
                          context, 'Page Name, 示例: DetailPage', null, (v) {
                        pageName = v;
                      },
                          autoFocus: false,
                          padding: EdgeInsets.symmetric(
                              vertical: Insets.l * 0.8,
                              horizontal: Insets.l * 0.8)),
                    )
                  ],
                ),
              ],
            ),
            VSpace(Insets.l),
            Container(color: ColorUtils.shiftHsl(theme.divider, .2), height: 1),
            Expanded(child: LayoutBuilder(builder: (_, constraints) {
              int colCount = max(1, (constraints.maxWidth / 200).floor());
              double height = (constraints.maxWidth / colCount) * 16.0 / 9;
              List<Widget> kids = [];
              kids.add(CreateNewPageItemView(
                height,
                onCreatePagePressed: (path, name) {
                  _onCreatePage(pagePath, pageName);
                },
              ));
              templatePages.forEach((element) {
                kids.add(PageTemplateItemView(
                  element,
                  height,
                  onCreatePagePressed: (path, name) {
                    _onCreateTemplatePage(pagePath, pageName, path);
                  },
                ));
              });
              return SingleChildScrollView(
                physics: StyledScrollPhysics(),
                child: SimpleGrid(
                  isTopSpace: true,
                  isBottomSpace: true,
                  kidHeight: height + 30,
                  kids: kids,
                  colCount: colCount,
                  hSpace: Insets.xl * .75,
                  vSpace: Insets.xl * .75,
                ),
              );
            }))
          ],
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
        textStyle: TextStyles.Body1.size(FontSizes.s14),
        onChanged: onChanged);
  }

  Future<void> _onCreatePage(String? pagePath, String? pageName) async {
    if (pageName?.isEmpty ?? true) {
      Dialogs.show(
        OkCancelDialog(
          message: '请输入Page Name~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return;
    }
    Dialogs.show(StyledProgressSpinner());
    var pageModel = context.read<PageListModel>();
    var result = await pageModel.createEmptyPage(pagePath!, pageName!);
    Navigator.pop(context);
    if (result == null || result.error.message.isNotEmpty) {
      Dialogs.show(
        OkCancelDialog(
          message: result?.error.message ?? '创建页面失败，请稍后再试~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return;
    }
    Navigator.pop(context);
    await pageModel.getPageList();
    pageModel.selectPage(context, pagePath);
  }

  Future<void> _onCreateTemplatePage(
      String? pagePath, String? pageName, String? templatePage) async {
    if (pagePath?.isEmpty ?? true) {
      Dialogs.show(
        OkCancelDialog(
          message: '请输入Page Path~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return;
    }
    if (pageName?.isEmpty ?? true) {
      Dialogs.show(
        OkCancelDialog(
          message: '请输入Page Name~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return;
    }

    Dialogs.show(StyledProgressSpinner());
    var pageModel = context.read<PageListModel>();
    var result =
        await pageModel.createTemplatePage(pagePath!, pageName!, templatePage!);
    Navigator.pop(context);
    if (result == null || result.error.message.isNotEmpty) {
      Dialogs.show(
        OkCancelDialog(
          message: result?.error.message ?? '创建页面失败，请稍后再试~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return;
    }
    Navigator.pop(context);
    await pageModel.getPageList();
    pageModel.selectPage(context, pagePath);
  }
}
