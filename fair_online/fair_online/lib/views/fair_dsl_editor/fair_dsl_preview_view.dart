import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/models/fair_dsl_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fair_dsl_editor.dart';
import 'fair_dsl_preview.dart';

class FairDslPreviewView
    extends WidgetView<FairDslPreview, FairDslPreviewState> {
  FairDslPreviewView(FairDslPreviewState state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme.of(context);
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 70,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Selector<FairDslModel, bool>(
                      selector: (context, model) => model.isBuilding,
                      builder: (context, value, child) {
                        return ElevatedButton.icon(
                          icon: value
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        appTheme.accent1Darker),
                                    backgroundColor: appTheme.grey,
                                    strokeWidth: 3.0,
                                  ),
                                )
                              : Icon(
                                  Icons.build,
                                  size: 20,
                                ),
                          label: Text('Build'),
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(100, 50)),
                            backgroundColor: MaterialStateProperty.all(
                                value ? appTheme.bg2 : appTheme.accent1),
                          ),
                          onPressed: () => state.handleCompilePressed(),
                        );
                      }),
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Selector<FairDslModel, bool>(
                      selector: (context, model) => model.isRunning,
                      builder: (context, value, child) {
                        return ElevatedButton.icon(
                          icon: value
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        appTheme.accent1Darker),
                                    backgroundColor: appTheme.grey,
                                    strokeWidth: 3.0,
                                  ),
                                )
                              : Icon(
                                  Icons.play_arrow,
                                  size: 20,
                                ),
                          label: Text('Run'),
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(100, 50)),
                            backgroundColor: MaterialStateProperty.all(
                                value ? appTheme.bg2 : appTheme.accent1),
                          ),
                          onPressed: () => state.handleRunPressed(),
                        );
                      }),
                ),
              ),
            ],
          ),
          Container(height: 2, color: appTheme.divider),
          Flexible(
            child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: HtmlElementView(
                  viewType: FairDslEditorState.fairDslPreviewViewType,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
