/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

