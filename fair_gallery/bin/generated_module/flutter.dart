// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path/path.dart' as path;

import '../util/binding.dart';
import '../util/utils.dart';

// import 'package:flutter/widgets.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/semantics.dart';
// import 'package:flutter/animation.dart';
String _imports = '''
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
''';

String _codes = '''

const double _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;

const TextScaler _kUnspecifiedTextScaler = _UnspecifiedTextScaler();
// TODO(LongCatIsLooong): Remove once `MediaQueryData.textScaleFactor` is
// removed: https://github.com/flutter/flutter/issues/128825.
class _UnspecifiedTextScaler implements TextScaler {
  const _UnspecifiedTextScaler();

  @override
  TextScaler clamp({double minScaleFactor = 0, double maxScaleFactor = double.infinity}) => throw UnimplementedError();

  @override
  double scale(double fontSize) => throw UnimplementedError();

  @override
  double get textScaleFactor => throw UnimplementedError();
}


const double _kDefaultIndicatorRadius = 10.0;
const Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;
const Color _kDefaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x4C000000),
  darkColor: Color(0x29000000),
);

const double kMinInteractiveDimensionCupertino = 44.0;
const Color _kDefaultNavBarBorderColor = Color(0x4D000000);
const Border _kDefaultNavBarBorder = Border(
  bottom: BorderSide(
    color: _kDefaultNavBarBorderColor,
    width: 0.0, // One physical pixel.
    style: BorderStyle.solid,
  ),
);
const _defaultHeroTag = "";
const double _kDefaultDiameterRatio = 1.07;
const double _kSqueeze = 1.45;
const double _defaultRefreshTriggerPullDistance = 100.0;
const double _defaultRefreshIndicatorExtent = 60.0;
var buildRefreshIndicator = CupertinoSliverRefreshControl.buildRefreshIndicator;
const CupertinoDynamicColor _kThumbColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFFFFFFF),
  darkColor: Color(0xFF636366),
);
const EdgeInsetsGeometry _kHorizontalItemPadding =
    EdgeInsets.symmetric(vertical: 2, horizontal: 3);
const Color _kColor = Color(0xA0B71C1C);
const double _kHeight = 12.0; // height of banner
const TextStyle _kTextStyle = TextStyle(
  color: Color(0xFFFFFFFF),
  fontSize: _kHeight * 0.85,
  fontWeight: FontWeight.w900,
  height: 1.0,
);

class _DefaultHeroTag {
  const _DefaultHeroTag();
  @override
  String toString() => '<default FloatingActionButton tag>';
}

const int defaultRowsPerPage = 10;
const double _kMenuDividerHeight = 16.0;
const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);
const double kMiddleSpacing = 16.0;

double _inverseLerp(double min, double max, double t) {
  assert(min <= max);
  double value = (t - min) / (max - min);

  // If the device incorrectly reports a pressure outside of pressureMin
  // and pressureMax, we still want this recognizer to respond normally.
  if (!value.isNaN) {
    value = clampDouble(value, 0.0, 1.0);
  }
  return value;
}

const double _epsilonDefault = 1e-3;
const TextStyle _kDefaultPlaceholderStyle = TextStyle(
  fontWeight: FontWeight.w400,
  color: CupertinoColors.placeholderText,
);

// Builds a toolbar just like the default iOS toolbar, with the right color
// background and a rounded cutout with an arrow.
Widget _defaultToolbarBuilder(
    BuildContext context, Offset anchor, bool isAbove, Widget child) {
  return _CupertinoTextSelectionToolbarShape(
    anchor: anchor,
    isAbove: isAbove,
    child: DecoratedBox(
      decoration: const BoxDecoration(color: _kToolbarDividerColor),
      child: child,
    ),
  );
}

// Clips the child so that it has the shape of the default iOS text selection
// toolbar, with rounded corners and an arrow pointing at the anchor.
//
// The anchor should be in global coordinates.
class _CupertinoTextSelectionToolbarShape
    extends SingleChildRenderObjectWidget {
  const _CupertinoTextSelectionToolbarShape({
    required Offset anchor,
    required bool isAbove,
    super.child,
  })  : _anchor = anchor,
        _isAbove = isAbove;

  final Offset _anchor;

  // Whether the arrow should point down and be attached to the bottom
  // of the toolbar, or point up and be attached to the top of the toolbar.
  final bool _isAbove;

  @override
  _RenderCupertinoTextSelectionToolbarShape createRenderObject(
          BuildContext context) =>
      _RenderCupertinoTextSelectionToolbarShape(
        _anchor,
        _isAbove,
        null,
      );

  @override
  void updateRenderObject(BuildContext context,
      _RenderCupertinoTextSelectionToolbarShape renderObject) {
    renderObject
      ..anchor = _anchor
      ..isAbove = _isAbove;
  }
}

const Size _kToolbarArrowSize = Size(14.0, 7.0);

const Color _kToolbarDividerColor = Color(0xFF808080);

class _RenderCupertinoTextSelectionToolbarShape extends RenderShiftedBox {
  _RenderCupertinoTextSelectionToolbarShape(
    this._anchor,
    this._isAbove,
    RenderBox? child,
  ) : super(child);

  @override
  bool get isRepaintBoundary => true;

  Offset get anchor => _anchor;
  Offset _anchor;
  set anchor(Offset value) {
    if (value == _anchor) {
      return;
    }
    _anchor = value;
    markNeedsLayout();
  }

  bool get isAbove => _isAbove;
  bool _isAbove;
  set isAbove(bool value) {
    if (_isAbove == value) {
      return;
    }
    _isAbove = value;
    markNeedsLayout();
  }

  // The child is tall enough to have the arrow clipped out of it on both sides
  // top and bottom. Since _kToolbarHeight includes the height of one arrow, the
  // total height that the child is given is that plus one more arrow height.
  // The extra height on the opposite side of the arrow will be clipped out. By
  // using this approach, the buttons don't need any special padding that
  // depends on isAbove.
  final BoxConstraints _heightConstraint = BoxConstraints.tightFor(
    height: _kToolbarHeight + _kToolbarArrowSize.height,
  );

  @override
  void performLayout() {
    if (child == null) {
      return;
    }

    final BoxConstraints enforcedConstraint = constraints.loosen();

    child!.layout(_heightConstraint.enforce(enforcedConstraint),
        parentUsesSize: true);

    // The height of one arrow will be clipped off of the child, so adjust the
    // size and position to remove that piece from the layout.
    final BoxParentData childParentData = child!.parentData! as BoxParentData;
    childParentData.offset = Offset(
      0.0,
      _isAbove ? -_kToolbarArrowSize.height : 0.0,
    );
    size = Size(
      child!.size.width,
      child!.size.height - _kToolbarArrowSize.height,
    );
  }

  // The path is described in the toolbar's coordinate system.
  Path _clipPath() {
    final BoxParentData childParentData = child!.parentData! as BoxParentData;
    final Path rrect = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset(0.0, _kToolbarArrowSize.height) &
              Size(
                child!.size.width,
                child!.size.height - _kToolbarArrowSize.height * 2,
              ),
          _kToolbarBorderRadius,
        ),
      );

    final Offset localAnchor = globalToLocal(_anchor);
    final double centerX = childParentData.offset.dx + child!.size.width / 2;
    final double arrowXOffsetFromCenter = localAnchor.dx - centerX;
    final double arrowTipX = child!.size.width / 2 + arrowXOffsetFromCenter;

    final double arrowBaseY = _isAbove
        ? child!.size.height - _kToolbarArrowSize.height
        : _kToolbarArrowSize.height;

    final double arrowTipY = _isAbove ? child!.size.height : 0;

    final Path arrow = Path()
      ..moveTo(arrowTipX, arrowTipY)
      ..lineTo(arrowTipX - _kToolbarArrowSize.width / 2, arrowBaseY)
      ..lineTo(arrowTipX + _kToolbarArrowSize.width / 2, arrowBaseY)
      ..close();

    return Path.combine(PathOperation.union, rrect, arrow);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }

    final BoxParentData childParentData = child!.parentData! as BoxParentData;
    _clipPathLayer.layer = context.pushClipPath(
      needsCompositing,
      offset + childParentData.offset,
      Offset.zero & child!.size,
      _clipPath(),
      (PaintingContext innerContext, Offset innerOffset) =>
          innerContext.paintChild(child!, innerOffset),
      oldLayer: _clipPathLayer.layer,
    );
  }

  final LayerHandle<ClipPathLayer> _clipPathLayer =
      LayerHandle<ClipPathLayer>();
  Paint? _debugPaint;

  @override
  void dispose() {
    _clipPathLayer.layer = null;
    super.dispose();
  }

  @override
  void debugPaintSize(PaintingContext context, Offset offset) {
    assert(() {
      if (child == null) {
        return true;
      }

      _debugPaint ??= Paint()
        ..shader = ui.Gradient.linear(
          Offset.zero,
          const Offset(10.0, 10.0),
          const <Color>[
            Color(0x00000000),
            Color(0xFFFF00FF),
            Color(0xFFFF00FF),
            Color(0x00000000)
          ],
          const <double>[0.25, 0.25, 0.75, 0.75],
          TileMode.repeated,
        )
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      context.canvas.drawPath(
          _clipPath().shift(offset + childParentData.offset), _debugPaint!);
      return true;
    }());
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // Positions outside of the clipped area of the child are not counted as
    // hits.
    final BoxParentData childParentData = child!.parentData! as BoxParentData;
    final Rect hitBox = Rect.fromLTWH(
      childParentData.offset.dx,
      childParentData.offset.dy + _kToolbarArrowSize.height,
      child!.size.width,
      child!.size.height - _kToolbarArrowSize.height * 2,
    );
    if (!hitBox.contains(position)) {
      return false;
    }

    return super.hitTestChildren(result, position: position);
  }
}

// Values extracted from https://developer.apple.com/design/resources/.
// The height of the toolbar, including the arrow.
const double _kToolbarHeight = 43.0;

// Values extracted from https://developer.apple.com/design/resources/.
const Radius _kToolbarBorderRadius = Radius.circular(8);

// Standard iOS 10 tab bar height.
const double _kTabBarHeight = 50.0;


/// Default value for [thickness] if it's not specified in [CupertinoScrollbar].
const double defaultThickness = 3;

/// Default value for [thicknessWhileDragging] if it's not specified in
/// [CupertinoScrollbar].
const double defaultThicknessWhileDragging = 8.0;

/// Default value for [radius] if it's not specified in [CupertinoScrollbar].
const Radius defaultRadius = Radius.circular(1.5);

/// Default value for [radiusWhileDragging] if it's not specified in
/// [CupertinoScrollbar].
const Radius defaultRadiusWhileDragging = Radius.circular(4.0);
mixin _ScrollUnderFlexibleConfig {
  TextStyle? get collapsedTextStyle;
  TextStyle? get expandedTextStyle;
  EdgeInsetsGeometry? get collapsedTitlePadding;
  EdgeInsetsGeometry? get collapsedCenteredTitlePadding;
  EdgeInsetsGeometry? get expandedTitlePadding;
}

// Variant configuration
class _MediumScrollUnderFlexibleConfig with _ScrollUnderFlexibleConfig {
  _MediumScrollUnderFlexibleConfig(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colors = _theme.colorScheme;
  late final TextTheme _textTheme = _theme.textTheme;

  static const double collapsedHeight = 64.0;

  @override
  TextStyle? get collapsedTextStyle =>
      _textTheme.titleLarge?.apply(color: _colors.onSurface);

  @override
  TextStyle? get expandedTextStyle =>
      _textTheme.headlineSmall?.apply(color: _colors.onSurface);

  @override
  EdgeInsetsGeometry? get collapsedTitlePadding =>
      const EdgeInsetsDirectional.fromSTEB(48, 0, 16, 0);

  @override
  EdgeInsetsGeometry? get collapsedCenteredTitlePadding =>
      const EdgeInsets.fromLTRB(16, 0, 16, 0);

  @override
  EdgeInsetsGeometry? get expandedTitlePadding =>
      const EdgeInsets.fromLTRB(16, 0, 16, 20);
}

class _LargeScrollUnderFlexibleConfig with _ScrollUnderFlexibleConfig {
  _LargeScrollUnderFlexibleConfig(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colors = _theme.colorScheme;
  late final TextTheme _textTheme = _theme.textTheme;

  static const double collapsedHeight = 64.0;

  @override
  TextStyle? get collapsedTextStyle =>
      _textTheme.titleLarge?.apply(color: _colors.onSurface);

  @override
  TextStyle? get expandedTextStyle =>
      _textTheme.headlineMedium?.apply(color: _colors.onSurface);

  @override
  EdgeInsetsGeometry? get collapsedTitlePadding =>
      const EdgeInsetsDirectional.fromSTEB(48, 0, 16, 0);

  @override
  EdgeInsetsGeometry? get collapsedCenteredTitlePadding =>
      const EdgeInsets.fromLTRB(16, 0, 16, 0);

  @override
  EdgeInsetsGeometry? get expandedTitlePadding =>
      const EdgeInsets.fromLTRB(16, 0, 16, 28);
}

Widget _defaultFieldViewBuilder(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted) {
  return _AutocompleteField(
    focusNode: focusNode,
    textEditingController: textEditingController,
    onFieldSubmitted: onFieldSubmitted,
  );
}

// The default Material-style Autocomplete text field.
class _AutocompleteField extends StatelessWidget {
  const _AutocompleteField({
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
  });

  final FocusNode focusNode;

  final VoidCallback onFieldSubmitted;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }
}

/// Default stroke width.
const double defaultStrokeWidth = 2.5;
const double _kMinThumbExtent = 18.0;
const double _kScrollbarThickness = 6.0;
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);
const Set<TargetPlatform> _kMobilePlatforms = <TargetPlatform>{
  TargetPlatform.android,
  TargetPlatform.iOS,
  TargetPlatform.fuchsia,
};

/// The default way to convert an option to a string in
/// [displayStringForOption].
///
/// Simply uses the `toString` method on the option.
String defaultStringForOption(dynamic option) {
  return option.toString();
}

const int _kColorDefault = 0xFF000000;
Widget _buildCupertinoDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  final CurvedAnimation fadeAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
  );
  if (animation.status == AnimationStatus.reverse) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );
  }
  return FadeTransition(
    opacity: fadeAnimation,
    child: ScaleTransition(
      scale: animation.drive(_dialogScaleTween),
      child: child,
    ),
  );
}

const List<BoxShadow> _kSwitchBoxShadows = <BoxShadow>[
  BoxShadow(
    color: Color(0x26000000),
    offset: Offset(0, 3),
    blurRadius: 8.0,
  ),
  BoxShadow(
    color: Color(0x0F000000),
    offset: Offset(0, 3),
    blurRadius: 1.0,
  ),
];

const List<BoxShadow> _kSliderBoxShadows = <BoxShadow>[
  BoxShadow(
    color: Color(0x26000000),
    offset: Offset(0, 3),
    blurRadius: 8.0,
  ),
  BoxShadow(
    color: Color(0x29000000),
    offset: Offset(0, 1),
    blurRadius: 1.0,
  ),
  BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 3),
    blurRadius: 1.0,
  ),
];

const Map<TargetPlatform, PageTransitionsBuilder> _defaultBuilders =
    <TargetPlatform, PageTransitionsBuilder>{
  TargetPlatform.android: ZoomPageTransitionsBuilder(),
  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
};

const Duration _kDefaultHighlightFadeDuration = Duration(milliseconds: 200);

// An eyeballed value for a smooth scrolling experience.
const double _kDefaultAutoScrollVelocityScalar = 7;
// The curve and initial scale values were mostly eyeballed from iOS, however
// they reuse the same animation curve that was modeled after native page
// transitions.
final Animatable<double> _dialogScaleTween = Tween<double>(begin: 1.3, end: 1.0)
    .chain(CurveTween(curve: Curves.linearToEaseOut));

// Modifier key masks.

/// No modifier keys are pressed in the [metaState] field.
///
/// Use this value if you need to decode the [metaState] field yourself, but
/// it's much easier to use [isModifierPressed] if you just want to know if
/// a modifier is pressed.
const int modifierNone = 0;
Widget _defaultTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return child;
}

NavigatorState _defaultNavigatorFinder(BuildContext context) =>
    Navigator.of(context);
int _kDefaultSemanticIndexCallback(Widget _, int localIndex) => localIndex;
const BoxDecoration _kDefaultRoundedBorderDecoration = BoxDecoration(
  color: CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.white,
    darkColor: CupertinoColors.black,
  ),
  border: _kDefaultRoundedBorder,
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);
// Value inspected from Xcode 11 & iOS 13.0 Simulator.
const BorderSide _kDefaultRoundedBorderSide = BorderSide(
  color: CupertinoDynamicColor.withBrightness(
    color: Color(0x33000000),
    darkColor: Color(0x33FFFFFF),
  ),
  width: 0.0,
);
const Border _kDefaultRoundedBorder = Border(
  top: _kDefaultRoundedBorderSide,
  bottom: _kDefaultRoundedBorderSide,
  left: _kDefaultRoundedBorderSide,
  right: _kDefaultRoundedBorderSide,
);
  /// The border is drawn fully inside of the border path.
  ///
  /// This is a constant for use with [strokeAlign].
  ///
  /// This is the default value for [strokeAlign].
  const double strokeAlignInside = -1.0;
  /// The indicator stroke is drawn on the center of the indicator path,
  /// with half of the [strokeWidth] on the inside, and the other half
  /// on the outside of the path.
  ///
  /// This is a constant for use with [strokeAlign].
  ///
  /// This is the default value for [strokeAlign].
  const double strokeAlignCenter = 0.0;  
  // The ratio for the borderRadius of the context menu preview image. This value
  // was eyeballed by overlapping the CupertinoContextMenu with a context menu
  // from iOS 16.0 in the XCode iPhone simulator.
  const double _previewBorderRadiusRatio = 12.0;
  /// The default preview builder if none is provided. It makes a rectangle
  /// around the child widget with rounded borders, matching the iOS 16 opened
  /// context menu eyeballed on the XCode iOS simulator.
   Widget _defaultPreviewBuilder(BuildContext context, Animation<double> animation, Widget child) {
    return FittedBox(
      fit: BoxFit.cover,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_previewBorderRadiusRatio * animation.value),
        child: child,
      ),
    );
  }
  // Values derived from https://developer.apple.com/design/resources/ and on iOS
  // simulators with "Debug View Hierarchy".
  const double _kItemExtent = 32.0;

// Margin on top of the list section. This was eyeballed from iOS 14.4 Simulator
// and should be always present on top of the edge-to-edge variant.
const double _kMarginTop = 22.0;

// Standard header margin, determined from SwiftUI's Forms in iOS 14.2 SDK.
const EdgeInsetsDirectional _kDefaultHeaderMargin = EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 6.0);

// Header margin for inset grouped variant, determined from iOS 14.4 Simulator.
const EdgeInsetsDirectional _kInsetGroupedDefaultHeaderMargin = EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 6.0);

// Standard footer margin, determined from SwiftUI's Forms in iOS 14.2 SDK.
const EdgeInsetsDirectional _kDefaultFooterMargin = EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0);

// Footer margin for inset grouped variant, determined from iOS 14.4 Simulator.
const EdgeInsetsDirectional _kInsetGroupedDefaultFooterMargin = EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 10.0);

// Margin around children in edge-to-edge variant, determined from iOS 14.4
// Simulator.
const EdgeInsets _kDefaultRowsMargin = EdgeInsets.only(bottom: 8.0);

// Used for iOS "Inset Grouped" margin, determined from SwiftUI's Forms in
// iOS 14.2 SDK.
const EdgeInsetsDirectional _kDefaultInsetGroupedRowsMargin = EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 10.0);

// Used for iOS "Inset Grouped" margin, determined from SwiftUI's Forms in
// iOS 14.2 SDK.
const EdgeInsetsDirectional _kDefaultInsetGroupedRowsMarginWithHeader = EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 10.0);

// Used for iOS "Inset Grouped" border radius, estimated from SwiftUI's Forms in
// iOS 14.2 SDK.
// TODO(edrisian): This should be a rounded rectangle once that shape is added.
const BorderRadius _kDefaultInsetGroupedBorderRadius = BorderRadius.all(Radius.circular(10.0));

// The margin of divider used in base list section. Estimated from iOS 14.4 SDK
// Settings app.
const double _kBaseDividerMargin = 20.0;

// Additional margin of divider used in base list section with list tiles with
// leading widgets. Estimated from iOS 14.4 SDK Settings app.
const double _kBaseAdditionalDividerMargin = 44.0;

// The margin of divider used in inset grouped version of list section.
// Estimated from iOS 14.4 SDK Reminders app.
const double _kInsetDividerMargin = 14.0;

// Additional margin of divider used in inset grouped version of list section.
// Estimated from iOS 14.4 SDK Reminders app.
const double _kInsetAdditionalDividerMargin = 42.0;

// Additional margin of divider used in inset grouped version of list section
// when there is no leading widgets. Estimated from iOS 14.4 SDK Notes app.
const double _kInsetAdditionalDividerMarginWithoutLeading = 14.0;

// Used for iOS "Inset Grouped" margin, determined from SwiftUI's Forms in
// iOS 14.2 SDK.
const EdgeInsetsDirectional _kFormDefaultInsetGroupedRowsMargin = EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 10.0);
// These constants were eyeballed from iOS 14.4 Settings app for base, Notes for
// notched without leading, and Reminders app for notched with leading.
const double _kLeadingSize = 28.0;
const double _kNotchedLeadingSize = 30.0;
const double _kMinHeight = _kLeadingSize + 2 * 8.0;
const double _kMinHeightWithSubtitle = _kLeadingSize + 2 * 10.0;
const double _kNotchedMinHeight = _kNotchedLeadingSize + 2 * 12.0;
const double _kNotchedMinHeightWithoutLeading = _kNotchedLeadingSize + 2 * 10.0;
const EdgeInsetsDirectional _kPadding = EdgeInsetsDirectional.only(start: 20.0, end: 14.0);
const EdgeInsetsDirectional _kPaddingWithSubtitle = EdgeInsetsDirectional.only(start: 20.0, end: 14.0);
const EdgeInsets _kNotchedPadding = EdgeInsets.symmetric(horizontal: 14.0);
const EdgeInsetsDirectional _kNotchedPaddingWithoutLeading = EdgeInsetsDirectional.fromSTEB(28.0, 10.0, 14.0, 10.0);
const double _kLeadingToTitle = 16.0;
const double _kNotchedLeadingToTitle = 12.0;
const double _kNotchedTitleToSubtitle = 3.0;
const double _kAdditionalInfoToTrailing = 6.0;
const double _kNotchedTitleWithSubtitleFontSize = 16.0;
const double _kSubtitleFontSize = 12.0;
const double _kNotchedSubtitleFontSize = 14.0;
const Size kDefaultSize = Size(80, 47.5);
  // Used as the coefficient of friction in the inertial translation animation.
  // This value was eyeballed to give a feel similar to Google Photos.
  const double _kDrag = 0.0000135;
  const double _borderRadius = 40; 
 Widget defaultLabelBuilder(
    BuildContext context,
    String label,
    int index,
  ) {
    if (index < 0) {
      return Text(label);
    }
    final TextStyle defaultStyle = DefaultTextStyle.of(context).style;
    final Characters characters = label.characters;
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          if (index > 0)
            TextSpan(text: characters.getRange(0, index).toString(), style: defaultStyle),
          TextSpan(
            text: characters.getRange(index, index + 1).toString(),
            style: defaultStyle.copyWith(decoration: TextDecoration.underline),
          ),
          if (index < characters.length - 1)
            TextSpan(text: characters.getRange(index + 1).toString(), style: defaultStyle),
        ],
      ),
    );
  }  
const double _kIndicatorHeight = 32;
const double _kIndicatorWidth = 64;  

Widget _defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
  return AdaptiveTextSelectionToolbar.editableText(
    editableTextState: editableTextState,
  );
}

Widget _defaultCupertinoContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
  return CupertinoAdaptiveTextSelectionToolbar.editableText(
    editableTextState: editableTextState,
  );
}

class _DefaultSnapshotPainter implements SnapshotPainter {
  const _DefaultSnapshotPainter();

  @override
  void addListener(ui.VoidCallback listener) { }

  @override
  void dispose() { }

  @override
  bool get hasListeners => false;

  @override
  void notifyListeners() { }

  @override
  void paint(PaintingContext context, ui.Offset offset, ui.Size size, PaintingContextCallback painter) {
    painter(context, offset);
  }

  @override
  void paintSnapshot(PaintingContext context, ui.Offset offset, ui.Size size, ui.Image image, Size sourceSize, double pixelRatio) {
    final Rect src = Rect.fromLTWH(0, 0, sourceSize.width, sourceSize.height);
    final Rect dst = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
    final Paint paint = Paint()
      ..filterQuality = FilterQuality.low;
    context.canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  void removeListener(ui.VoidCallback listener) { }

  @override
  bool shouldRepaint(covariant _DefaultSnapshotPainter oldPainter) => false;
}


''';

