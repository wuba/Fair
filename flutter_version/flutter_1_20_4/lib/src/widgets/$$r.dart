/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:flutter/material.dart';

import 'utils.dart';
import 'package:flutter/rendering.dart';

var p = () => {
      'CacheExtentStyle': {
        'values': CacheExtentStyle.values,
        'pixel': CacheExtentStyle.pixel,
        'viewport': CacheExtentStyle.viewport,
      },
      'RenderViewport': {
        'useTwoPaneSemantics': RenderViewport.useTwoPaneSemantics,
        'excludeFromScrolling': RenderViewport.excludeFromScrolling,
      },
      'CrossAxisAlignment': {
        'values': CrossAxisAlignment.values,
        'start': CrossAxisAlignment.start,
        'end': CrossAxisAlignment.end,
        'center': CrossAxisAlignment.center,
        'stretch': CrossAxisAlignment.stretch,
        'baseline': CrossAxisAlignment.baseline,
      },
      'FlexFit': {
        'values': FlexFit.values,
        'tight': FlexFit.tight,
        'loose': FlexFit.loose,
      },
      'MainAxisAlignment': {
        'values': MainAxisAlignment.values,
        'start': MainAxisAlignment.start,
        'end': MainAxisAlignment.end,
        'center': MainAxisAlignment.center,
        'spaceBetween': MainAxisAlignment.spaceBetween,
        'spaceAround': MainAxisAlignment.spaceAround,
        'spaceEvenly': MainAxisAlignment.spaceEvenly,
      },
      'MainAxisSize': {
        'values': MainAxisSize.values,
        'min': MainAxisSize.min,
        'max': MainAxisSize.max,
      },
      'DecorationPosition': {
        'values': DecorationPosition.values,
        'background': DecorationPosition.background,
        'foreground': DecorationPosition.foreground,
      },
      'HitTestBehavior': {
        'values': HitTestBehavior.values,
        'deferToChild': HitTestBehavior.deferToChild,
        'opaque': HitTestBehavior.opaque,
        'translucent': HitTestBehavior.translucent,
      },
      'GrowthDirection': {
        'values': GrowthDirection.values,
        'forward': GrowthDirection.forward,
        'reverse': GrowthDirection.reverse,
      },
      'SliverGeometry': {
        'zero': SliverGeometry.zero,
      },
      'Overflow': {
        'values': Overflow.values,
        'visible': Overflow.visible,
        'clip': Overflow.clip,
      },
      'RelativeRect': {
        'fill': RelativeRect.fill,
      },
      'StackFit': {
        'values': StackFit.values,
        'loose': StackFit.loose,
        'expand': StackFit.expand,
        'passthrough': StackFit.passthrough,
      },
      'PlatformViewHitTestBehavior': {
        'values': PlatformViewHitTestBehavior.values,
        'opaque': PlatformViewHitTestBehavior.opaque,
        'translucent': PlatformViewHitTestBehavior.translucent,
        'transparent': PlatformViewHitTestBehavior.transparent,
      },
      'RenderErrorBox': {
        'padding': RenderErrorBox.padding,
        'minimumWidth': RenderErrorBox.minimumWidth,
        'backgroundColor': RenderErrorBox.backgroundColor,
        'textStyle': RenderErrorBox.textStyle,
        'paragraphStyle': RenderErrorBox.paragraphStyle,
      },
      'ScrollDirection': {
        'values': ScrollDirection.values,
        'idle': ScrollDirection.idle,
        'forward': ScrollDirection.forward,
        'reverse': ScrollDirection.reverse,
      },
      'SelectionChangedCause': {
        'values': SelectionChangedCause.values,
        'tap': SelectionChangedCause.tap,
        'doubleTap': SelectionChangedCause.doubleTap,
        'longPress': SelectionChangedCause.longPress,
        'forcePress': SelectionChangedCause.forcePress,
        'keyboard': SelectionChangedCause.keyboard,
        'drag': SelectionChangedCause.drag,
      },
      'SystemMouseCursors': {
        'none': SystemMouseCursors.none,
        'basic': SystemMouseCursors.basic,
        'click': SystemMouseCursors.click,
        'text': SystemMouseCursors.text,
        'forbidden': SystemMouseCursors.forbidden,
        'grab': SystemMouseCursors.grab,
        'grabbing': SystemMouseCursors.grabbing,
        'horizontalDoubleArrow': SystemMouseCursors.horizontalDoubleArrow,
        'verticalDoubleArrow': SystemMouseCursors.verticalDoubleArrow,
      },
      'TableCellVerticalAlignment': {
        'values': TableCellVerticalAlignment.values,
        'top': TableCellVerticalAlignment.top,
        'middle': TableCellVerticalAlignment.middle,
        'bottom': TableCellVerticalAlignment.bottom,
        'baseline': TableCellVerticalAlignment.baseline,
        'fill': TableCellVerticalAlignment.fill,
      },
      'TextOverflow': {
        'values': TextOverflow.values,
        'clip': TextOverflow.clip,
        'fade': TextOverflow.fade,
        'ellipsis': TextOverflow.ellipsis,
        'visible': TextOverflow.visible,
      },
      'WrapAlignment': {
        'values': WrapAlignment.values,
        'start': WrapAlignment.start,
        'end': WrapAlignment.end,
        'center': WrapAlignment.center,
        'spaceBetween': WrapAlignment.spaceBetween,
        'spaceAround': WrapAlignment.spaceAround,
        'spaceEvenly': WrapAlignment.spaceEvenly,
      },
      'WrapCrossAlignment': {
        'values': WrapCrossAlignment.values,
        'start': WrapCrossAlignment.start,
        'end': WrapCrossAlignment.end,
        'center': WrapCrossAlignment.center,
      },
    };
