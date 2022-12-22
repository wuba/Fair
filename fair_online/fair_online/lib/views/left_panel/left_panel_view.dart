import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/models/app_model.dart';
import 'package:fair_online/models/dart_editor_model.dart';
import 'package:fair_online/views/left_panel/left_panel.dart';
import 'package:fair_online/views/left_panel/left_panel_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeftPanelView extends WidgetView<LeftPanel, LeftPanelState> {
  LeftPanelView(LeftPanelState state) : super(state);

  @override
  Widget build(BuildContext context) {
    var currentPage =
        context.select<AppModel, MainPage>((value) => value.currentMainPage);
    var currentFlutterEditorLeftPanel =
        context.select<AppModel, FlutterEditorLeftPanel>(
            (value) => value.currentFlutterEditorLeftPanel);
    AppTheme theme = AppTheme.of(context);
    return Container(
      width: 65,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 2, color: theme.divider))),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "UI",
            style: TextStyles.T2.textColor(theme.txt),
          ),
          SizedBox(
            height: 10,
          ),
          LeftPanelBtn(
            Icons.article_outlined,
            iconSize: 25,
            isSelected: currentPage == MainPage.FlutterEditor &&
                currentFlutterEditorLeftPanel == FlutterEditorLeftPanel.Page,
            onPressed: () {
              this.state.setCurrentPage(MainPage.FlutterEditor);
              this.state.setCurrentFlutterEditorLeftPanel(
                  FlutterEditorLeftPanel.Page);
              this.state.setCurrentFlutterEditorPage(FlutterEditorPage.Flutter);
              context.read<DartEditorModel>().didChangeDependencies();
            },
          ),
          LeftPanelBtn(
            Icons.apartment,
            iconSize: 25,
            isSelected: currentPage == MainPage.FlutterEditor &&
                currentFlutterEditorLeftPanel ==
                    FlutterEditorLeftPanel.Component,
            onPressed: () {
              this.state.setCurrentPage(MainPage.FlutterEditor);
              this.state.setCurrentFlutterEditorLeftPanel(
                  FlutterEditorLeftPanel.Component);
              this.state.setCurrentFlutterEditorPage(FlutterEditorPage.Flutter);
              context.read<DartEditorModel>().didChangeDependencies();
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: theme.divider,
            height: 2,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Logic",
            style: TextStyles.T2.textColor(theme.txt),
          ),
          SizedBox(
            height: 10,
          ),
          // LeftPanelBtn(
          //   Icons.wifi,
          //   iconSize: 25,
          //   isSelected: currentPage == MainPage.ApiCall,
          //   onPressed: () => this.state.setCurrentPage(MainPage.ApiCall),
          // ),
          LeftPanelBtn(
            Icons.add_box_rounded,
            iconSize: 25,
            isSelected: currentPage == MainPage.CustomCode,
            onPressed: () => this.state.setCurrentPage(MainPage.CustomCode),
          ),
          LeftPanelBtn(
            Icons.settings,
            iconSize: 25,
            isSelected: currentPage == MainPage.Dependency,
            onPressed: () => this.state.setCurrentPage(MainPage.Dependency),
          ),
          // LeftPanelBtn(
          //   Icons.add_box_rounded,
          //   iconSize: 25,
          //   isSelected: currentPage == MainPage.CustomComponent,
          //   onPressed: () => this.state.setCurrentPage(MainPage.CustomComponent),
          // ),
          // LeftPanelBtn(
          //   Icons.alternate_email,
          //   iconSize: 25,
          //   isSelected: currentPage == MainPage.EditorExample,
          //   onPressed: () => this.state.setCurrentPage(MainPage.EditorExample),
          // ),
        ],
      ),
    );
  }
}
