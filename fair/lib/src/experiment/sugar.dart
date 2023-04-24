/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'package:fair/fair.dart';
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
    NestedScrollViewHeaderSliversBuilder builder,
  ) {
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

  static PopupMenuItemBuilder popMenuButtonItemBuilder(
          PopupMenuItemBuilder builder) =>
      builder;

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
  static T asT<T>(dynamic value) => value as T;

  /// 获取枚举的名字
  static String enumName(dynamic value) => value.name;

  /// 返回 Future.value
  /// 支持常用的泛型类型，int,double,bool,String,Widget, 以及他们的可空类型，List 类型
  /// [Sugar.futureValue] 和 [Sugar.futureVoid] 为同步操作
  /// [Sugar.createFuture] 异步操作
  /// 下面为一个例子
  ///
  /// LikeButton(
  ///   size: 18.0,
  ///   isLiked: _getValue('is_favorite', false),
  ///   likeCount: _getValue('favorites', 0),
  ///   onTap: (isLiked) =>
  ///     Sugar.futureValue<bool?>(SugarBool.invert(isLiked))
  ///   ）
  static Future<T> futureValue<T>([FutureOr<T>? value]) =>
      Future<T>.value(value);

  /// 返回 Future void
  /// [Sugar.futureValue] 和 [Sugar.futureVoid] 为同步操作
  /// [Sugar.createFuture] 异步操作
  /// 不要异步等待的时候使用
  /// RefreshIndicator(onRefresh: () => Sugar.futureVoid(function: _onRefresh),)
  ///
  /// void _onRefresh() {
  /// }
  ///
  static Future<void> futureVoid({
    Function? function,
    // 多个用数组，别用 Map，会跟解析冲突
    dynamic argument,
  }) async {
    if (argument == null) {
      function?.call();
    } else {
      function?.call(argument);
    }
  }

  /// 支持异步回调
  /// 这个是一个使用的例子
  ///
  /// RefreshIndicator(
  ///   onRefresh:
  ///   () => Sugar.createFuture<void>(function: _onRefresh),
  ///   argument: 'test',
  ///   // 获取异步操作之后的值
  ///   callback: (result) {}
  /// )
  ///
  /// void _onRefresh(Map input) {
  ///  String futureId = input['futureId'];
  ///  // argument 等于 'test'
  ///  String argument = input['argument'];
  ///  // 模拟一个耗时的操作，等操作完毕之后，再去完成 Future
  ///  FairCommonPlugin().http({
  ///    'method': 'GET',
  ///    'url': 'xxxx',
  ///    // required
  ///    'pageName': '#FairKey#',
  ///    'callback': (dynamic result) {
  ///      FairCommonPlugin().futureComplete({
  ///        // required
  ///        'pageName': _pageName,
  ///        'futureId': futureId,
  ///        'futureValue': null,
  ///      });
  ///    }
  ///  });
  ///}
  /// 支持常用的泛型类型，int,double,bool,String, 以及他们的可空类型，List 类型
  /// [Sugar.futureValue] 和 [Sugar.futureVoid] 为同步操作
  /// 注意需要使用 [CompleterPlugin] ，具体操作请查看 [FairCommonPluginMixin]
  static Future<T> createFuture<T>({
    String? futureId,
    // 一个入参，结构如下
    // {
    //   'futureId': futureId,
    //   'argument': argument,
    // }
    Function? function,
    // 多个用数组，别用 Map，会跟解析冲突
    dynamic argument,
    // 执行完之后的回调
    Function? callback,
  }) {
    return CompleterPlugin.createFuture<T>(
      futureId: futureId,
      function: function,
      argument: argument,
      callback: callback,
    );
  }

  // 方便从 map 中获取值
  static dynamic mapGet(Map map, dynamic key) => map[key];
  static dynamic mapSet(Map map, dynamic key, dynamic value) =>
      map[key] = value;

  /// 生成映射会跳过 null，增加 sugar 来表示 null
  static dynamic nullValue() => null;

  static Duration durationFromJs(dynamic duration) {
    if (duration is Duration) {
      return duration;
    } else if (duration is Map) {
      return Duration(microseconds: duration['inMicroseconds']);
    }
    assert(false, 'Duration convert failed');
    return Duration.zero;
  }

  static DateTime dateTimeFromJs(dynamic dateTime) {
    if (dateTime is DateTime) {
      return dateTime;
    } else if (dateTime is Map) {
      // var isUtc = dateTime['isUtc'];
      var dateTimeS = dateTime['__date__'];
      return DateTime.tryParse(dateTimeS) ?? DateTime.now();
    }
    assert(
      false,
      'DateTime convert failed',
    );
    return DateTime.now();
  }

  /// 将 dart 对象转成成 map ，以便获取值或者传递到 js 中
  static Map<String, dynamic> dartObjectToMap(
    dynamic dartObject, {
    // 默认枚举返回对应的枚举 name
    // false, 直接返回枚举类型
    bool enumName = true,
  }) {
    if (dartObject is ScrollController || dartObject is PageController) {
      return {
        'hasClients': dartObject.hasClients,
        'length': dartObject.positions.length,
        'debugLabel': dartObject.debugLabel,
        if (dartObject.hasClients) ...{
          if (dartObject.positions.length == 1) ...{
            'offset': dartObject.offset,
            'minScrollExtent': dartObject.position.minScrollExtent,
            'maxScrollExtent': dartObject.position.maxScrollExtent,
            if (dartObject is PageController) 'page': dartObject.page,
          } else
            for (int i = 0; i < dartObject.positions.length; i++) ...{
              'offset$i': dartObject.offset,
              'minScrollExtent$i': dartObject.position.minScrollExtent,
              'maxScrollExtent$i': dartObject.position.maxScrollExtent,
              if (dartObject is PageController) 'page$i': dartObject.page,
            }
        }
      };
    } else if (dartObject is TabController) {
      return {
        'index': dartObject.index,
        'indexIsChanging': dartObject.indexIsChanging,
        'offset': dartObject.offset,
        'previousIndex': dartObject.previousIndex,
        'length': dartObject.length,
      };
    } else if (dartObject is ValueNotifier) {
      return {
        'value': dartObject.value,
      };
    } else if (dartObject is AnimationController) {
      return {
        'debugLabel': dartObject.debugLabel,
        'isAnimating': dartObject.isAnimating,
        'value': dartObject.value,
        'lowerBound': dartObject.lowerBound,
        'upperBound': dartObject.upperBound,
        'animationBehavior': enumName
            ? dartObject.animationBehavior.name
            : dartObject.animationBehavior,
        'isCompleted': dartObject.isCompleted,
        'isDismissed': dartObject.isDismissed,
        'velocity': dartObject.velocity,
      };
    } else if (dartObject is Size) {
      return {
        'width': dartObject.width,
        'height': dartObject.height,
        'aspectRatio': dartObject.aspectRatio,
        'longestSide': dartObject.longestSide,
        'shortestSide': dartObject.shortestSide,
        'isEmpty': dartObject.isEmpty,
        'isFinite': dartObject.isFinite,
        'isInfinite': dartObject.isInfinite,
      };
    } else if (dartObject is BoxConstraints) {
      return {
        'maxWidth': dartObject.maxWidth,
        'maxHeight': dartObject.maxHeight,
        'minWidth': dartObject.minWidth,
        'minHeight': dartObject.minHeight,
      };
    } else if (dartObject is Animation) {
      return {
        'isCompleted': dartObject.isCompleted,
        'isDismissed': dartObject.isDismissed,
        // 转换成字符串，方便js中使用
        'status': enumName ? dartObject.status.name : dartObject.status,
        'value': dartObject.value,
      };
    } else if (dartObject is ControlsDetails) {
      return {
        'currentStep': dartObject.currentStep,
        'isActive': dartObject.isActive,
        'stepIndex': dartObject.stepIndex,
        'onStepCancel': dartObject.onStepCancel,
        'onStepContinue': dartObject.onStepContinue,
      };
    } else if (dartObject is ImageChunkEvent) {
      return {
        'cumulativeBytesLoaded': dartObject.cumulativeBytesLoaded,
        'expectedTotalBytes': dartObject.expectedTotalBytes,
      };
    }
    assert(false, '不支持的类型: $dartObject');
    return {};
  }
}

class SugarSwitchCaseObj<T, K> {
  final K Function() reValue;
  final T Function() sugarCase;

  SugarSwitchCaseObj({required this.sugarCase, required this.reValue});
}
