import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/data/device_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceDropdownMenu extends StatefulWidget {
  const DeviceDropdownMenu({
    required this.onChanged,
    required this.selectors,
    required this.defaultSelectedPos,
    this.onCanceled,
  });

  //value改变时触发
  final Function onChanged;

  //popup消失时触发
  final Function? onCanceled;

  //可选项
  final List<DeviceData> selectors;

  //默认项
  final int defaultSelectedPos;

  @override
  State<StatefulWidget> createState() => _DeviceDropdownMenuState();
}

class _DeviceDropdownMenuState extends State<DeviceDropdownMenu> {
  //选中值
  DeviceData? selector;

  @override
  void initState() {
    super.initState();
    selector = widget.defaultSelectedPos > 0
        ? widget.selectors[widget.defaultSelectedPos]
        : widget.selectors.first;
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
            Expanded(
              child: Text(
                selector?.deviceInfo ?? '',
                style: TextStyle(
                  fontSize: FontSizes.s14,
                  color: theme.txt,
                ),
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

    final PopupMenuButton<DeviceData> pop = PopupMenuButton<DeviceData>(
      itemBuilder: (BuildContext context) =>
          widget.selectors.map<PopupMenuEntry<DeviceData>>((DeviceData value) {
        return PopupMenuItem<DeviceData>(
          value: value,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.deviceInfo,
                      style: TextStyle(
                        fontSize: FontSizes.s14,
                        color: theme.txt,
                      ),
                    ),
                    VSpace(4),
                    Text(
                      '${value.width}(px) x ${value.height}(px)',
                      style: TextStyle(
                        fontSize: FontSizes.s12,
                        color: theme.grey,
                      ),
                    ),
                  ],
                ),
              ),
              HSpace(Insets.m),
              value == selector
                  ? Image.asset(
                      "assets/images/ic_page_main_list_select.png",
                      width: 16,
                      height: 16,
                    )
                  : Container(
                      width: 16,
                      height: 16,
                    ),
            ],
          ),
        );
      }).toList(),
      //处理select操作
      onSelected: (DeviceData value) {
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

    showMenu<DeviceData>(
      context: context,
      items: pop.itemBuilder(context),
      position: position,
    ).then<void>((DeviceData? newValue) {
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
