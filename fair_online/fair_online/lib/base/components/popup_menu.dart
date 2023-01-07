import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/utils/color_utils.dart';
import 'package:fair_online/views/page/widget/popup_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopupMenu extends StatefulWidget {
  final Widget content;
  final Widget popup;
  final double dx;
  final double dy;

  const PopupMenu({
    Key? key,
    required this.content,
    required this.popup,
    this.dx = 0,
    this.dy = 0,
  }) : super(key: key);

  @override
  State createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return TransparentBtn(
      key: globalKey,
      downColor: Colors.transparent,
      hoverColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      onPressed: () {
        _showPopWindow(context, theme, widget.popup, widget.dx, widget.dy);
      },
      child: widget.content,
    );
  }

  _showPopWindow(BuildContext context, AppTheme theme, Widget popup, double dx,
      double dy) {
    RenderBox? renderBox =
        globalKey.currentContext?.findRenderObject() as RenderBox?;
    var offset = renderBox?.localToGlobal(Offset(0.0, renderBox.size.height));
    final RelativeRect position = RelativeRect.fromLTRB(
        (renderBox?.localToGlobal(Offset.zero).dx ?? 0) + dx,
        (offset?.dy ?? 0) + dy,
        (renderBox?.localToGlobal(Offset.zero).dx ?? 0) + dx,
        (offset?.dy ?? 0) + dy);

    showPopupWindow(
      context: context,
      fullWidth: false,
      isShowBg: true,
      position: position,
      elevation: 0.0,
      semanticLabel: '',
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: ColorUtils.shiftHsl(theme.divider, .05),
              borderRadius: BorderRadius.circular(Corners.s8),
              border: Border.all(color: theme.divider, width: 0.2)),
          child: popup,
        ),
      ),
    );
  }
}
