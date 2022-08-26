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

    'Sugar.convertToString':(props){
      var p0 = pa0(props);
      return p0.toString();
    },
    'SugarSwitchCaseObj':(props){
      var p0 = props['sugarCase'];
      var p1 = props['reValue'];

      return SugarSwitchCaseObj(
        sugarCase: p0,
        reValue: p1,
      );
    },
    'Sugar.switchCase':(props){
      var p0 = pa0(props);
      List p1 = (pa1(props) as List);
      var p2 = pa2(props);
      for (var sugarCase in p1){
        var caseValue = sugarCase as SugarSwitchCaseObj;
        if (caseValue.sugarCase == p0){
          return caseValue.reValue;
        }
      }
      return p2;
    },
    'Sugar.listBuilder':(props){
      var p0 = pa0(props);
      var p1 = pa1(props);
      ListView paramsObj = ListView();
      if(p1 is ListView){
        paramsObj = p1 as ListView;
      }

      SliverChildListDelegate childrenDelegate = paramsObj.childrenDelegate as SliverChildListDelegate;
      var listView = ListView(
        scrollDirection:  paramsObj.scrollDirection,
        reverse:  paramsObj.reverse,
        controller:  paramsObj.controller,
        primary:  paramsObj.primary,
        physics:  paramsObj.physics,
        shrinkWrap:  paramsObj.shrinkWrap,
        padding:  paramsObj.padding,
        itemExtent: paramsObj.itemExtent,
        prototypeItem: paramsObj.prototypeItem,
        addAutomaticKeepAlives: childrenDelegate.addAutomaticKeepAlives,
        addRepaintBoundaries: childrenDelegate.addRepaintBoundaries,
        addSemanticIndexes: childrenDelegate.addSemanticIndexes,
        cacheExtent: paramsObj.cacheExtent,
        semanticChildCount: paramsObj.semanticChildCount,
        dragStartBehavior: paramsObj.dragStartBehavior,
        keyboardDismissBehavior: paramsObj.keyboardDismissBehavior,
        restorationId: paramsObj.restorationId,
        clipBehavior: paramsObj.clipBehavior,
        children: p0,);
      return listView;
    },
  };
};
