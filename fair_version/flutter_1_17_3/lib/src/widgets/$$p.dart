/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:flutter/material.dart';

import 'utils.dart';
import 'dart:ui';
import "dart:math" as math;
var p = () => {
      'Alignment': (props) => Alignment(
            props['pa'][0]?.toDouble(),
            props['pa'][1]?.toDouble(),
          ),
      'Alignment.topLeft': Alignment.topLeft,
      'Alignment.topCenter': Alignment.topCenter,
      'Alignment.topRight': Alignment.topRight,
      'Alignment.centerLeft': Alignment.centerLeft,
      'Alignment.center': Alignment.center,
      'Alignment.centerRight': Alignment.centerRight,
      'Alignment.bottomLeft': Alignment.bottomLeft,
      'Alignment.bottomCenter': Alignment.bottomCenter,
      'Alignment.bottomRight': Alignment.bottomRight,
      'AlignmentDirectional': {
        'topStart': AlignmentDirectional.topStart,
        'topCenter': AlignmentDirectional.topCenter,
        'topEnd': AlignmentDirectional.topEnd,
        'centerStart': AlignmentDirectional.centerStart,
        'center': AlignmentDirectional.center,
        'centerEnd': AlignmentDirectional.centerEnd,
        'bottomStart': AlignmentDirectional.bottomStart,
        'bottomCenter': AlignmentDirectional.bottomCenter,
        'bottomEnd': AlignmentDirectional.bottomEnd,
      },
      'TextAlignVertical': {
        'top': TextAlignVertical.top,
        'center': TextAlignVertical.center,
        'bottom': TextAlignVertical.bottom,
      },
      'AssetImage': (props) => AssetImage(
            props['pa'][0],
            bundle: props['bundle'],
            package: props['package'],
          ),
      'Axis': {
        'values': Axis.values,
        'horizontal': Axis.horizontal,
        'vertical': Axis.vertical,
      },
      'AxisDirection': {
        'values': AxisDirection.values,
        'up': AxisDirection.up,
        'right': AxisDirection.right,
        'down': AxisDirection.down,
        'left': AxisDirection.left,
      },
      'RenderComparison': {
        'values': RenderComparison.values,
        'identical': RenderComparison.identical,
        'metadata': RenderComparison.metadata,
        'paint': RenderComparison.paint,
        'layout': RenderComparison.layout,
      },
      'VerticalDirection': {
        'values': VerticalDirection.values,
        'up': VerticalDirection.up,
        'down': VerticalDirection.down,
      },
      'Border': (props) => Border(
            top: props['top'] ?? BorderSide.none,
            right: props['right'] ?? BorderSide.none,
            bottom: props['bottom'] ?? BorderSide.none,
            left: props['left'] ?? BorderSide.none,
          ),
      'Border.fromBorderSide': (props) => Border.fromBorderSide(
            props['pa'][0],
          ),
      'Border.symmetric': (props) => Border.symmetric(
            vertical: props['vertical'] ?? BorderSide.none,
            horizontal: props['horizontal'] ?? BorderSide.none,
          ),
      'Border.all': (props) => Border.all(
            color: props['color'] ?? const Color(0xFF000000),
            width: props['width']?.toDouble() ?? 1.0,
            style: props['style'] ?? BorderStyle.solid,
          ),
      'BoxShape': {
        'values': BoxShape.values,
        'rectangle': BoxShape.rectangle,
        'circle': BoxShape.circle,
      },
      'BorderRadius.all': (props) => BorderRadius.all(
            props['pa'][0],
          ),
      'BorderRadius.circular': (props) => BorderRadius.circular(
            props['pa'][0]?.toDouble(),
          ),
      'BorderRadius.vertical': (props) => BorderRadius.vertical(
            top: props['top'] ?? Radius.zero,
            bottom: props['bottom'] ?? Radius.zero,
          ),
      'BorderRadius.horizontal': (props) => BorderRadius.horizontal(
            left: props['left'] ?? Radius.zero,
            right: props['right'] ?? Radius.zero,
          ),
      'BorderRadius.only': (props) => BorderRadius.only(
            topLeft: props['topLeft'] ?? Radius.zero,
            topRight: props['topRight'] ?? Radius.zero,
            bottomLeft: props['bottomLeft'] ?? Radius.zero,
            bottomRight: props['bottomRight'] ?? Radius.zero,
          ),
      'BorderRadius.zero': BorderRadius.zero,
      'BorderRadiusDirectional.all': (props) => BorderRadiusDirectional.all(
            props['pa'][0],
          ),
      'BorderRadiusDirectional.circular': (props) =>
          BorderRadiusDirectional.circular(
            props['pa'][0]?.toDouble(),
          ),
      'BorderRadiusDirectional.vertical': (props) =>
          BorderRadiusDirectional.vertical(
            top: props['top'] ?? Radius.zero,
            bottom: props['bottom'] ?? Radius.zero,
          ),
      'BorderRadiusDirectional.horizontal': (props) =>
          BorderRadiusDirectional.horizontal(
            start: props['start'] ?? Radius.zero,
            end: props['end'] ?? Radius.zero,
          ),
      'BorderRadiusDirectional.only': (props) => BorderRadiusDirectional.only(
            topStart: props['topStart'] ?? Radius.zero,
            topEnd: props['topEnd'] ?? Radius.zero,
            bottomStart: props['bottomStart'] ?? Radius.zero,
            bottomEnd: props['bottomEnd'] ?? Radius.zero,
          ),
      'BorderRadiusDirectional.zero': BorderRadiusDirectional.zero,
      'BorderSide': {
        'none': BorderSide.none,
      },
      'BorderStyle': {
        'values': BorderStyle.values,
        'none': BorderStyle.none,
        'solid': BorderStyle.solid,
      },
      'BoxDecoration': (props) => BoxDecoration(
            color: props['color'],
            image: props['image'],
            border: props['border'],
            borderRadius: props['borderRadius'],
            boxShadow: as<BoxShadow>(props['boxShadow']),
            gradient: props['gradient'],
            backgroundBlendMode: props['backgroundBlendMode'],
            shape: props['shape'] ?? BoxShape.rectangle,
          ),
      'BoxFit': {
        'values': BoxFit.values,
        'fill': BoxFit.fill,
        'contain': BoxFit.contain,
        'cover': BoxFit.cover,
        'fitWidth': BoxFit.fitWidth,
        'fitHeight': BoxFit.fitHeight,
        'none': BoxFit.none,
        'scaleDown': BoxFit.scaleDown,
      },
      'BoxShadow': (props) => BoxShadow(
            color: props['color'] ?? const Color(0xFF000000),
            offset: props['offset'] ?? Offset.zero,
            blurRadius: props['blurRadius']?.toDouble() ?? 0.0,
            spreadRadius: props['spreadRadius']?.toDouble() ?? 0.0,
          ),
      'DecorationImage': (props) => DecorationImage(
            image: props['image'],
            onError: props['onError'],
            colorFilter: props['colorFilter'],
            fit: props['fit'],
            alignment: props['alignment'] ?? Alignment.center,
            centerSlice: props['centerSlice'],
            repeat: props['repeat'] ?? ImageRepeat.noRepeat,
            matchTextDirection: props['matchTextDirection'] ?? false,
          ),
      'ImageRepeat': {
        'values': ImageRepeat.values,
        'repeat': ImageRepeat.repeat,
        'repeatX': ImageRepeat.repeatX,
        'repeatY': ImageRepeat.repeatY,
        'noRepeat': ImageRepeat.noRepeat,
      },
      'EdgeInsets.fromLTRB': (props) => EdgeInsets.fromLTRB(
            props['pa'][0]?.toDouble(),
            props['pa'][1]?.toDouble(),
            props['pa'][2]?.toDouble(),
            props['pa'][3]?.toDouble(),
          ),
      'EdgeInsets.all': (props) => EdgeInsets.all(
            props['pa'][0]?.toDouble(),
          ),
      'EdgeInsets.only': (props) => EdgeInsets.only(
            left: props['left']?.toDouble() ?? 0.0,
            top: props['top']?.toDouble() ?? 0.0,
            right: props['right']?.toDouble() ?? 0.0,
            bottom: props['bottom']?.toDouble() ?? 0.0,
          ),
      'EdgeInsets.symmetric': (props) => EdgeInsets.symmetric(
            vertical: props['vertical']?.toDouble() ?? 0.0,
            horizontal: props['horizontal']?.toDouble() ?? 0.0,
          ),
      'EdgeInsets.fromWindowPadding': (props) => EdgeInsets.fromWindowPadding(
            props['pa'][0],
            props['pa'][1]?.toDouble(),
          ),
      'EdgeInsets.zero': EdgeInsets.zero,
      'EdgeInsetsDirectional': {
        'zero': EdgeInsetsDirectional.zero,
      },
      'FlutterLogoStyle': {
        'values': FlutterLogoStyle.values,
        'markOnly': FlutterLogoStyle.markOnly,
        'horizontal': FlutterLogoStyle.horizontal,
        'stacked': FlutterLogoStyle.stacked,
      },
      'FractionalOffset': (props) => FractionalOffset(
            props['pa'][0]?.toDouble(),
            props['pa'][1]?.toDouble(),
          ),
      'FractionalOffset.fromOffsetAndSize': (props) =>
          FractionalOffset.fromOffsetAndSize(
            props['pa'][0],
            props['pa'][1],
          ),
      'FractionalOffset.fromOffsetAndRect': (props) =>
          FractionalOffset.fromOffsetAndRect(
            props['pa'][0],
            props['pa'][1],
          ),
      'FractionalOffset.topLeft': FractionalOffset.topLeft,
      'FractionalOffset.topCenter': FractionalOffset.topCenter,
      'FractionalOffset.topRight': FractionalOffset.topRight,
      'FractionalOffset.centerLeft': FractionalOffset.centerLeft,
      'FractionalOffset.center': FractionalOffset.center,
      'FractionalOffset.centerRight': FractionalOffset.centerRight,
      'FractionalOffset.bottomLeft': FractionalOffset.bottomLeft,
      'FractionalOffset.bottomCenter': FractionalOffset.bottomCenter,
      'FractionalOffset.bottomRight': FractionalOffset.bottomRight,
      'ImageConfiguration': {
        'empty': ImageConfiguration.empty,
      },
      'InlineSpanSemanticsInformation': {
        'placeholder': InlineSpanSemanticsInformation.placeholder,
      },
      'LinearGradient': (props) => LinearGradient(
            begin: props['begin'] ?? Alignment.centerLeft,
            end: props['end'] ?? Alignment.centerRight,
            colors: as<Color>(props['colors']),
            stops: as<double>(props['stops']),
            tileMode: props['tileMode'] ?? TileMode.clamp,
            transform: props['transform'],
          ),
      'RadialGradient': (props) => RadialGradient(
            center: props['center'] ?? Alignment.center,
            radius: props['radius']?.toDouble() ?? 0.5,
            colors: as<Color>(props['colors']),
            stops: as<double>(props['stops']),
            tileMode: props['tileMode'] ?? TileMode.clamp,
            focal: props['focal'],
            focalRadius: props['focalRadius']?.toDouble() ?? 0.0,
            transform: props['transform'],
          ),
      'SweepGradient': (props) => SweepGradient(
            center: props['center'] ?? Alignment.center,
            startAngle: props['startAngle']?.toDouble() ?? 0.0,
            endAngle: props['endAngle']?.toDouble() ?? math.pi * 2,
            colors: as<Color>(props['colors']),
            stops: as<double>(props['stops']),
            tileMode: props['tileMode'] ?? TileMode.clamp,
            transform: props['transform'],
          ),
      'NetworkImage': (props) => NetworkImage(
            props['pa'][0],
            scale: props['scale']?.toDouble() ?? 1.0,
            headers: props['headers'],
          ),
      'StrutStyle': {
        'disabled': StrutStyle.disabled,
      },
      'TextStyle': (props) => TextStyle(
            inherit: props['inherit'] ?? true,
            color: props['color'],
            backgroundColor: props['backgroundColor'],
            fontSize: props['fontSize']?.toDouble(),
            fontWeight: props['fontWeight'],
            fontStyle: props['fontStyle'],
            letterSpacing: props['letterSpacing']?.toDouble(),
            wordSpacing: props['wordSpacing']?.toDouble(),
            textBaseline: props['textBaseline'],
            height: props['height']?.toDouble(),
            locale: props['locale'],
            foreground: props['foreground'],
            background: props['background'],
            shadows: as<Shadow>(props['shadows']),
            fontFeatures: as<FontFeature>(props['fontFeatures']),
            decoration: props['decoration'],
            decorationColor: props['decorationColor'],
            decorationStyle: props['decorationStyle'],
            decorationThickness: props['decorationThickness']?.toDouble(),
            debugLabel: props['debugLabel'],
            fontFamily: props['fontFamily'],
            fontFamilyFallback: as<String>(props['fontFamilyFallback']),
            package: props['package'],
          ),
      'TextWidthBasis': {
        'values': TextWidthBasis.values,
        'parent': TextWidthBasis.parent,
        'longestLine': TextWidthBasis.longestLine,
      },
    };
