import 'dart:math';

import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/simple_grid.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/components/styled_progress_spinner.dart';
import 'package:fair_online/base/components/styled_text_input.dart';
import 'package:fair_online/base/page_routes.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/project_model.dart';
import 'package:fair_online/utils/color_utils.dart';
import 'package:fair_online/utils/project_utils.dart';
import 'package:fair_online/views/main/main_scaffold.dart';
import 'package:fair_online/views/project/create/project_template_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef CreateProjectCallback = void Function(String? project);

class ProjectCreateDialog extends StatefulWidget {
  const ProjectCreateDialog({Key? key}) : super(key: key);

  @override
  _ProjectCreateDialogState createState() => _ProjectCreateDialogState();
}

class _ProjectCreateDialogState extends State<ProjectCreateDialog> {
  String? projectName;

  @override
  void initState() {
    super.initState();
    context.read<ProjectModel>().getTemplateProjects();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    GetProjectResponse templateProjects =
        context.select<ProjectModel, GetProjectResponse>(
            (value) => value.templateProjectResponse);
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
                Text('工程创建', style: TextStyles.T1.size(FontSizes.s18)),
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
            Text('创建空工程，或者使用模板工程',
                style: TextStyles.Body2.textColor(theme.greyWeak)),
            VSpace(Insets.l),
            Text('Project Name', style: TextStyles.Body1.textColor(theme.grey)),
            VSpace(Insets.m),
            buildTextInput(context, 'Project Name', null, (v) {
              projectName = v;
            },
                autoFocus: true,
                padding: EdgeInsets.symmetric(
                    vertical: Insets.l * 0.8, horizontal: Insets.l * 0.8)),
            VSpace(Insets.l),
            Container(color: ColorUtils.shiftHsl(theme.divider, .2), height: 1),
            Expanded(child: LayoutBuilder(builder: (_, constraints) {
              int colCount = max(1, (constraints.maxWidth / 200).floor());
              double height = (constraints.maxWidth / colCount) * 16.0 / 9;
              List<Widget> kids = [];
              kids.add(CreateNewProjectItemView(
                height,
                onCreateProjectPressed: (v) {
                  _onCreateProject(projectName, v);
                },
              ));
              kids.addAll(templateProjects.result
                  .map((data) => ProjectTemplateItemView(
                        data,
                        height,
                        onCreateProjectPressed: (v) {
                          _onCreateProject(projectName, v);
                        },
                      ))
                  .toList());
              return SingleChildScrollView(
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
            })),
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
        textStyle: TextStyles.Body1.size(FontSizes.s18),
        onChanged: onChanged);
  }

  Future<void> _onCreateProject(
      String? projectName, String? templateProject) async {
    if (projectName?.isEmpty ?? true) {
      Dialogs.show(
        OkCancelDialog(
          message: '请输入Project Name ~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return;
    }

    Dialogs.show(StyledProgressSpinner());
    var projectModel = context.read<ProjectModel>();
    var result =
        await projectModel.createProject(projectName!, templateProject);
    Navigator.pop(context);
    if (result == null || result.error.message.isNotEmpty) {
      Dialogs.show(
        OkCancelDialog(
          message: result?.error.message ?? '创建工程失败，请稍后再试~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return;
    }
    projectModel.getProjects();
    Navigator.pop(context);
    ProjectUtils.projectName = projectName;
    Navigator.push<void>(
        context,
        PageRoutes.fade(
            () => MainScaffold(), Durations.slow.inMilliseconds * .001));
  }
}
