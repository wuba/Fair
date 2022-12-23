import 'package:fair_online/base/components/buttons/base_styled_button.dart';
import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrimaryBtn extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final bool bigMode;

  const PrimaryBtn({Key? key, this.child, this.onPressed, this.bigMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return BaseStyledBtn(
      minWidth: bigMode ? 160 : 78,
      minHeight: bigMode ? 60 : 42,
      contentPadding: EdgeInsets.all(bigMode ? Insets.l : Insets.m),
      bgColor: theme.accent1Darker,
      hoverColor: theme.isDark ? theme.accent1 : theme.accent1Dark,
      downColor: theme.accent1Darker,
      borderRadius: bigMode ? Corners.s8 : Corners.s5,
      child: child,
      onPressed: onPressed,
    );
  }
}

class PrimaryTextBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool bigMode;

  const PrimaryTextBtn(this.label,
      {Key? key, this.onPressed, this.bigMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle txtStyle = (bigMode ? TextStyles.Callout : TextStyles.Footnote)
        .textColor(Colors.white);
    return PrimaryBtn(
        bigMode: bigMode,
        onPressed: onPressed,
        child: Text(label, style: txtStyle));
  }
}
