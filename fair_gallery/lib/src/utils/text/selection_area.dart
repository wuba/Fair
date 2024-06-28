import 'package:flutter/foundation.dart';

import 'my_extended_text_selection_controls.dart';
import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonSelectionArea extends StatelessWidget {
  const CommonSelectionArea({
    super.key,
    required this.child,
    this.joinZeroWidthSpace = false,
  });
  final Widget child;
  final bool joinZeroWidthSpace;

  @override
  Widget build(BuildContext context) {
    SelectedContent? selectedContent;
    return SelectionArea(
      selectionControls: MyTextSelectionControls(),
      contextMenuBuilder:
          (BuildContext context, SelectableRegionState selectableRegionState) {
        return AdaptiveTextSelectionToolbar.buttonItems(
          buttonItems: <ContextMenuButtonItem>[
            ContextMenuButtonItem(
              onPressed: () {
                // TODO(zmtzawqlp):  how to get Selectable
                // and  _clearSelection is not public
                // https://github.com/flutter/flutter/issues/126980

                //  onCopy: () {
                //   _copy();

                //   // In Android copy should clear the selection.
                //   switch (defaultTargetPlatform) {
                //     case TargetPlatform.android:
                //     case TargetPlatform.fuchsia:
                //       _clearSelection();
                //     case TargetPlatform.iOS:
                //       hideToolbar(false);
                //     case TargetPlatform.linux:
                //     case TargetPlatform.macOS:
                //     case TargetPlatform.windows:
                //       hideToolbar();
                //   }
                // },

                // if (_selectedContent != null) {
                //   String content = _selectedContent!.plainText;
                //   if (joinZeroWidthSpace) {
                //     content = content.replaceAll(zeroWidthSpace, '');
                //   }

                //   Clipboard.setData(ClipboardData(text: content));
                //   selectableRegionState.hideToolbar(true);
                //   selectableRegionState._clearSelection();
                // }

                selectableRegionState
                    .copySelection(SelectionChangedCause.toolbar);

                // remove zeroWidthSpace
                if (joinZeroWidthSpace) {
                  Clipboard.getData('text/plain').then((ClipboardData? value) {
                    if (value != null) {
                      // remove zeroWidthSpace
                      final String? plainText = value.text?.replaceAll(
                          ExtendedTextLibraryUtils.zeroWidthSpace, '');
                      if (plainText != null) {
                        Clipboard.setData(ClipboardData(text: plainText));
                      }
                    }
                  });
                }
              },
              type: ContextMenuButtonType.copy,
            ),
            ContextMenuButtonItem(
              onPressed: () {
                selectableRegionState.selectAll(SelectionChangedCause.toolbar);
              },
              type: ContextMenuButtonType.selectAll,
            ),
            ContextMenuButtonItem(
              onPressed: () {
                launchUrl(Uri.parse(
                    'mailto:zmtzawqlp@live.com?subject=extended_text_share&body=${selectedContent?.plainText}'));
                selectableRegionState.hideToolbar();
              },
              type: ContextMenuButtonType.custom,
              label: 'like',
            ),
          ],
          anchors: selectableRegionState.contextMenuAnchors,
        );
        // return AdaptiveTextSelectionToolbar.selectableRegion(
        //   selectableRegionState: selectableRegionState,
        // );
      },
      // magnifierConfiguration: TextMagnifierConfiguration(
      //   magnifierBuilder: (
      //     BuildContext context,
      //     MagnifierController controller,
      //     ValueNotifier<MagnifierInfo> magnifierInfo,
      //   ) {
      //     return TextMagnifier(
      //       magnifierInfo: magnifierInfo,
      //     );
      //     // switch (defaultTargetPlatform) {
      //     //   case TargetPlatform.iOS:
      //     //     return CupertinoTextMagnifier(
      //     //       controller: controller,
      //     //       magnifierInfo: magnifierInfo,
      //     //     );
      //     //   case TargetPlatform.android:
      //     //     return TextMagnifier(
      //     //       magnifierInfo: magnifierInfo,
      //     //     );
      //     //   case TargetPlatform.fuchsia:
      //     //   case TargetPlatform.linux:
      //     //   case TargetPlatform.macOS:
      //     //   case TargetPlatform.windows:
      //     //     return null;
      //     // }
      //   },
      // ),
      // selectionControls: MyTextSelectionControls(),
      onSelectionChanged: (SelectedContent? value) {
        if (kDebugMode) {
          print(value?.plainText);
        }
        selectedContent = value;
      },
      child: child,
    );
  }
}
