import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/base/components/styled_container.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/views/custom_code_page/custom_action_list.dart';
import 'package:fair_online/views/custom_code_page/custom_component_list.dart';
import 'package:flutter/material.dart';

import 'custom_code_page.dart';

const ADD_TEXTS = ["添加组件", "添加Action"];

class CustomCodePageView
    extends WidgetView<CustomCodePage, CustomCodePageState> {
  CustomCodePageView(CustomCodePageState state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle titleText = TextStyles.T1.textColor(theme.txt);
    TextStyle contentText = TextStyles.T2.textColor(theme.txt);
    final List<Tab> tabs = [Tab(text: "自定义组件"), Tab(text: "自定义Action")];
    return LayoutBuilder(builder: (context, dimens) {
      double maxWidth = dimens.maxWidth;
      double maxHeight = dimens.maxHeight;
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Corners.s8Radius),
                    color: theme.divider),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("自定义代码", style: titleText),
                          StyledCard(
                            bgColor: theme.accent1Darker,
                            align: Alignment.center,
                            onPressed: () => state.showCreateDialog(),
                            child: Container(
                              width: 140,
                              child: Center(
                                child: Text(getContentByIndex(),
                                    style: contentText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: 600,
                      height: 40,
                      child: TabBar(
                        controller: state.controller,
                        tabs: tabs,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: maxWidth,
                height: maxHeight - 200,
                child: TabBarView(
                  controller: state.controller,
                  children: [CustomComponentList(), CustomActionList()],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  String getContentByIndex() {
    int index = state.getTabIndex();
    return ADD_TEXTS[index];
  }
}
