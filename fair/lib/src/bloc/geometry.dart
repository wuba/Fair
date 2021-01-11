/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:flutter/widgets.dart';

import '../type.dart';

FairWidgetBinding provider = () {
  return {
    'Offset': (props) => Offset(pa0(props)?.toDouble(), pa1(props)?.toDouble()),
    'Offset.fromDirection': (props) => Offset.fromDirection(
        pa0(props)?.toDouble(), props['distance']?.toDouble()),
    'Size': (props) => Size(pa0(props)?.toDouble(), pa1(props)?.toDouble()),
    'Size.copy': (props) => Size.copy(pa0(props)),
    'Size.square': (props) => Size.square(pa0(props)?.toDouble()),
    'Size.fromWidth': (props) => Size.fromWidth(pa0(props)),
    'Size.fromHeight': (props) => Size.fromHeight(pa0(props)),
    'Size.fromRadius': (props) => Size.fromRadius(pa0(props)),
    'Rect.fromLTRB': (props) => Rect.fromLTRB(
          pa0(props)?.toDouble(),
          pa1(props)?.toDouble(),
          pa2(props)?.toDouble(),
          pa3(props)?.toDouble(),
        ),
    'Rect.fromLTWH': (props) => Rect.fromLTWH(
          pa0(props)?.toDouble(),
          pa1(props)?.toDouble(),
          pa2(props)?.toDouble(),
          pa3(props)?.toDouble(),
        ),
    'Rect.fromCircle': (props) => Rect.fromCircle(
          center: props['center'],
          radius: props['radius']?.toDouble(),
        ),
    'Rect.fromCenter': (props) => Rect.fromCenter(
          center: props['center'],
          width: props['radius']?.toDouble(),
          height: props['radius']?.toDouble(),
        ),
    'Rect.fromPoints': (props) => Rect.fromPoints(pa0(props), pa1(props)),
    'Radius.circular': (props) => Radius.circular(pa0(props)?.toDouble()),
    'Radius.elliptical': (props) =>
        Radius.elliptical(pa0(props)?.toDouble(), pa1(props)?.toDouble()),
  };
};
