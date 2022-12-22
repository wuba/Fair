import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/mouse_hover_builder.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/components/styled_progress_spinner.dart';
import 'package:fair_online/base/page_routes.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/project_model.dart';
import 'package:fair_online/utils/project_utils.dart';
import 'package:fair_online/views/main/main_scaffold.dart';
import 'package:fair_online/views/project/create/project_create_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProjectItemView extends StatelessWidget {
  const ProjectItemView(this.projectInfo, {Key? key}) : super(key: key);

  final ProjectInfo projectInfo;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    TextStyle cardContentText = TextStyles.T1.textColor(theme.txt);
    return TransparentBtn(
      onPressed: () {
        ProjectUtils.projectName = projectInfo.name;
        Navigator.push<void>(
            context,
            PageRoutes.fade(
                () => MainScaffold(), Durations.slow.inMilliseconds * .001));
      },
      borderRadius: Corners.s8,
      contentPadding: EdgeInsets.zero,
      child: StyledCard(
        align: Alignment.center,
        bgColor: theme.divider,
        child: Row(
          children: [
            Container(
              width: 12,
              decoration: BoxDecoration(
                color: theme.accent1Darker,
                borderRadius: BorderRadius.horizontal(left: Corners.s8Radius),
              ),
            ),
            HSpace(Insets.l),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(projectInfo.name, style: cardContentText),
                      ),
                      HSpace(Insets.m),
                      TransparentBtn(
                        onPressed: () {
                          _showDeleteProjectDialog(context, projectInfo);
                        },
                        hoverColor: Colors.transparent,
                        downColor: Colors.transparent,
                        borderRadius: Corners.s5,
                        child:
                            MouseHoverBuilder(builder: (context, isHovering) {
                          return Icon(
                            Icons.delete_forever,
                            size: 25,
                            color: isHovering ? theme.txt : theme.grey,
                          );
                        }),
                      ),
                    ],
                  ),
                  VSpace(Insets.xs),
                  Text(
                    '最近修改：${_getModifiedTime()}',
                    style: TextStyles.Body2.textColor(theme.grey),
                  ),
                ],
              ),
            ),
            HSpace(Insets.l),
          ],
        ),
      ).height(84),
    );
  }

  String _getModifiedTime() {
    var time = int.parse(projectInfo.modifiedTime);
    return DateFormat("yyyy-MM-dd HH:mm")
        .format(DateTime.fromMicrosecondsSinceEpoch(time));
  }

  Future<void> _showDeleteProjectDialog(
      BuildContext context, ProjectInfo projectInfo) async {
    Dialogs.show(
      OkCancelDialog(
        message: '确定要删除工程：\"${projectInfo.name}\" ？',
        onCancelPressed: () => Navigator.pop(context),
        onOkPressed: () {
          Navigator.pop(context);
          _deleteProject(context, projectInfo);
        },
      ),
    );
  }

  Future<void> _deleteProject(
      BuildContext context, ProjectInfo projectInfo) async {
    Dialogs.show(StyledProgressSpinner());
    var projectModel = context.read<ProjectModel>();
    var result = await projectModel.deleteProject(projectInfo.name);
    Navigator.pop(context);
    if (result == null || result.error.message.isNotEmpty) {
      Dialogs.show(
        OkCancelDialog(
          message: result?.error.message ?? '删除工程失败，请稍后再试~',
          onOkPressed: () => Navigator.pop(context),
        ),
      );
      return;
    }
    projectModel.getProjects();
  }
}

class AddProjectItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    TextStyle cardContentText = TextStyles.T1.textColor(theme.txt);

    return TransparentBtn(
      onPressed: () {
        Dialogs.show(ProjectCreateDialog());
      },
      borderRadius: Corners.s8,
      contentPadding: EdgeInsets.zero,
      child: StyledCard(
        bgColor: theme.accent1Dark,
        align: Alignment.center,
        child: Row(
          children: [
            HSpace(Insets.l),
            Icon(
              Icons.add,
              size: 16,
              color: theme.txt,
            ),
            HSpace(Insets.sm),
            Text('工程创建', style: cardContentText),
            HSpace(Insets.l),
          ],
        ),
      ).height(84),
    );
  }
}
