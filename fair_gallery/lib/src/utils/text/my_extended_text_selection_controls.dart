import 'dart:math' as math;
import 'package:fair_gallery/assets.dart';
import 'package:flutter/material.dart';

///
///  create by zmtzawqlp on 2019/8/3
///

const double _kHandleSize = 22.0;

/// Android Material styled text selection controls.

class MyTextSelectionControls extends TextSelectionControls
    with TextSelectionHandleControls {
  MyTextSelectionControls({this.joinZeroWidthSpace = false});
  final bool joinZeroWidthSpace;

  /// Returns the size of the Material handle.
  @override
  Size getHandleSize(double textLineHeight) =>
      const Size(_kHandleSize, _kHandleSize);

  /// Builder for material-style text selection handles.
  @override
  Widget buildHandle(
      BuildContext context, TextSelectionHandleType type, double textLineHeight,
      [VoidCallback? onTap, double? startGlyphHeight, double? endGlyphHeight]) {
    final Widget handle = SizedBox(
      width: _kHandleSize,
      height: _kHandleSize,
      child: Image.asset(
        Assets.assets_image_40_png,
      ),
    );

    // [handle] is a circle, with a rectangle in the top left quadrant of that
    // circle (an onion pointing to 10:30). We rotate [handle] to point
    // straight up or up-right depending on the handle type.
    switch (type) {
      case TextSelectionHandleType.left: // points up-right
        return Transform.rotate(
          angle: math.pi / 4.0,
          child: handle,
        );
      case TextSelectionHandleType.right: // points up-left
        return Transform.rotate(
          angle: -math.pi / 4.0,
          child: handle,
        );
      case TextSelectionHandleType.collapsed: // points up
        return handle;
    }
  }

  /// Gets anchor for material-style text selection handles.
  ///
  /// See [TextSelectionControls.getHandleAnchor].
  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight,
      [double? startGlyphHeight, double? endGlyphHeight]) {
    switch (type) {
      case TextSelectionHandleType.left:
        return const Offset(_kHandleSize, 0);
      case TextSelectionHandleType.right:
        return Offset.zero;
      default:
        return const Offset(_kHandleSize / 2, -4);
    }
  }
}
