import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/one_line_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StyledTabBar extends StatelessWidget {
  final void Function(int)? onTabPressed;
  final List<String> sections;
  final int index;
  static const List<String> defaults = ["test", "foo", "bar"];

  const StyledTabBar({Key? key, this.sections = defaults, this.index = 0, this.onTabPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();

    /// Create List of expanding sections's to fill the tab bar
    List<Widget> clickableLabels = sections.map((e) => _ClickableLabel(e, theme)).toList();

    /// Calculate target alignment for animated bar
    double targetAlignX = -1 + (index * 1 / (sections.length - 1)) * 2;
    return RepaintBoundary(
      child: Stack(
        children: <Widget>[
          /// Outline
          _RoundedBox(border: theme.greyWeak),

          /// Animated bar
          _RoundedBox(fill: theme.accent1)
              .fractionallySizedBox(widthFactor: 1 / sections.length)
              .alignment(Alignment(targetAlignX, 0), animate: true)
              .animate(Durations.fast, Curves.easeOut),

          /// Clickable Text labels
          Row(children: clickableLabels)
        ],
      ).height(30),
    );
  }

  Widget _RoundedBox({double? width, Color? border, Color? fill}) {
    return Container(
      width: width ?? null,
      decoration: BoxDecoration(
          color: fill,
          borderRadius: Corners.s5Border,
          border: Border.all(color: border?.withOpacity(.35) ?? Colors.transparent)),
    );
  }

  Widget _ClickableLabel(String e, AppTheme theme, [double fontScale = 1]) {
    bool isSelected = sections.indexOf(e) == index;
    Color selected = theme.isDark ? theme.bg1 : theme.surface;
    Color notSelected = theme.isDark ? theme.greyStrong : theme.grey;

    return AnimatedDefaultTextStyle(
      duration: Durations.fast,
      style: TextStyles.Footnote.textColor(isSelected ? selected : notSelected).scale(fontScale),
      child: OneLineText(e.toUpperCase())
          .center()
          .clickable(() => onTabPressed?.call(sections.indexOf(e)), opaque: true)
          .expanded(),
    );
  }
}
