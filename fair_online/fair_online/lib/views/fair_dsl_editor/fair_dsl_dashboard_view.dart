import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/one_line_text.dart';
import 'package:fair_online/base/components/scrolling/styled_listview.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/fair_dsl_model.dart';
import 'package:fair_online/utils/color_utils.dart';
import 'package:fair_online/views/fair_dsl_editor/fair_dsl_dashboard.dart';
import 'package:fair_online/views/page/page_main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FairDslDashboardView
    extends WidgetView<PageMainPage, FairDslDashboardState> {
  FairDslDashboardView(FairDslDashboardState state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    var fairDslListResponse =
        context.select<FairDslModel, GetFairDslListResponse>(
            (value) => value.fairDslListResponse);
    var currentSelectIndex =
        context.select<FairDslModel, int>((value) => value.currentSelectIndex);
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          OneLineText('Fair DSL列表', style: TextStyles.T1.textColor(theme.txt)),
          VSpace(Insets.m),
          ListView.builder(
              itemCount: fairDslListResponse.result.length,
              itemBuilder: (BuildContext context, int index) {
                return _getItemWidget(
                    context,
                    theme,
                    fairDslListResponse.result[index],
                    index == currentSelectIndex,
                    index);
              }).expanded(),
        ],
      ),
    );
  }

  Widget _getItemWidget(BuildContext context, AppTheme theme,
      FairDslInfo fairDslInfo, bool isSelected, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          var fairDslModel = context.read<FairDslModel>();
          fairDslModel.currentSelectIndex = index;
          fairDslModel.getCurrentFairDsl(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: Corners.s5Border,
            border: Border.all(
                color: isSelected
                    ? theme.accent1Dark
                    : ColorUtils.shiftHsl(theme.divider, .2),
                width: 1),
          ),
          child: Row(
            children: [
              HSpace(Insets.m),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fairDslInfo.jsonPath,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.Body2.textColor(theme.accentTxt),
                  ),
                  VSpace(4),
                  Text(
                    fairDslInfo.jsPath,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.Body2.textColor(theme.accentTxt),
                  )
                ],
              ).expanded(),
              HSpace(Insets.m),
            ],
          ),
        ),
      ),
    );
  }
}
