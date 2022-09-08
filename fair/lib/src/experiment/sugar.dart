/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

import '../extension.dart';
import 'dart:async';

/// The operations can be used in DSL.
class Sugar {
  static K ifRange<T, K>(
    T actual,
    List<T> expect, {
    required K trueValue,
    required K falseValue,
  }) =>
      expect.contains(actual) ? trueValue : falseValue;

  static K ifEqual<T, K>(
    T actual,
    T expect, {
    required K trueValue,
    required K falseValue,
  }) =>
      expect == actual ? trueValue : falseValue;

  static K ifEqualBool<T, K>(
    bool state, {
    required K trueValue,
    required K falseValue,
  }) =>
      state ? trueValue : falseValue;

  /// Map operation with index
  static List<T> mapEach<T, E>(List<E> data, T Function(int index, E item) f) {
    return data.mapEach((index, item) => f(index, item));
  }

  /// Map operation without index
  static List<T> map<T, E>(List<E> data, {required T Function(E item) builder}) {
    return data.mapEach((index, item) => builder(item));
  }

  /// ListView.builder()
  static ListView listBuilder({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
  }){
    return ListView.builder(
      key: key,
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        itemExtent: itemExtent,
        prototypeItem: prototypeItem,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        clipBehavior: clipBehavior,
        itemCount: itemCount,
        itemBuilder:itemBuilder);
  }
  static NestedScrollViewHeaderSliversBuilder isNestedScrollViewHeaderSliversBuilder({
    required BuildContext context,
    required bool innerBoxIsScrolled,
    required List<Widget> headerSliverBuilder}){
    return (BuildContext context, bool innerBoxIsScrolled){
      return headerSliverBuilder;
    };
  }

  static ButtonStyle isButtonStyle({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? overlayColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? mouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }){
    return ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle?>(textStyle),
      backgroundColor: MaterialStateProperty.all(backgroundColor),
      foregroundColor: ButtonStyleButton.allOrNull<Color>(foregroundColor),
      overlayColor: ButtonStyleButton.allOrNull<Color>(overlayColor),
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      elevation: MaterialStateProperty.all(elevation),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(fixedSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      mouseCursor: MaterialStateProperty.all<MouseCursor?>(mouseCursor),
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }
  static Duration isDuration({
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0}){
    return Duration(
        hours:hours,
        minutes:minutes,
        seconds:seconds,
        milliseconds:milliseconds,
        microseconds:microseconds,
    );
  }
  ///popmenu
  static PopupMenuButton popMenuButton<T>({
    Key? key,
    required PopupMenuItemBuilder<T> itemBuilder,
    PopupMenuItemSelected<T>? onSelected,
    T? initialValue,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
    PopupMenuCanceled? onCanceled,
    String? tooltip,
    double? elevation,
    Widget? child,
    Widget? icon,
    double? iconSize,
    ShapeBorder? shape,
    Offset offset = Offset.zero ,
    bool enabled = true,
    Color? color,
    bool? enableFeedback
  }){
    return PopupMenuButton<T>(
      key: key,
      itemBuilder: itemBuilder,
      onSelected: onSelected,
      initialValue: initialValue,
      padding: padding,
      onCanceled: onCanceled,
      tooltip: tooltip,
      elevation: elevation,
      icon: icon,
      iconSize: iconSize,
      shape: shape,
      offset: offset,
      enabled: enabled,
      color: color,
      enableFeedback: enableFeedback,
      child: child,
    );
  }

  static K switchCase<T, K>(T key,List<SugarSwitchCaseObj<T,K>> caseObjects ,K defaultValue){
    for (SugarSwitchCaseObj<T,K> sugarCase in caseObjects){
      if(sugarCase.sugarCase == key){
        return sugarCase.reValue;
      }
    }
    return defaultValue;
  }

  static Color colorWithOpacity = Colors.grey.withOpacity(0.8);

  static Color colorsWithOpacity(Color c,double o){
    return c.withOpacity(o);
  }
  static String convertToString<T>({required T orginalValue}){
    return orginalValue.toString();
  }

  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static double width(BuildContext context) => MediaQuery.of(context).size.width;

  static double paddingTop(BuildContext context) => MediaQuery.of(context).padding.top;

  static double paddingBottom(BuildContext context) => MediaQuery.of(context).padding.bottom;

  static Null Function() requestFocus(BuildContext context) => () {
        FocusScope.of(context).requestFocus(FocusNode());
      };

  static Null Function() onTapEmpty() => () {};

  /*CustomScrollView-common-delegate*/
  static SliverChildBuilderDelegate sliverChildBuilderDelegate({
    Key? key,
    required NullableIndexedWidgetBuilder builder,
    int? childCount
  }) {
    return SliverChildBuilderDelegate((builder),
        childCount: childCount
    );
  }
  /*CustomScrollView-SliverGrid*/
  static SliverGridDelegateWithFixedCrossAxisCount sliverGridDelegateWithFixedCrossAxisCount(
      {
        required int crossAxisCount,
        double mainAxisSpacing = 0.0,
        double crossAxisSpacing = 0.0,
        double childAspectRatio = 1.0,

      }) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount, //Grid按两列显示
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
    );
  }

}
class SugarSwitchCaseObj<T,K>{

  final K reValue;
  final T sugarCase;

  SugarSwitchCaseObj({required this.sugarCase,required this.reValue});
}

