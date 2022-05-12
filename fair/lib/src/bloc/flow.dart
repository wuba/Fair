/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:flutter/cupertino.dart';

import '../extension.dart';
import '../type.dart';
import '../experiment/sugar.dart';

FairWidgetBinding provider = () {
  return {
    'Sugar.map': (props) {
      // var source = pa(props);
      // assert(source is List, '$source should be array');
      // var builder = props['builder'];
      //
      // var d = (source as List).map((s) => builder);
      //
      // return (d.asIteratorOf<Widget>() ?? d).toList();
      var items = pa1(props);
      assert(items is List, 'failed to generate list of Sugar.map');
      return (((items as List).asIteratorOf<Widget>() ?? items) as Iterable).toList();
    },
    'Sugar.mapEach': (props) {
      var items = pa1(props);
      assert(items is List, 'failed to generate list of Sugar.map');
      return (((items as List).asIteratorOf<Widget>() ?? items) as Iterable).toList();
    },
    'Sugar.ifEqual': (props) {
      var p0 = pa0(props);
      var p1 = pa1(props);
      if (p0.runtimeType != p1.runtimeType) {
        p0 = '$p0';
        p1 = '$p1';
      }
      return p0 == p1 ? props['trueValue'] : props['falseValue'];
    },
    'Sugar.ifEqualBool': (props) {
      var state = pa0(props);
      return state ? props['trueValue'] : props['falseValue'];
    },
    'Sugar.ifRange': (props) {
      var p0 = pa0(props);
      var p1 = pa1(props);
      assert(
          p1 is List, '$p1 is not a list, you may use If instead of IfRange');
      var matched = p1.firstWhere(
          (e) => e.runtimeType != p0.runtimeType ? '$e' == '$p0' : e == p0,
          orElse: () => null);
      return matched != null ? props['trueValue'] : props['falseValue'];
    },
    'Sugar.colorsWithOpacity':(props){
      var p0 = pa0(props);
      var p1 = pa1(props);
      return (p0 as Color).withOpacity(p1 as double);
    },

    'Sugar.switchCase':(props){
      var p0 = pa0(props);
      List p1 = (pa1(props) as List);
      var p11 = p1.mapEach((index, item) {
        var sugarCase = item['na']['sugarCase'];
        var reValue = item['na']['reValue'];
        return SugarSwitchCaseObj(
            sugarCase: sugarCase,
            reValue: reValue
        );
      });
      var p2 = pa2(props);
      for (var sugarCase in p11){
        assert(sugarCase is SugarSwitchCaseObj,'list containt elem witch is not SugarSwitchCaseObj type' );
        SugarSwitchCaseObj cobj = (sugarCase as SugarSwitchCaseObj);
        if (cobj.sugarCase == p0){
          return cobj.reValue;
        }
      }
      return p2;
    },
  };
};
