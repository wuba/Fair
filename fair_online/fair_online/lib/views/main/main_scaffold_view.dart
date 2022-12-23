import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/fading_index_stack.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/models/app_model.dart';
import 'package:fair_online/views/api_call_page/api_call_page.dart';
import 'package:fair_online/views/custom_code_page/custom_code_page.dart';
import 'package:fair_online/views/dependency/dependency_page.dart';
import 'package:fair_online/views/editor_example/editor_example.dart';
import 'package:fair_online/views/flutter_editor/fair_editor.dart';
import 'package:fair_online/views/left_panel/left_panel.dart';
import 'package:fair_online/views/main/main_scaffold.dart';
import 'package:fair_online/views/top_panel/top_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScaffoldView extends WidgetView<MainScaffold, MainScaffoldState> {
  MainScaffoldView(MainScaffoldState state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    var currentPage =
        context.select<AppModel, MainPage>((value) => value.currentMainPage);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2, color: theme.divider))),
              child: TopPanel(),
            ),
            Flexible(
                child: Row(
              children: [
                LeftPanel(),
                Flexible(
                  child: FadingIndexedStack(
                    index: state.getSelectedIndex(currentPage),
                    children: [
                      Container(child: Center(child: Text('Loading...'))),
                      FairEditor(),
                      ApiCallPage(),
                      CustomCodePage(),
                      EditorExample(),
                      DependencyPage()
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
