import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/styled_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A card that defaults to theme.surface1, and has a built in shadow and rounded corners.
class StyledCard extends StatelessWidget {
  final Color? bgColor;
  final bool enableShadow;
  final Widget? child;
  final VoidCallback? onPressed;
  final Alignment? align;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? borderRadius;

  const StyledCard(
      {Key? key,
      this.bgColor,
      this.enableShadow = true,
      this.child,
      this.onPressed,
      this.align,
      this.decoration,
      this.foregroundDecoration,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    Color c = bgColor ?? theme.surface;

    Widget content = StyledContainer(
      c,
      align: align,
      child: child,
      borderRadius: BorderRadius.circular(borderRadius ?? Corners.s8),
      shadows: enableShadow ? Shadows.m(theme.accent1Darker) : null,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
    );

    if (onPressed != null)
      return TransparentBtn(
        child: content,
        onPressed: onPressed,
        contentPadding: EdgeInsets.zero,
        borderRadius: borderRadius ?? Corners.s8,
      );
    return content;
  }
}
