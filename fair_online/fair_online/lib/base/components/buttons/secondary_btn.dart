import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/base_styled_button.dart';
import 'package:fair_online/base/components/styled_image_icon.dart';
import 'package:fair_online/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondaryTextBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const SecondaryTextBtn(this.label, {Key? key, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    TextStyle txtStyle = TextStyles.Footnote.textColor(theme.accent1Darker);
    return SecondaryBtn(
        onPressed: onPressed, child: Text(label, style: txtStyle));
  }
}

class SecondaryIconBtn extends StatelessWidget {
  /// Must be either an `AssetImage` for an `ImageIcon` or an `IconData` for a regular `Icon`
  final AssetImage icon;
  final VoidCallback? onPressed;
  final Color? color;

  const SecondaryIconBtn(this.icon, {Key? key, this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return SecondaryBtn(
      onPressed: onPressed,
      minHeight: 36,
      minWidth: 36,
      contentPadding: Insets.sm,
      child: StyledImageIcon(icon, size: 20, color: color ?? theme.grey),
    );
  }
}

class SecondaryBtn extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final double minWidth;
  final double minHeight;
  final double contentPadding;
  final void Function(bool)? onFocusChanged;

  const SecondaryBtn(
      {Key? key,
      this.child,
      this.onPressed,
      this.minWidth = 78,
      this.minHeight = 42,
      this.contentPadding = Insets.m,
      this.onFocusChanged})
      : super(key: key);

  @override
  _SecondaryBtnState createState() => _SecondaryBtnState();
}

class _SecondaryBtnState extends State<SecondaryBtn> {
  bool _isMouseOver = false;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return MouseRegion(
      onEnter: (_) => setState(() => _isMouseOver = true),
      onExit: (_) => setState(() => _isMouseOver = false),
      child: BaseStyledBtn(
        minWidth: widget.minWidth,
        minHeight: widget.minHeight,
        contentPadding: EdgeInsets.all(widget.contentPadding),
        bgColor: theme.surface,
        outlineColor:
            (_isMouseOver ? theme.accent1 : theme.grey).withOpacity(.35),
        hoverColor: theme.surface,
        onFocusChanged: widget.onFocusChanged,
        downColor: ColorUtils.shiftHsl(theme.divider, .2),
        borderRadius: Corners.s5,
        child: IgnorePointer(child: widget.child),
        onPressed: widget.onPressed,
      ),
    );
  }
}
