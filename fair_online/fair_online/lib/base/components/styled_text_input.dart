import 'dart:async';
import 'dart:math' as math;

import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class StyledFormTextInput extends StatelessWidget {
  static const EdgeInsets kDefaultTextInputPadding =
      EdgeInsets.symmetric(vertical: Insets.m, horizontal: Insets.m);

  final String label;
  final bool autoFocus;
  final String? initialValue;
  final String hintText;
  final EdgeInsets contentPadding;
  final TextStyle? textStyle;
  final int? maxLines;
  final TextEditingController? controller;
  final TextCapitalization capitalization;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final void Function(bool)? onFocusChanged;
  final void Function(FocusNode)? onFocusCreated;

  const StyledFormTextInput(
      {Key? key,
      this.label = "",
      this.autoFocus = false,
      this.initialValue,
      this.onChanged,
      this.onEditingComplete,
      this.hintText = "",
      this.onFocusChanged,
      this.onFocusCreated,
      this.controller,
      this.contentPadding = kDefaultTextInputPadding,
      this.capitalization = TextCapitalization.none,
      this.textStyle,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return StyledSearchTextInput(
      capitalization: capitalization,
      label: label,
      autoFocus: autoFocus,
      initialValue: initialValue,
      onChanged: onChanged,
      onFocusCreated: onFocusCreated,
      style: textStyle ?? TextStyles.Body1,
      onEditingComplete: onEditingComplete,
      onFocusChanged: onFocusChanged,
      controller: controller,
      maxLines: maxLines,
      inputDecoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Corners.s5Radius),
          borderSide: BorderSide(
            color: ColorUtils.shiftHsl(theme.divider, .2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Corners.s5Radius),
          borderSide: BorderSide(
            color: ColorUtils.shiftHsl(theme.divider, .2),
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Corners.s5Radius),
          borderSide: BorderSide(
            color: ColorUtils.shiftHsl(theme.divider, .2),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Corners.s5Radius),
          borderSide: BorderSide(
            color: ColorUtils.shiftHsl(theme.divider, .2),
            width: 1,
          ),
        ),
        hintText: hintText,
      ),
    );
  }
}

class StyledSearchTextInput extends StatefulWidget {
  final String label;
  final TextStyle? style;
  final EdgeInsets contentPadding;
  final bool autoFocus;
  final bool obscureText;
  final IconData? icon;
  final String? initialValue;
  final int? maxLines;
  final TextEditingController? controller;
  final TextCapitalization capitalization;
  final TextInputType type;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final bool enableSuggestions;
  final bool autoCorrect;
  final String? errorText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputDecoration? inputDecoration;

  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onEditingCancel;
  final void Function(bool)? onFocusChanged;
  final void Function(FocusNode)? onFocusCreated;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final VoidCallback? onTap;

