import 'package:fair_online/base/components/mouse_hover_builder.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/app/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

///分析信息视图
class Analyze extends StatelessWidget {
  FlutterEditorController controller;
  bool isShow;
  double width;
  double maxHeight;

  Analyze(
      {required this.controller,
      this.isShow = true,
      this.width = 400,
      this.maxHeight = 400});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return ValueListenableBuilder<List<AnalysisIssue>?>(
        valueListenable: controller.analysisIssuesNotifier,
        builder: (context, analysisIssues, child) {
          return analysisIssues?.isNotEmpty == true && isShow
              ? Container(
                  width: width,
                  color: Color(0xff1c2834),
                  padding: const EdgeInsets.all(8),
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  child: ListView.builder(
                    itemCount: analysisIssues!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      AnalysisIssue issue = analysisIssues[index];
                      Color kindColor = Colors.white;
                      switch (issue.kind) {
                        case "info":
                          kindColor = Colors.white;
                          break;
                        case "warning":
                          kindColor = Colors.yellow;
                          break;
                        case "error":
                          kindColor = theme.error;
                          break;
                      }
                      return Column(
                        children: [
                          MouseHoverBuilder(
                            isClickable: true,
                            builder: (context, isHovering) => Container(
                              color: isHovering ? Color(0xff17202A) : null,
                              child: GestureDetector(
                                onTap: () {
                                  controller.jumpToLocation(issue.line,
                                      issue.charStart, issue.charLength);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ///类型标签
                                      Container(
                                        width: 74,
                                        height: 23,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kindColor,
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3))),
                                        child: Text(
                                          issue.kind,
                                          style: TextStyle(
                                              color: kindColor,
                                              fontSize: 14,
                                              wordSpacing: 1.1),
                                        ),
                                      ),

                                      ///问题信息
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  _createMessageWidgets(issue),
                                            ),
                                          )),

                                      ///复制按钮
                                      Container(
                                        width: 74,
                                        alignment: Alignment.topCenter,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.copy,
                                            color: Colors.white,
                                          ),
                                          onPressed: () => Clipboard.setData(
                                              ClipboardData(
                                                  text: issue.message)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      );
                    },
                  ),
                )
              : Container(
                  width: width,
                  height: 0,
                );
        });
  }

  /**
   * 创建问题信息控件
   */
  List<Widget> _createMessageWidgets(AnalysisIssue issue) {
    List<Widget> messageWidgets = [];
    List<InlineSpan> messageTexts = [];
    messageTexts.add(TextSpan(
      text:
          'line ${issue.line} • ${issue.message.trim().replaceAll('\n\n', '').replaceAll('\n', '')}',
      style: TextStyle(color: Colors.white),
    ));
    if (issue.url.isNotEmpty) {
      messageTexts.add(TextSpan(
          text: ' (view docs)',
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launch(issue.url);
            }));
    }
    messageWidgets.add(Text.rich(TextSpan(children: messageTexts)));
    if (issue.correction.isNotEmpty) {
      messageWidgets.add(Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          '${issue.correction}',
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
    for (final diagnostic in issue.diagnosticMessages) {
      messageWidgets.add(Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          '${diagnostic.message}',
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
    return messageWidgets;
  }
}
