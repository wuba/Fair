import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:keframe/keframe.dart';

class ExtendedFrameSeparateWidget extends StatefulWidget {
  const ExtendedFrameSeparateWidget({
    Key? key,
    this.index,
    this.placeHolder,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;

  /// The placeholder widget sets components that are as close to the actual widget as possible
  final Widget? placeHolder;

  /// Identifies its own ID, used in a scenario where size information is stored
  final int? index;

  @override
  State<ExtendedFrameSeparateWidget> createState() =>
      _FrameSeparateWidgetState();
}

class _FrameSeparateWidgetState extends State<ExtendedFrameSeparateWidget> {
  Widget? result;

  @override
  void initState() {
    super.initState();
    result = widget.placeHolder ??
        Container(
          height: 20,
        );
    final Map<int?, Size>? size = SizeCacheWidget.of(context)?.itemsSizeCache;
    Size? itemSize;
    if (size != null && size.containsKey(widget.index)) {
      itemSize = size[widget.index];
      logcat('cache hit：${widget.index} ${itemSize.toString()}');
    }
    if (itemSize != null) {
      result = SizedBox(
        width: itemSize.width,
        height: itemSize.height,
        child: result,
      );
    }
    transformWidget();
  }

  @override
  void didUpdateWidget(ExtendedFrameSeparateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    transformWidget();
  }

  @override
  Widget build(BuildContext context) {
    return ItemSizeInfoNotifier(index: widget.index, child: result);
  }

  void transformWidget() {
    SchedulerBinding.instance.addPostFrameCallback((Duration t) {
      FrameSeparateTaskQueue.instance!.scheduleTask(() {
        if (mounted) {
          setState(() {
            result = widget.builder(context);
          });
        }
      }, Priority.animation, () => !mounted, id: widget.index);
    });
  }
}
