import 'package:fair_online/utils/color_utils.dart';
import 'package:flutter/material.dart';

/**
 * 拖拽分栏Widget，支持水平和垂直方向的两个子Widget分栏，随拖动改变子Widget大小
 */
class DragResizeWidget extends StatefulWidget {
  DragResizeWidget(
      {required this.axis,
      required this.firstChildBuilder,
      required this.secondChildBuilder,
      this.dragWidgetSize = 6,
      this.dragWidgetColor = Colors.white,
      this.dragHideMode});

  ///方向，垂直或水平
  final Axis axis;

  ///第一个child
  final DragResizeChildBuilder firstChildBuilder;

  ///第二个child
  final DragResizeChildBuilder secondChildBuilder;

  ///拖拽Widget的宽（垂直）高（水平）
  final double dragWidgetSize;

  ///拖拽Widget的颜色
  final Color dragWidgetColor;

  ///拖拽隐藏模式
  final DragHideMode? dragHideMode;

  @override
  State<DragResizeWidget> createState() => _DragResizeWidgetState();

  double firstChildSizePercent() {
    return firstChildBuilder.weight /
        (firstChildBuilder.weight + secondChildBuilder.weight);
  }

  double secondChildSizePercent() {
    return secondChildBuilder.weight /
        (firstChildBuilder.weight + secondChildBuilder.weight);
  }
}

class _DragResizeWidgetState extends State<DragResizeWidget> {
  double get _dragWidgetSize => widget.dragWidgetSize;

  Color get _dragWidgetColor => widget.dragWidgetColor;

  double _startY = 0;
  double _totalOffsetY = 0;
  double _offsetY = 0;

  double _startX = 0;
  double _totalOffsetX = 0;
  double _offsetX = 0;

  double firstChildInitSize(BoxConstraints constraints) {
    if (widget.dragHideMode == DragHideMode.first) {
      return widget.firstChildBuilder.minSize;
    }
    if (widget.dragHideMode == DragHideMode.second) {
      return (isVertical()
              ? constraints.maxHeight - _dragWidgetSize
              : constraints.maxWidth - _dragWidgetSize) -
          widget.secondChildBuilder.minSize;
    }
    return (isVertical()
            ? constraints.maxHeight - _dragWidgetSize
            : constraints.maxWidth - _dragWidgetSize) *
        widget.firstChildSizePercent();
  }

  double secondChildInitSize(BoxConstraints constraints) {
    if (widget.dragHideMode == DragHideMode.first) {
      return (isVertical()
              ? constraints.maxHeight - _dragWidgetSize
              : constraints.maxWidth - _dragWidgetSize) -
          widget.firstChildBuilder.minSize;
    }
    if (widget.dragHideMode == DragHideMode.second) {
      return widget.secondChildBuilder.minSize;
    }
    return (isVertical()
            ? constraints.maxHeight - _dragWidgetSize
            : constraints.maxWidth - _dragWidgetSize) *
        widget.secondChildSizePercent();
  }

