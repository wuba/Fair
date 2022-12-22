import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/views/page/create/create_page_dialog.dart';
import 'package:fair_online/views/page/page_list_page.dart';
import 'package:fair_online/views/page/page_main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageMainPageView extends WidgetView<PageMainPage, PageMainPageState> {
  PageMainPageView(PageMainPageState state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: TransparentBtn(
              onPressed: () {
                _showCreatePageDialog(context);
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
                    Text('页面创建', style: TextStyles.T1.textColor(theme.txt)),
                    HSpace(Insets.l),
                  ],
                ),
              ).height(45).width(150),
            ),
          ),
          Expanded(
            child: PageListPage(),
          )
        ],
      ),
    );
  }

  void _showCreatePageDialog(BuildContext context) {
    Dialogs.show(CreatePageDialog());
  }
}
