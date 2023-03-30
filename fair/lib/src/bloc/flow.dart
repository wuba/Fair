/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extension.dart';
import '../type.dart';
import '../experiment/sugar.dart';
import 'dart:async';


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
    'Sugar.colorsShade':(props){
      MaterialColor color = pa0(props);
      var p1 = pa1(props);
      var shadeMap={
        50:color.shade50,
        100:color.shade100,
        200:color.shade200,
        300:color.shade300,
        400:color.shade400,
        500:color.shade500,
        600:color.shade600,
        700:color.shade700,
        800:color.shade800,
        900:color.shade900,
      };
      return shadeMap.remove(p1) as Color;
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
    'Sugar.popMenuButton': (props) {
      var p0 = pa0(props);
      return PopupMenuButton(
        onSelected: p0.onSelected,
        itemBuilder: p0.itemBuilder,
        child: p0.child,
        padding: p0.padding,
        initialValue: p0.initialValue,
        onCanceled: p0.onCanceled,
        tooltip: p0.tooltip,
        elevation: p0.elevation,
        icon: p0.icon,
        iconSize: p0.iconSize,
        shape: p0.shape,
        offset: p0.offset,
        enabled: p0.enabled,
        color: p0.color,
        enableFeedback: p0.enableFeedback,
      );
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
  },
    'Sugar.sliverGridDelegateWithFixedCrossAxisCount': (props) {
      Map<String, dynamic> p0 = pa0(props);

      var crossAxisCount = p0['crossAxisCount'];
      var mainAxisSpacing = p0['mainAxisSpacing'];
      var crossAxisSpacing = p0['crossAxisSpacing'];
      var childAspectRatio = p0['childAspectRatio'];

      var sliverGridDelegateWithFixedCrossAxisCount = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, //Grid按两列显示
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      );
      return sliverGridDelegateWithFixedCrossAxisCount;
    },


  };
};