  const StyledSearchTextInput({
    Key? key,
    this.label = "",
    this.autoFocus = false,
    this.obscureText = false,
    this.type = TextInputType.text,
    this.icon,
    this.initialValue,
    this.controller,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.enableSuggestions = true,
    this.autoCorrect = true,
    this.errorText,
    this.style,
    this.contentPadding = const EdgeInsets.all(Insets.m),
    this.prefixIcon,
    this.suffixIcon,
    this.inputDecoration,
    this.onChanged,
    this.onEditingComplete,
    this.onEditingCancel,
    this.onFocusChanged,
    this.onFocusCreated,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.hintText,
    this.capitalization = TextCapitalization.none,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  StyledSearchTextInputState createState() => StyledSearchTextInputState();
}

class StyledSearchTextInputState extends State<StyledSearchTextInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode(
      debugLabel: widget.label,
      onKey: (FocusNode node, RawKeyEvent evt) {
        if (evt is RawKeyDownEvent) {
          if (evt.logicalKey == LogicalKeyboardKey.escape) {
            widget.onEditingCancel?.call();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      canRequestFocus: true,
    );
    // Listen for focus out events
    _focusNode
        .addListener(() => widget.onFocusChanged?.call(_focusNode.hasFocus));
    widget.onFocusCreated?.call(_focusNode);
    if (widget.autoFocus) {
      scheduleMicrotask(() => _focusNode.requestFocus());
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant StyledSearchTextInput oldWidget) {
    if (oldWidget.controller?.text != widget.controller?.text) {
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void clear() => _controller.clear();

  String get text => _controller.text;

  set text(String value) => _controller.text = value;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
      padding: EdgeInsets.symmetric(vertical: Insets.sm),
      child: TextFormField(
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        onTap: widget.onTap,
        autofocus: widget.autoFocus,
        focusNode: _focusNode,
        keyboardType: widget.type,
        obscureText: widget.obscureText,
        autocorrect: widget.autoCorrect,
        autovalidateMode: widget.autovalidateMode,
        enableSuggestions: widget.enableSuggestions,
        style: widget.style ?? TextStyles.Body1,
        cursorColor: theme.accent1,
        controller: _controller,
        showCursor: true,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        textCapitalization: widget.capitalization,
        decoration: widget.inputDecoration ??
            InputDecoration(
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                contentPadding: widget.contentPadding,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                isDense: true,
                icon: widget.icon == null ? null : Icon(widget.icon),
                errorText: widget.errorText,
                errorMaxLines: 2,
                hintText: widget.hintText,
                hintStyle: TextStyles.Body1.textColor(theme.grey),
                labelText: widget.label),
      ),
    );
  }
}

class ThinUnderlineBorder extends InputBorder {
  /// Creates an underline border for an [InputDecorator].
  ///
  /// The [borderSide] parameter defaults to [BorderSide.none] (it must not be
  /// null). Applications typically do not specify a [borderSide] parameter
  /// because the input decorator substitutes its own, using [copyWith], based
  /// on the current theme and [InputDecorator.isFocused].
  ///
  /// The [borderRadius] parameter defaults to a value where the top left
  /// and right corners have a circular radius of 4.0. The [borderRadius]
  /// parameter must not be null.
  const ThinUnderlineBorder({
    BorderSide borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
  }) : super(borderSide: borderSide);

  /// The radii of the border's rounded rectangle corners.
  ///
  /// When this border is used with a filled input decorator, see
  /// [InputDecoration.filled], the border radius defines the shape
  /// of the background fill as well as the bottom left and right
  /// edges of the underline itself.
  ///
  /// By default the top right and top left corners have a circular radius
  /// of 4.0.
  final BorderRadius borderRadius;

  @override
  bool get isOutline => false;

  @override
  UnderlineInputBorder copyWith(
      {BorderSide? borderSide, BorderRadius? borderRadius}) {
    return UnderlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.only(bottom: borderSide.width);
  }

  @override
  UnderlineInputBorder scale(double t) {
    return UnderlineInputBorder(borderSide: borderSide.scale(t));
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRect(Rect.fromLTWH(rect.left, rect.top, rect.width,
          math.max(0.0, rect.height - borderSide.width)));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    final ShapeBorder? shape = a;
    if (shape is UnderlineInputBorder) {
      return UnderlineInputBorder(
        borderSide: BorderSide.lerp(shape.borderSide, borderSide, t),
        borderRadius: BorderRadius.lerp(shape.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    final ShapeBorder? shape = b;
    if (shape is UnderlineInputBorder) {
      return UnderlineInputBorder(
        borderSide: BorderSide.lerp(borderSide, shape.borderSide, t),
        borderRadius: BorderRadius.lerp(borderRadius, shape.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  /// Draw a horizontal line at the bottom of [rect].
  ///
  /// The [borderSide] defines the line's color and weight. The `textDirection`
  /// `gap` and `textDirection` parameters are ignored.
  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    print("Width: ${borderSide.width}");
    if (borderRadius.bottomLeft != Radius.zero ||
        borderRadius.bottomRight != Radius.zero)
      canvas.clipPath(getOuterPath(rect, textDirection: textDirection));
    canvas.drawLine(rect.bottomLeft, rect.bottomRight, borderSide.toPaint());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is InputBorder && other.borderSide == borderSide;
  }

  @override
  int get hashCode => borderSide.hashCode;
}
