import 'package:fair_online/app/themes.dart';
import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:flutter/material.dart';

/**
 * 主页菜单按钮
 */
class LeftPanelBtn extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final bool isSelected;
  final VoidCallback? onPressed;

  LeftPanelBtn(this.icon,
      {this.isSelected = false, this.iconSize = 20, this.onPressed});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return TransparentBtn(
      onPressed: onPressed,
      borderRadius: 0,
      contentPadding: EdgeInsets.symmetric(vertical: 18),
      child: Icon(
        icon,
        size: iconSize,
        color: isSelected ? theme.accent1Dark : Colors.white,
      ),
    ).width(double.infinity);
  }
}