Map<String, String> _fixes = <String, String>{
  ' DiagnosticableNode(': ' DiagnosticableNode<Diagnosticable>(',
  ' HitTestEntry(': ' HitTestEntry<HitTestTarget>(',
  ' RenderAnnotatedRegion(': ' RenderAnnotatedRegion<Object>(',
  ' LayerHandle(': ' LayerHandle<Layer>(',
  ' AnnotatedRegionLayer(': ' AnnotatedRegionLayer<Object>(',
  ' Actions.handler(': ' Actions.handler<Intent>(',
  ' Actions.find(': ' Actions.find<Intent>(',
  ' Actions.maybeFind(': ' Actions.maybeFind<Intent>(',
  ' Actions.maybeInvoke(': ' Actions.maybeInvoke<Intent>(',
  'Actions.invoke(': 'Actions.invoke<Intent>(',
  ' AnnotatedRegion(': ' AnnotatedRegion<Object>(',
  ' SharedAppData.getValue(': ' SharedAppData.getValue<Object, dynamic>(',
  ' SharedAppData.setValue(': ' SharedAppData.setValue<Object, dynamic>(',
  'children: as<List>(props[\'children\'])':
      'children: as<List<RenderBox>>(props[\'children\'])',
  ' KeySet(': ' KeySet<KeyboardKey>(',
  ' IndexedSlot(': ' IndexedSlot<Element?>(',
  ' DisposableBuildContext(': ' DisposableBuildContext<State>(',
  ' RestorableNumN(': ' RestorableNumN<num?>(',
  ' RestorableNum(': ' RestorableNum<num>(',
  '?? null': '',
  '''import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;''': '',
  ''''BackgroundIsolateBinaryMessenger': (props) =>
      BackgroundIsolateBinaryMessenger(),''': '',
  '''  'DomCSSStyleDeclaration': (props) => DomCSSStyleDeclaration(),
  'DomCSSStyleSheet': (props) => DomCSSStyleSheet(),
  'DomDocument': (props) => DomDocument(),
  'DomElement': (props) => DomElement(),
  'DomEvent': (props) => DomEvent(),
  'DomEventListener': (props) => DomEventListener(),
  'DomEventTarget': (props) => DomEventTarget(),
  'DomHTMLDivElement': (props) => DomHTMLDivElement(),
  'DomHTMLElement': (props) => DomHTMLElement(),
  'DomHTMLHeadElement': (props) => DomHTMLHeadElement(),
  'DomHTMLStyleElement': (props) => DomHTMLStyleElement(),
  'DomMediaQueryList': (props) => DomMediaQueryList(),
  'DomMouseEvent': (props) => DomMouseEvent(),
  'DomNavigator': (props) => DomNavigator(),
  'DomNode': (props) => DomNode(),
  'DomProgressEvent': (props) => DomProgressEvent(),
  'DomRange': (props) => DomRange(),
  'DomSelection': (props) => DomSelection(),
  'DomStyleSheet': (props) => DomStyleSheet(),
  'DomTokenList': (props) => DomTokenList(),
  'DomUIEvent': (props) => DomUIEvent(),
  'DomWindow': (props) => DomWindow(),
  'DomXMLHttpRequest': (props) => DomXMLHttpRequest(),''': '',
  '''  'Image.onCreate': Image.onCreate,
  'Image.onDispose': Image.onDispose,''': '',
  '''as<List<RenderBox>>(props['children']) ?? const []),''':
      '''as<List<Widget>>(props['children']) ?? const []),''',
};

