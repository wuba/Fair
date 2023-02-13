import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/base/components/styled_container.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/views/dependency/dependency_item_view.dart';
import 'package:fair_online/views/dependency/dependency_page.dart';
import 'package:flutter/material.dart';

class DependencyPageView
    extends WidgetView<DependencyPage, DependencyPageState> {
  DependencyPageView(DependencyPageState state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle titleText = TextStyles.T1.textColor(theme.txt);
    TextStyle contentText = TextStyles.T2.textColor(theme.txt);
    return Container(
      color: theme.bg3,
      child: StyledContainer(
        theme.bg1,
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        align: Alignment.center,
        borderRadius: Corners.s8Border,
        shadows: Shadows.m(theme.accent1Darker),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Corners.s8Radius),
                  color: theme.divider),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('依赖管理', style: titleText),
                  Row(
                    children: [
                      Container(
                        child: StyledCard(
                          bgColor: theme.accent1Darker,
                          align: Alignment.center,
                          onPressed: () => state.showAddDependencyDialog(),
                          child: Container(
                            width: 140,
                            child: Center(
                              child: Text('添加依赖', style: contentText),
                            ),
                          ),
                        ).height(40),
                        margin: EdgeInsets.only(right: 20),
                      ),
                      StyledCard(
                        bgColor: theme.accent1Darker,
                        align: Alignment.center,
                        onPressed: () => state.doPubGet(),
                        child: Container(
                          width: 140,
                          child: Center(
                            child: Text('pub get', style: contentText),
                          ),
                        ),
                      ).height(40),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemCount: state.list.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return DependencyItemView(state.list[index], () {
                      state.deleteDependency(
                          state.list[index].name, state.list[index].version);
                    }, state.editDependency);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(height: 1, color: theme.divider),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
