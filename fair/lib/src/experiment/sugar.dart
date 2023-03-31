/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

import '../extension.dart';
import 'dart:async';

/// The operations can be used in DSL.
class Sugar {
  Sugar._();
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
    required K Function() trueValue,
    required K Function() falseValue,
  }) =>
      expect == actual ? trueValue() : falseValue();

  static K ifEqualBool<T, K>(
    bool state, {
    required K Function() trueValue,
    required K Function() falseValue,
  }) =>
      state ? trueValue() : falseValue();

  /// Map operation with index
  static List<T> mapEach<T, E>(List<E> data, T Function(int index, E item) f) {
    return data.mapEach((index, item) => f(index, item));
  }

  /// Map operation without index
  static List<T> map<T, E>(List<E> data,
      {required T Function(E item) builder}) {
    return data.mapEach((index, item) => builder(item));
  }


  static NestedScrollViewHeaderSliversBuilder
      nestedScrollViewHeaderSliversBuilder(
          NestedScrollViewHeaderSliversBuilder builder,) {
    return builder;
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
  }) {
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

  static Duration isDuration(
      {int days = 0,
      int hours = 0,
      int minutes = 0,
      int seconds = 0,
      int milliseconds = 0,
      int microseconds = 0}) {
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
      microseconds: microseconds,
    );
  }

  static K switchCase<T, K>(T key, List<SugarSwitchCaseObj<T, K>> caseObjects,
      K Function() defaultValue) {
    for (SugarSwitchCaseObj<T, K> sugarCase in caseObjects) {
      if (sugarCase.sugarCase() == key) {
        return sugarCase.reValue();
      }
    }
    return defaultValue();
  }

  static Color colorWithOpacity = Colors.grey.withOpacity(0.8);

  static Color colorsWithOpacity(Color c, double o) {
    return c.withOpacity(o);
  }

  static Color colorsShade(MaterialColor color, int i) {
    var shadeMap = {
      50: color.shade50,
      100: color.shade100,
      200: color.shade200,
      300: color.shade300,
      400: color.shade400,
      500: color.shade500,
      600: color.shade600,
      700: color.shade700,
      800: color.shade800,
      900: color.shade900,
    };
    return shadeMap.remove(i) as Color;
  }

  static String convertToString<T>({required T orginalValue}) {
    return orginalValue.toString();
  }

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double paddingTop(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double paddingBottom(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  static Null Function() requestFocus(BuildContext context) => () {
        FocusScope.of(context).requestFocus(FocusNode());
      };

  static Null Function() onTapEmpty() => () {};

  /*CustomScrollView-SliverGrid*/
  static SliverGridDelegateWithFixedCrossAxisCount
      sliverGridDelegateWithFixedCrossAxisCount({
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

  static NullableIndexedWidgetBuilder nullableIndexedWidgetBuilder(
          NullableIndexedWidgetBuilder builder) =>
      builder;

  static IndexedWidgetBuilder indexedWidgetBuilder(
          IndexedWidgetBuilder builder) =>
      builder;

  static WidgetBuilder widgetBuilder(WidgetBuilder builder) => builder;

  static TransitionBuilder transitionBuilder(TransitionBuilder builder) =>
      builder;

  static PopupMenuItemBuilder popMenuButtonItemBuilder(PopupMenuItemBuilder builder) => builder;    
}

class SugarSwitchCaseObj<T, K> {
  final K Function() reValue;
  final T Function() sugarCase;

  SugarSwitchCaseObj({required this.sugarCase, required this.reValue});
}