void main(List<String> args) async {
  Directory projectDirectory = getProjectDirectory();

  final File dartRunFile = File(Platform.executable);
  var cacheDirectory = dartRunFile.parent;
  while (!cacheDirectory.path.endsWith('cache')) {
    cacheDirectory = cacheDirectory.parent;
  }

  var flutterDirectory = cacheDirectory.parent.parent;

  // 把 flutter 源码复制到 .dart_tool下面，不然 analyzer 会有bug

  copyAndPackageGet(
    projectDirectory: projectDirectory,
    packageName: 'flutter',
    copyForm: path.join(
      flutterDirectory.path,
      'packages',
      'flutter/',
    ),
  );

  // 把 dart 源码复制到 .dart_tool下面，不然 analyzer 会有bug
  copyAndPackageGet(
    projectDirectory: projectDirectory,
    packageName: 'sky_engine',
    copyForm: path.join(
      cacheDirectory.path,
      'pkg',
      'sky_engine/',
    ),
  );

  await createBindings(
    componentSkips: {
      // dart:ui 里面的
      'Gradient.linear',
      'Gradient.radial',
      'Gradient.sweep',
      '^Restorable.*',
      'BackgroundIsolateBinaryMessenger.instance',
      'BaseTapAndDragGestureRecognizer',
      'BindingBase.checkInstance',
      'EnumProperty',

      // 支持正则
      // '^Icons.*',
      // '^Diagnostic*',
      // '^Render*',
      // '^CupertinoIcons.*',
      // '^RawKeyEventDataMacOs.*',
      // '^RawKeyEventDataWeb.*',
      // '^RawKeyEventDataWindows.*',
      // '^RawKeyEventDataFuchsia.*',
    },
    projectDirectory: projectDirectory,
    includedPaths: [
      path.join(
        projectDirectory.path,
        '.dart_tool',
        'flutter',
        'lib',
      ),
      path.join(
        projectDirectory.path,
        '.dart_tool',
        'sky_engine',
        'lib',
        'ui',
      ),
      path.join(
        projectDirectory.path,
        '.dart_tool',
        'sky_engine',
        'lib',
        'core',
        'date_time.dart',
      ),
      path.join(
        projectDirectory.path,
        '.dart_tool',
        'sky_engine',
        'lib',
        'core',
        'duration.dart',
      ),
    ],
    fileName: 'Flutter',

    imports: _imports,
    codes: _codes,
    fixes: _fixes,
    functionDomainImports: '''
import 'dart:ui';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' show Quad;
''',
    functionDomainFixes: {
      'T Function()': 'GestureRecognizer Function()',
      'T? Function()': 'dynamic Function()',
      'V Function()': 'dynamic Function()',
      'Widget? Function(BuildContext, {required int currentLength, required bool isFocused, required int? maxLength})':
          'Widget? Function(BuildContext, {required int currentLength, required int? maxLength, required bool isFocused})',
      'bool Function(T?, T)': 'bool Function(dynamic, dynamic)',
      'T? Function(T?, T?, double)':
          'dynamic Function(dynamic, dynamic, double)',
      'T Function(Set<MaterialState>)': 'dynamic Function(Set<MaterialState>)',
      'T Function(Set<WidgetState>)': 'dynamic Function(Set<WidgetState>)',
    },
    // FunctionType 的 fullElement
    // 有些是不会用的，特别是一些泛型
    functionDomainSkips: {},
  );

  // dartFix();
}