  bool isVertical() {
    return widget.axis == Axis.vertical;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final firstChildWidth = isVertical()
              ? null
              : firstChildInitSize(constraints) +
                  (widget.dragHideMode == null ? _offsetX : 0);
          final firstChildHeight = isVertical()
              ? firstChildInitSize(constraints) +
                  (widget.dragHideMode == null ? _offsetY : 0)
              : null;
          final secondChildWidth = isVertical()
              ? null
              : secondChildInitSize(constraints) -
                  (widget.dragHideMode == null ? _offsetX : 0);
          final secondChildHeight = isVertical()
              ? secondChildInitSize(constraints) -
                  (widget.dragHideMode == null ? _offsetY : 0)
              : null;
          return _ColumnOrRow(
            axis: widget.axis,
            children: [
              Container(
                width: firstChildWidth,
                height: firstChildHeight,
                child: LayoutBuilder(builder: (context, constraints) {
                  return widget.firstChildBuilder.builder(
                      context, constraints.maxWidth, constraints.maxHeight);
                }),
              ),
              MouseRegion(
                cursor: widget.dragHideMode == null
                    ? (isVertical()
                        ? SystemMouseCursors.resizeRow
                        : SystemMouseCursors.resizeColumn)
                    : SystemMouseCursors.basic,
                child: GestureDetector(
                  onPanDown: (details) {
                    if (widget.dragHideMode != null) {
                      return;
                    }
                    if (_startY == 0) {
                      _startY = details.globalPosition.dy;
                    }
                    if (_startX == 0) {
                      _startX = details.globalPosition.dx;
                    }
                  },
                  onPanUpdate: (details) {
                    if (widget.dragHideMode != null) {
                      return;
                    }
                    _totalOffsetY = details.globalPosition.dy - _startY;
                    _totalOffsetX = details.globalPosition.dx - _startX;
                    final firstChildMaxOffset =
                        -(firstChildInitSize(constraints) -
                            widget.firstChildBuilder.minSize);
                    final secondChildMaxOffset =
                        secondChildInitSize(constraints) -
                            widget.secondChildBuilder.minSize;
                    if ((isVertical() ? _totalOffsetY : _totalOffsetX) >
                            firstChildMaxOffset &&
                        (isVertical() ? _totalOffsetY : _totalOffsetX) <
                            secondChildMaxOffset) {
                      setState(() {
                        if (isVertical()) {
                          _offsetY = _totalOffsetY;
                        } else {
                          _offsetX = _totalOffsetX;
                        }
                      });
                    } else if ((isVertical() ? _totalOffsetY : _totalOffsetX) >
                            firstChildMaxOffset &&
                        (isVertical() ? _totalOffsetY : _totalOffsetX) <
                            secondChildMaxOffset) {
                      setState(() {
                        if (isVertical()) {
                          _offsetY = _totalOffsetY < 0
                              ? firstChildMaxOffset
                              : secondChildMaxOffset;
                        } else {
                          _offsetX = _totalOffsetX < 0
                              ? firstChildMaxOffset
                              : secondChildMaxOffset;
                        }
                      });
                    }
                  },
                  child: Container(
                    width: isVertical() ? null : _dragWidgetSize,
                    height: isVertical() ? _dragWidgetSize : null,
                    color: _dragWidgetColor,
                    child: Center(
                      child: isVertical()
                          ? Container()
                          : Container(
                              decoration: BoxDecoration(
                                  color:
                                      ColorUtils.shiftHsl(_dragWidgetColor, .5),
                                  borderRadius: BorderRadius.circular(
                                      _dragWidgetSize / 4.0)),
                              width: _dragWidgetSize / 2.0,
                              height: 25,
                            ),
                    ),
                  ),
                ),
              ),
              Container(
                width: secondChildWidth,
                height: secondChildHeight,
                child: LayoutBuilder(builder: (context, constraints) {
                  return widget.secondChildBuilder.builder(
                      context, constraints.maxWidth, constraints.maxHeight);
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

typedef Widget OnResizeChildBuild(
    BuildContext context, double width, double height);

/**
 * 构造大小随拖拽变化的Widget
 */
class DragResizeChildBuilder {
  DragResizeChildBuilder(
      {required this.builder, this.weight = 1, this.minSize = 0});

  final OnResizeChildBuild builder;

  final double weight;

  final double minSize;
}

/**
 * 拖拽隐藏模式
 */
enum DragHideMode {
  ///第一个元素隐藏，但不会小于设置的minSize
  first,

  ///第二个元素隐藏，但不会小于设置的minSize
  second
}

class _ColumnOrRow extends StatelessWidget {
  _ColumnOrRow({required this.axis, required this.children});

  final Axis axis;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return axis == Axis.vertical
        ? Column(
            children: children,
          )
        : Row(
            children: children,
          );
  }
}
