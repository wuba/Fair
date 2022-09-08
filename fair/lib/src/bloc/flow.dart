/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/src/internal/global_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extension.dart';
import '../type.dart';
import '../experiment/sugar.dart';
import '../utils.dart';

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
    'Sugar.isNestedScrollViewHeaderSliversBuilder':(props){
      var p2 = pa2(props);
      var nestedScrollViewHeaderSliversBuilder=(BuildContext context, bool innerBoxIsScrolled){return (p2 as List<Widget>);};
      return nestedScrollViewHeaderSliversBuilder;
    },

    'Sugar.isButtonStyle':(props){
      var p0 = pa0(props);
      var p1 = pa1(props);
      ButtonStyle paramsObj=ButtonStyle();
      if(p1 is ButtonStyle){
        paramsObj = p1 as ButtonStyle;
      }
      var buttonStyle=ButtonStyle(
        textStyle: paramsObj.textStyle,
        backgroundColor: paramsObj.backgroundColor,
        foregroundColor: paramsObj.foregroundColor,
        overlayColor: paramsObj.overlayColor,
        shadowColor: paramsObj.shadowColor,
        surfaceTintColor: paramsObj.surfaceTintColor,
        elevation: paramsObj.elevation,
        padding: paramsObj.padding,
        minimumSize: paramsObj.minimumSize,
        fixedSize: paramsObj.fixedSize,
        maximumSize: paramsObj.maximumSize,
        side: paramsObj.side,
        shape: paramsObj.shape,
        mouseCursor: paramsObj.mouseCursor,
        visualDensity: paramsObj.visualDensity,
        tapTargetSize: paramsObj.tapTargetSize,
        animationDuration: paramsObj.animationDuration,
        enableFeedback: paramsObj.enableFeedback,
        alignment: paramsObj.alignment,
        splashFactory: paramsObj.splashFactory,
      );
      return buttonStyle;
    },
  'Sugar.isDuration':(props){
      var days = 0;
      if(null!=props['days']){days=props['days'];}
      var hours = 0;
      if(null!=props['hours']){hours=props['hours'];}
      var minutes = 0;
      if(null!=props['minutes']){minutes=props['minutes'];}
      var seconds = 0;
      if(null!=props['seconds']){seconds=props['seconds'];}
      var milliseconds = 0;
      if(null!=props['milliseconds']){milliseconds=props['milliseconds'];}
      var microseconds = 0;
      if(null!=props['microseconds']){microseconds=props['microseconds'];}
      return Duration(days:days,hours:hours,minutes:minutes,seconds: seconds,milliseconds:milliseconds,microseconds:microseconds);
  }

  };
};
