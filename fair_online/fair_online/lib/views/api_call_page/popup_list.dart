import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 选择弹出框
class PopupListWidget extends StatefulWidget {
  const PopupListWidget({
    required this.onChanged,
    required this.selectors,
    required this.defaultSelector,
    this.onCanceled,
  });

  //value改变时触发
  final Function onChanged;

  //popup消失时触发
  final Function? onCanceled;

  //可选项
  final List<String> selectors;

  //默认项
  final String defaultSelector;

  @override
  State<StatefulWidget> createState() => _PopupListWidgetState();
}

class _PopupListWidgetState extends State<PopupListWidget> {
  //选中值
  String selector = '';

  @override
  void initState() {
    selector = widget.defaultSelector;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PopupListWidget oldWidget) {
    if (oldWidget.defaultSelector != widget.defaultSelector) {
      selector = widget.defaultSelector;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();

    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(Insets.m),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Corners.btn),
          color: theme.bg2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selector,
              style: TextStyle(
                fontSize: FontSizes.s14,
                color: theme.txt,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_sharp,
              size: 24,
            )
          ],
        ),
      ),
      onTap: () {
        _showMenu(context, theme);
      },
    );
  }

  void _showMenu(BuildContext context, AppTheme theme) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)?.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(const Offset(0, 200), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final PopupMenuButton<String> pop = PopupMenuButton<String>(
      itemBuilder: (BuildContext context) =>
          widget.selectors.map<PopupMenuEntry<String>>((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Row(
            children: [
              value == selector
                  ? Icon(
                      Icons.done_rounded,
                      size: 16,
                    )
                  : Container(
                      width: 16,
                      height: 16,
                    ),
              Text(
                value,
                style: TextStyle(
                  fontSize: FontSizes.s14,
                  color: theme.txt,
                ),
              )
            ],
          ),
        );
      }).toList(),
      //处理select操作
      onSelected: (String value) {
        setState(() {
          selector = value;
        });
        widget.onChanged(value);
      },
      //处理cancel操作
      onCanceled: () {
        widget.onCanceled?.call();
      },
      initialValue: selector,
    );

    showMenu<String>(
      context: context,
      items: pop.itemBuilder(context),
      position: position,
    ).then<void>((String? newValue) {
      if (!mounted) {
        return null;
      }
      if (newValue == null) {
        pop.onCanceled?.call();
        return null;
      }
      pop.onSelected?.call(newValue);
    });
  }
}
