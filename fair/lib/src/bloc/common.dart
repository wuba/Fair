/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:io';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:fair_version/fair_version.dart';
import 'package:flutter/widgets.dart';

import '../app.dart';
import '../internal/global_state.dart';
import '../type.dart';
import '../utils.dart';
import '../widget.dart';

FairWidgetBinding provider = () {
  return {
    'FairWidget': (props) => FairWidget(
          name: props['name'],
          path: props['path'],
          data: props['data'],
        ),
    'Color': (props) {
      var color = pa0(props);
      return color is String ? FairUtils.fromHex(color) : Color(color);
    },
    'TextSpan': (props) => TextSpan(
          text: props['text'],
          children: as<InlineSpan>(props['children']),
          style: props['style'],
          recognizer: props['recognizer'],
          semanticsLabel: props['semanticsLabel'],
        ),
    'VoidCallback': (props) => () {
          var func = props['invoke'];
          assert(func is Function, '$func should provide as Function');
          var result = func();
          if (result != null) {
            log('[Fair] result of $func is ignored');
          }
        },
    'Navigator.pushNamed': (props) => () {
          // ignore p0 => context string
          var context = $(props);
          var route = FairApp.of(context)?.routeBuilder;
          if (route != null) {
            route(context, pa1(props), arguments: props['arguments']);
            return null;
          }
          return Navigator.of(context).pushNamed(
            pa1(props),
            arguments: props['arguments'],
          );
        },
    'Navigator.popAndPushNamed': (props) => () {
          var context = $(props);
          var route = FairApp.of(context)?.routeBuilder;
          if (route != null) {
            route(context, pa0(props), arguments: props['arguments']);
            return null;
          }
          return Navigator.of(context).popAndPushNamed(
            pa0(props),
            arguments: props['arguments'],
          );
        },
    'SimpleTextItemBuilder': (props) => (text) => Text(text),
    'double.infinity': double.infinity,
    'File': (props) => File(props['pa'][0]),
    'InputDecoration': (props) => InputDecoration(
        prefixIcon: props['prefixIcon'],
        suffixIcon: props['suffixIcon'],
        border: props['border'],
        focusedBorder: props['focusedBorder'],
        enabledBorder: props['enabledBorder'],
        hintText: props['hintText'],
        hintStyle: props['hintStyle'],
        hintTextDirection: props['hintTextDirection'],
        hintMaxLines: props['hintMaxLines']),
    'OutlineInputBorder': (props) => OutlineInputBorder(
        borderRadius: props['borderRadius'], borderSide: props['borderSide']),
    'BorderSide': (props) => BorderSide(
        color: props['color'],
        width: props['width'],
        style: props['style'] ?? BorderStyle.solid),
    'Sugar.enumName': (props) => Sugar.enumName(pa0(props)),
    'Sugar.futureValue': (props) {
      var value = pa0(props);
      // 支持一些常用的
      if (value is int) {
        return Future<int>.value(value);
      } else if (value is int?) {
        return Future<int?>.value(value);
      } else if (value is double) {
        return Future<double>.value(value);
      } else if (value is double?) {
        return Future<double?>.value(value);
      } else if (value is bool) {
        return Future<bool>.value(value);
      } else if (value is bool?) {
        return Future<bool?>.value(value);
      } else if (value is String) {
        return Future<String>.value(value);
      } else if (value is String?) {
        return Future<String?>.value(value);
      } else if (value is Widget) {
        return Future<Widget>.value(value);
      } else if (value is Widget?) {
        return Future<Widget?>.value(value);
      } else if (value is List<int>) {
        return Future<List<int>>.value(value);
      } else if (value is List<int?>) {
        return Future<List<int?>>.value(value);
      } else if (value is List<double>) {
        return Future<List<double>>.value(value);
      } else if (value is List<double?>) {
        return Future<List<double?>>.value(value);
      } else if (value is List<bool>) {
        return Future<List<bool>>.value(value);
      } else if (value is List<bool?>) {
        return Future<List<bool?>>.value(value);
      } else if (value is List<String>) {
        return Future<List<String>>.value(value);
      } else if (value is List<String?>) {
        return Future<List<String?>>.value(value);
      } else if (value is List<Widget>) {
        return Future<List<Widget>>.value(value);
      } else if (value is List<Widget?>) {
        return Future<List<Widget?>>.value(value);
      }
      // Future<dynamic>
      return Future.value(value);
    },
    'Sugar.mapGet': (props) => Sugar.mapGet(pa0(props), pa1(props)),
    'Sugar.imageChunkEventToMap': (props) =>
        Sugar.imageChunkEventToMap(pa0(props)),
    'Sugar.controlsDetailsToMap': (props) => Sugar.controlsDetailsToMap(
          pa0(props),
        ),
    'Sugar.animationToMap': (props) => Sugar.animationToMap(pa0(props)),
    'Sugar.boxConstraintsToMap': (props) =>
        Sugar.boxConstraintsToMap(pa0(props)),
    'Sugar.sizeToMap': (props) => Sugar.sizeToMap(pa0(props)),
  };
};
