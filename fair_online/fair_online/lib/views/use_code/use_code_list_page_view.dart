import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/models/app_model.dart';
import 'package:fair_online/models/custom_code_model.dart';
import 'package:fair_online/views/use_code/use_action_item_view.dart';
import 'package:fair_online/views/use_code/use_code_list_page.dart';
import 'package:fair_online/views/use_code/use_component_item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UseCodeListPageView
    extends WidgetView<UseCodeListPage, UseCodeListPageState> {
  List<CustomActionInfo> actions = [];
  List<CustomComponentInfo> components = [];

  UseCodeListPageView(UseCodeListPageState state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle titleText = TextStyles.T1.textColor(theme.txt);
    TextStyle contentText = TextStyles.T2.textColor(theme.txt);
    CustomCodeModel model = context.watch<CustomCodeModel>();
    components = model.componentsResponse.result;
    actions = model.actionsResponse.result;
    final List<Tab> tabs = [Tab(text: "组件"), Tab(text: "Action")];
    return LayoutBuilder(builder: (context, dimens) {
      double maxWidth = dimens.maxWidth;
      double maxHeight = dimens.maxHeight;
      return Container(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VSpace(20),
              TransparentBtn(
                onPressed: () {
                  context.read<AppModel>().currentMainPage =
                      MainPage.CustomCode;
                },
                borderRadius: Corners.s8,
                contentPadding: EdgeInsets.zero,
                child: StyledCard(
                  bgColor: theme.accent1Dark,
                  align: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HSpace(Insets.l),
                      Icon(
                        Icons.add,
                        size: 16,
                        color: theme.txt,
                      ),
                      HSpace(Insets.sm),
                      Text(state.index == 0 ? '添加组件' : '添加Action',
                          style: TextStyles.T1.textColor(theme.txt)),
                      HSpace(Insets.l),
                    ],
                  ),
                ).height(45).width(150),
              ),
              VSpace(20),
              Container(
                height: 2,
                color: theme.divider,
              ),
              Container(
                width: 600,
                height: 40,
                child: TabBar(
                  controller: this.state.controller,
                  tabs: tabs,
                ),
              ),
              Container(
                width: maxWidth,
                height: maxHeight - 130,
                child: TabBarView(
                  controller: this.state.controller,
                  children: [
                    Container(
                      child: ListView.separated(
                          itemCount: components.length,
                          controller: ScrollController(),
                          itemBuilder: (BuildContext context, int index) {
                            CustomComponentInfo info = components[index];
                            return UseComponentItemView(
                                info, state, components.length, index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return ColoredBox(
                              color: theme.divider,
                              child: SizedBox(
                                height: 2,
                              ),
                            );
                          }),
                    ),
                    Container(
                      child: ListView.separated(
                          itemCount: actions.length,
                          controller: ScrollController(),
                          itemBuilder: (BuildContext context, int index) {
                            CustomActionInfo info = actions[index];
                            return UseActionItemView(
                                info, state, components.length, index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return ColoredBox(
                              color: theme.divider,
                              child: SizedBox(
                                height: 2,
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
