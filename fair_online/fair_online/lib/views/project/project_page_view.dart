import 'dart:math';

import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/simple_grid.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_container.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/models/project_model.dart';
import 'package:fair_online/views/project/project_item.dart';
import 'package:fair_online/views/project/project_page.dart';
import 'package:fair_online/views/top_panel/top_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectPageView extends WidgetView<ProjectPage, ProjectPageState> {
  ProjectPageView(ProjectPageState state) : super(state);

  @override
  Widget build(BuildContext context) {
    GetProjectResponse projects =
        context.select<ProjectModel, GetProjectResponse>(
            (value) => value.projectResponse);
    bool isLoading =
        context.select<ProjectModel, bool>((value) => value.isLoading);
    AppTheme theme = context.watch();
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2, color: theme.divider))),
              child: TopPanel(showTab: false),
            ),
            Flexible(
              child: StyledContainer(
                theme.bg1,
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                align: Alignment.center,
                borderRadius: Corners.s8Border,
                shadows: Shadows.m(theme.accent1Darker),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('欢迎使用Fair云开发平台',
                          style: TextStyles.T1
                              .size(FontSizes.s18)
                              .textColor(theme.txt)),
                      VSpace(Insets.l),
                      Text('My Projects',
                          style: TextStyles.H1.textColor(theme.txt)),
                      VSpace(Insets.l),
                      isLoading
                          ? Expanded(
                              child: Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          : LayoutBuilder(builder: (_, constraints) {
                              List<Widget> kids = [];
                              kids.add(AddProjectItemView());
                              kids.addAll(projects.result
                                  .map((data) => ProjectItemView(data))
                                  .toList());
                              int colCount =
                                  max(1, (constraints.maxWidth / 320).floor());
                              return SingleChildScrollView(
                                child: SimpleGrid(
                                  kidHeight: 84,
                                  kids: kids,
                                  colCount: colCount,
                                  hSpace: Insets.xl * .75,
                                  vSpace: Insets.xl * .75,
                                ),
                              );
                            })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
