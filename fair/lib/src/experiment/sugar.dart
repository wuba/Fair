/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

import '../extension.dart';

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

  ///popmenu
  static PopupMenuButton popMenuButton<T>({
    Key? key,
    required PopupMenuItemBuilder<T> itemBuilder,
    PopupMenuItemSelected<T>? onSelected,
    EdgeInsetsGeometry? padding,
  }){
    return PopupMenuButton<T>(
      key: key,
        itemBuilder:itemBuilder,
        onSelected: onSelected,
        padding: padding ?? const EdgeInsets.all(8.0),
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
}
class SugarSwitchCaseObj<T,K>{

  final K reValue;
  final T sugarCase;

  SugarSwitchCaseObj({required this.sugarCase,required this.reValue});
}

