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

  static K ifEqualBool<K>(
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
  
  /// 用于 function domain 映射的时候，强制 ast 的返回值为 function 对应的返回类型
  /// 比如 
  /// class A {
  /// 
  /// }
  /// class B extends A {
  /// 
  /// }
  /// 
  /// 
  /// callback: () {
  ///   return B();
  /// }
  /// 
  /// 会生成这样的， "B Function()"
  /// 
  /// 但是实际上 callback 对应的映射是 "A Function()"
  /// 
  /// 可以通过下面的方式来让 ast 生成对应的返回类型
  /// callback: () {
  ///   return Sugar.asT<A>(B());
  /// }
  /// 
  /// 对于继承 Widget 的全部返回类型，fair_ast_gen.dart 中做了特殊处理，都会看作为 Widget。
  /// 应该尽量避免使用返回类型是显式类型(比如返回类型必须是Container)，如果真的需要，请在回调执行的地方再做强转。
  /// 或者在自定义的 DynamicWidgetBuilder 中做特殊处理
  /// 
  /// class SugarCommon {
  ///   SugarCommon._();
  ///   static Container Function() returnContainer(Widget Function() input) {
  ///     Container Function() builder =(){
  ///       return input() as Container;
  ///     };
  ///     return builder;
  ///   }
  /// }
  /// 
  /// class CustomDynamicWidgetBuilder extends DynamicWidgetBuilder {
  ///   CustomDynamicWidgetBuilder(
  ///     super.proxyMirror,
  ///     super.page,
  ///     super.bound, {
  ///     super.bundle,
  ///   });
  ///   @override
  ///   dynamic convert(BuildContext context, Map map, Map? methodMap,
  ///       {Domain? domain}) {
  ///     var name = map[tag];
  ///     if(name =='SugarCommon.returnContainer') {
  ///        dynamic fairFunction = pa0(map);
  ///        assert(fairFunction is Map);
  ///        Container Function() builder = (
  ///        ) {
  ///          return convert(
  ///            context,
  ///            FunctionDomain.getBody(fairFunction),
  ///            methodMap,
  ///          ) as Container;
  ///        };
  ///        return builder;
  ///     }
  ///     return super.convert(context, map, methodMap, domain:domain);
  ///   }
  /// }
  static T asT<T>(dynamic value)=> value as T;
 
  /// 获取枚举的名字
  static String enumName(dynamic value) => value.name;   
 
  /// 返回 Future.value
  static Future<T> futureValue<T>(T value)=> Future.value(value);
  
  // 方便从 map 中获取值
  static dynamic mapGet(Map map, String key) => map[key];
  
  // typedef ImageLoadingBuilder = Widget Function(BuildContext context, Widget child, ImageChunkEvent? loadingProgress)
  // package:flutter/src/widgets/image.dart
  // 方便在回调中获取值
  static dynamic imageChunkEventGet(ImageChunkEvent imageChunkEvent, String key) {
    return {
      'cumulativeBytesLoaded': imageChunkEvent.cumulativeBytesLoaded,
      'expectedTotalBytes': imageChunkEvent.expectedTotalBytes,
    }[key];
  }
  // typedef ControlsWidgetBuilder = Widget Function(BuildContext context, ControlsDetails details)
  // package:flutter/src/material/stepper.dart
  // 方便在回调中获取值
  static dynamic controlsDetailsGet(ControlsDetails controlsDetails, String key) {
    return {
      'currentStep': controlsDetails.currentStep,
      'isActive': controlsDetails.isActive,
      'stepIndex': controlsDetails.stepIndex,
      'onStepCancel': controlsDetails.onStepCancel,
      'onStepContinue': controlsDetails.onStepContinue,
    }[key];
  }
  
  // 方便在回调中获取值
  static dynamic animationGet(Animation animation, String key) {
    return {
      'isCompleted': animation.isCompleted,
      'isDismissed': animation.isDismissed,
      'status': animation.status,
      'value': animation.value,
    }[key];
  }
  
  // typedef LayoutWidgetBuilder = Widget Function(BuildContext context, BoxConstraints constraints); 
  // package:flutter/src/widgets/layout_builder.dart
  // 方便在回调中获取值
  static dynamic boxConstraintsGet(BoxConstraints boxConstraints, String key) {
    return {
      'maxWidth': boxConstraints.maxWidth,
      'maxHeight': boxConstraints.maxHeight,
      'minWidth': boxConstraints.minWidth,
      'minHeight': boxConstraints.minHeight,
    }[key];
  }

  static dynamic sizeGet(Size size, String key) {
    return {
      'width': size.width,
      'height': size.height,
      'aspectRatio': size.aspectRatio,
      'longestSide': size.longestSide,
      'shortestSide': size.shortestSide,
      'isEmpty': size.isEmpty,
      'isFinite': size.isFinite,
      'isInfinite': size.isInfinite,
      'flipped': size.flipped,       
    }[key];
  }
}

class SugarSwitchCaseObj<T, K> {
  final K Function() reValue;
  final T Function() sugarCase;

  SugarSwitchCaseObj({required this.sugarCase, required this.reValue});
}
