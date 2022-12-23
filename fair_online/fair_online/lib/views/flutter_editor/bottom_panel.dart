import 'package:fair_online/app/themes.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/dart_editor_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * 编辑器底部面板
 */
class BottomPanel extends StatelessWidget {
  FlutterEditorController controller;

  double height;

  BottomPanel({required this.controller, required this.height});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
      height: height,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 2, color: theme.divider))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ValueListenableBuilder<List<AnalysisIssue>?>(
            valueListenable: controller.analysisIssuesNotifier,
            builder: ((context, analysisIssues, child) {
              return Selector<DartEditorModel, bool>(
                  selector: (context, model) => model.showAnalyzeDialog,
                  builder: (context, showAnalyzeDialog, child) {
                    final issuesCount = analysisIssues?.length ?? 0;
                    return Text.rich(TextSpan(children: [
                      TextSpan(
                          text: issuesCount == 0
                              ? "no issues  "
                              : "${issuesCount} issues  ",
                          style: TextStyle(color: theme.txt)),
                      TextSpan(
                          text: issuesCount == 0
                              ? ""
                              : "${showAnalyzeDialog ? "hide" : "show"}",
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              final dartEditorModel =
                                  context.read<DartEditorModel>();
                              dartEditorModel.showAnalyzeDialog =
                                  !dartEditorModel.showAnalyzeDialog;
                            })
                    ]));
                  });
            }),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Text("Based on Flutter 3.3.0 Dart SDK 2.18.0"),
          )
        ],
      ),
    );
  }
}
