import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/fading_index_stack.dart';
import 'package:fair_online/base/components/one_line_text.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/styled_tab_bar.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/models/fair_dsl_model.dart';
import 'package:fair_online/views/fair_dsl_editor/fair_dsl_code_editor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FairDslCodeEditorView
    extends WidgetView<FairDslCodeEditor, FairDslCodeEditorState> {
  FairDslCodeEditorView(FairDslCodeEditorState state) : super(state);

  void _handleTabPressed(int index) {
    state.context.read<FairDslModel>().fairDslViewerType =
        index == 0 ? FairDslViewerType.JSON : FairDslViewerType.JS;
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    var fairDslViewerType = context.select<FairDslModel, FairDslViewerType>(
        (model) => model.fairDslViewerType);
    int tabIndex = 0;
    if (fairDslViewerType == FairDslViewerType.JS) {
      tabIndex = 1;
    }
    return LayoutBuilder(
      builder: (_, constraints) {
        double tabWidth =
            constraints.maxWidth < PageBreaks.LargePhone ? 240 : 280;
        TextStyle headerStyle = TextStyles.T1;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            VSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                OneLineText("Fair DSL Viewer",
                        style: headerStyle.textColor(theme.txt))
                    .flexible(),
                StyledTabBar(
                  index: tabIndex,
                  sections: ["JSON File", "JS File"],
                  onTabPressed: _handleTabPressed,
                )
                    .constrained(maxWidth: tabWidth, animate: true)
                    .animate(Durations.medium, Curves.easeOut),
              ],
            ).padding(horizontal: Insets.lGutter),
            VSpace(Insets.m),

            /// Fading Stack to hold the 2 lists
            Flexible(
              child: FadingIndexedStack(
                index: tabIndex,
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    state.jsonEditor
                        .setSize(constraints.maxWidth, constraints.maxHeight);
                    return HtmlElementView(
                      viewType: FairDslCodeEditorState.jsonEditorViewType,
                    );
                  }),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      state.javascriptEditor
                          .setSize(constraints.maxWidth, constraints.maxHeight);
                      return HtmlElementView(
                        viewType:
                            FairDslCodeEditorState.javascriptEditorViewType,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
