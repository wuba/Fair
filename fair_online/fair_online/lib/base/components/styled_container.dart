import 'package:fair_online/app/styles.dart';
import 'package:flutter/material.dart';

/// A container that will animate when you change colors.
class StyledContainer extends StatelessWidget {
  final Color color;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? shadows;
  final Widget? child;
  final double? width;
  final double? height;
  final Alignment? align;
  final EdgeInsets? margin;
  final Duration duration;
  final BoxBorder? border;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;

  const StyledContainer(this.color,
      {Key? key,
      this.borderRadius,
      this.shadows,
      this.child,
      this.width,
      this.height,
      this.align,
      this.margin,
      this.duration = Durations.medium,
      this.border,
      this.decoration,
      this.foregroundDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      child: child,
      margin: margin,
      alignment: align,
      duration: duration,
      decoration: this.decoration ??
          BoxDecoration(
              color: color,
              borderRadius: borderRadius,
              boxShadow: shadows,
              border: border),
      foregroundDecoration: foregroundDecoration,
    );
  }
}
