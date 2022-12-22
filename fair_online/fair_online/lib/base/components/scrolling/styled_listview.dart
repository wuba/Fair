import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/scrolling/styled_scrollbar.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/base/components/styled_image_icon.dart';
import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef IndexedWidgetBuilder(BuildContext context, int index);

class StyledScrollPhysics extends AlwaysScrollableScrollPhysics {}

/// Core ListView for the app.
/// Wraps a [ScrollbarListStack] + [ListView.builder] and assigns the 'Styled' scroll physics for the app
/// Exposes a controller so other widgets can manipulate the list
class StyledListView extends StatefulWidget {
  final double? itemExtent;
  final int itemCount;
  final Axis axis;
  final EdgeInsets? padding;
  final EdgeInsets scrollbarPadding;
  final double barSize;

  final IndexedWidgetBuilder itemBuilder;

  StyledListView({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.itemExtent,
    this.axis = Axis.vertical,
    this.padding,
    this.barSize = 12,
    this.scrollbarPadding = EdgeInsets.zero,
  }) : super(key: key) {
    assert(itemExtent != 0, "Item extent should never be 0, null is ok.");
  }

  @override
  StyledListViewState createState() => StyledListViewState();
}

/// State is public so this can easily be controlled externally
class StyledListViewState extends State<StyledListView> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(StyledListView oldWidget) {
    if (oldWidget.itemCount != widget.itemCount || oldWidget.itemExtent != widget.itemExtent) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double contentSize = widget.itemCount * (widget.itemExtent ?? 0.0);
    Widget listContent = ScrollbarListStack(
      contentSize: contentSize,
      axis: widget.axis,
      controller: scrollController,
      barSize: widget.barSize,
      scrollbarPadding: widget.scrollbarPadding,
      child: ListView.builder(
        padding: widget.padding,
        scrollDirection: widget.axis,
        physics: StyledScrollPhysics(),
        controller: scrollController,
        itemExtent: widget.itemExtent,
        itemCount: widget.itemCount,
        itemBuilder: (c, i) => widget.itemBuilder(c, i),
      ),
    );
    return listContent;
  }
}

class StyledListViewWithTitle extends StatelessWidget {
  final Color? bgColor;
  final String title;
  final AssetImage? icon;
  final List<Widget> listItems;

  const StyledListViewWithTitle({Key? key, this.bgColor, this.title = "", this.listItems = const <Widget>[], this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return StyledCard(
      bgColor: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...{
                StyledImageIcon(icon!, color: theme.accent1Darker),
                HSpace(Insets.sm),
              },
              Text(title, style: TextStyles.T2.textColor(theme.accent1Darker)),
            ],
          ),
          VSpace(Insets.sm),
          StyledListView(itemCount: listItems.length, itemBuilder: (_, i) => listItems[i]).flexible()
        ],
      ).padding(left: Insets.l * .75, right: Insets.m, vertical: Insets.m),
    );
  }
}
