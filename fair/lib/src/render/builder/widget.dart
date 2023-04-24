/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
// ignore_for_file: omit_local_variable_types

import 'package:fair/src/experiment/sugar.dart';
import 'package:fair/src/extension.dart';
import 'package:fair/src/internal/bind_data.dart';
import 'package:fair/src/internal/error_tips.dart';
import 'package:fair/src/render/builder/builder.dart';
import 'package:fair/src/render/builder/common.dart';
import 'package:fair/src/render/builder/function.dart';
import 'package:fair/src/render/domain.dart';
import 'package:fair/src/render/property.dart';
import 'package:fair/src/render/proxy.dart';
import 'package:fair/src/type.dart';
import 'package:fair_version/fair_version.dart';
import 'package:flutter/material.dart';

/// 特殊处理各种场景
/// DynamicBuilder 的实现
class DynamicWidgetBuilder extends DynamicBuilder with CommonDynamicBuilder, FunctionDynamicBuilder {
  DynamicWidgetBuilder(
      ProxyMirror? proxyMirror, String? page, BindingData? bound,
      {String? bundle})
      : super('className', proxyMirror, page, bound, bundle: bundle);

  @override
  dynamic convert(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    var name = map[tag];
    print('name:$name');
    if (name == null) {
      return WarningWidget(
          parentContext: context,
          name: name,
          error: '$tag is not supported',
          url: bundle);
    }
    try {
      if (name == 'Sugar.ifEqual') {
        return _buildIfEqual(map, methodMap, context, domain);
      } else if (name == 'Sugar.ifEqualBool') {
        return _buildIfEqualBool(map, methodMap, context, domain);
      } else if (name == 'Sugar.switchCase') {
        return _buildSwitchCase(map, methodMap, context, domain);
      } else if (name == 'Sugar.nullableIndexedWidgetBuilder') {
        return _buildSugarNullableIndexedWidgetBuilder(
          context,
          map,
          methodMap,
          domain: domain,
        );
      } else if (name == 'Sugar.indexedWidgetBuilder') {
        return _buildSugarIndexedWidgetBuilder(
          context,
          map,
          methodMap,
          domain: domain,
        );
      } else if (name == 'Sugar.widgetBuilder') {
        return _buildSugarWidgetBuilder(
          context,
          map,
          methodMap,
          domain: domain,
        );
      } else if (name == 'Sugar.transitionBuilder') {
        return _buildSugarTransitionBuilder(
          context,
          map,
          methodMap,
          domain: domain,
        );
      } else if (name == 'Sugar.nestedScrollViewHeaderSliversBuilder') {
        return _buildNestedScrollViewHeaderSlivers(
          map,
          methodMap,
          context,
          domain,
        );
      } else if (name == 'Sugar.popMenuButtonItemBuilder') {
        return _buildPopMenuButtonItemBuilder(
          map,
          methodMap,
          context,
          domain,
        );
      } else if(name == 'FairFunction') {
        return buildFairFunction(context, map, methodMap, domain: domain);
      } else if(name == 'Sugar.futureValue') {
        return _buildFutureValue(
          map,
          methodMap,
          context,
          domain,
        );
      } else if(name == 'Sugar.createFuture') {
        return _buildCreateFuture(
          map,
          methodMap,
          context,
          domain,
        );
      } else if(name =='Sugar.nullValue') {
        return null;
      }

      var module = bound?.modules?.moduleOf(name)?.call();
      var isWidget = module?.isWidget ?? false;
      dynamic mapper = module;
      if (mapper == null) {
        mapper = bound?.functionOf(name) ?? bound?.valueOf(name);
        if (mapper != null) {
          return block(map, methodMap, context, domain, mapper, name, false,
              forceApply: true);
        }
      }
      if (mapper == null) {
        mapper = proxyMirror?.componentOf(name);
        isWidget = proxyMirror?.isWidget(name) ?? true;
      }
      assert(mapper != null, '$name is not registered!');
      if (name == 'Sugar.mapEach') {
        return _buildSugarMapEach(mapper, map, methodMap, context, domain);
      } else if (name == 'Sugar.map') {
        return _buildSugarMap(mapper, map, methodMap, context, domain);
      } else if (name == 'Sugar.isButtonStyle') {
        return _buildSugarButtonStyle(mapper, map, methodMap, context);
      } else if (name == 'Sugar.sliverGridDelegateWithFixedCrossAxisCount') {
        return _buildSugarSliverGridDelegateWithFixedCrossAxisCount(
            mapper, map, methodMap, context);
      }

      var source = map['mapEach'];
      if (source != null && source is List) {
        List children=[];
       for (var i = 0; i < source.length; i++) {
         var element = source[i];
         children.add(
          block(map, methodMap, context, FunctionDomain({
            'item': element,
            'index': i,
          },parent: domain), mapper, name, isWidget)
         );
       }      
       return children.asListOf<Widget>() ?? children;
      }
      return block(map, methodMap, context, domain, mapper, name, isWidget);
    } catch (e) {
      return WarningWidget(
          parentContext: context,
          name: name,
          error: e,
          url: bundle,
          solution:
              "Tag name not supported yet,You need to use the @FairBinding annotation to tag the local Widget component");
    }
  }

 
  List<dynamic> _buildSugarMapEach(
    Function mapEach,
    Map map,
    Map? methodMap,
    BuildContext context,
    Domain? domain,
  ) {
    dynamic source = pa0Value(pa0(map), methodMap, context, domain);

    if (!(source is List)) {
      throw Exception('Sugar.mapEach has no valid source array');
    }
    var children = [];

    //转为Widget
    if (source is List) {
      var fairFunction = pa1(map);
      // index, item
      List functionParameters = FunctionDomain.pa(fairFunction);
      assert(functionParameters.length == 2, 'Sugar.mapEach 的域入参个数不对');

      for (var i = 0; i < source.length; i++) {
        var element = source[i];
        children.add(
          pa0Value(
            FunctionDomain.getBody(fairFunction),
            methodMap,
            context,
            FunctionDomain(
              {
                functionParameters[0]: i,
                functionParameters[1]: element,
              },
              parent: domain,
            ),
          ),
        );
      }
    }

    
    children = children.asIteratorOf<Widget>()?.toList() ?? children;

    var params = {
      'pa': [source, children]
    };
    return mapEach.call(params);
  }

  List<dynamic> _buildSugarMap(
    Function mapEach,
    Map map,
    Map? methodMap,
    BuildContext context,
    Domain? domain,
  ) {
    dynamic source = pa0Value(pa0(map), methodMap, context, domain);

    if (!(source is List)) {
      throw Exception('Sugar.mapEach has no valid source array');
    }

    var children = [];
    if (source is List) {
      var fairFunction = map['na']['builder'];
      // item
      var functionParameters = FunctionDomain.pa(fairFunction);
      assert(functionParameters.length == 1, 'Sugar.map 的域入参个数不对');
      for (var i = 0; i < source.length; i++) {
        var element = source[i];
        children.add(
          pa0Value(
            FunctionDomain.getBody(fairFunction),
            methodMap,
            context,
            FunctionDomain(
              {
                functionParameters[0]: element,
              },
              parent: domain,
            ),
          ),
        );
      }
    }

    
    children = children.asIteratorOf<Widget>()?.toList() ?? children;

    var params = {
      'pa': [source, children]
    };
    return mapEach.call(params);
  }

  dynamic _buildSwitchCase(
    Map map,
    Map? methodMap,
    BuildContext context,
    Domain? domain,
  ) {
    var caseValue = pa0(map);
    var source = pa1(map);

    if (caseValue != null) {
      caseValue = pa0Value(caseValue, methodMap, context, domain);
    }
    if (!(source is List)) {
      throw Exception('Sugar.SwitchCase has no valid cases array');
    }

    if (source is List) {
      for (var caseItem in source) {
        var na = caseItem['na'];
        if (pa0Value(FunctionDomain.getBody(na['sugarCase']), methodMap, context, domain) ==
            caseValue) {
          return pa0Value(FunctionDomain.getBody(na['reValue']), methodMap, context, domain);
        }
      }
    }

    var defaultValue = FunctionDomain.getBody(pa2(map));
    return pa0Value(defaultValue, methodMap, context, domain);
  }

  NestedScrollViewHeaderSliversBuilder _buildNestedScrollViewHeaderSlivers(
      Map map, Map? methodMap, BuildContext context, Domain? domain) {
    final dynamic fairFunction = pa0(map);
    assert(fairFunction is Map);
    final List functionParameters = FunctionDomain.pa(fairFunction);
    final NestedScrollViewHeaderSliversBuilder builder =
        (BuildContext builderContext, bool innerBoxIsScrolled) {
      final body = FunctionDomain.getBody(fairFunction);
      final List<Widget> list = <Widget>[];
      for (final element in body) {
        final widget = convert(
          context,
          element,
          methodMap,
          domain: FunctionDomain(
            {
              functionParameters[0]: builderContext,
              functionParameters[1]: innerBoxIsScrolled,
            },
            parent: domain,
          ),
        );
        list.add(widget as Widget);
      }
      return list;
    };
    return builder;
  }

  ButtonStyle _buildSugarButtonStyle(
      Function mapEach, Map map, Map? methodMap, BuildContext context) {
    var na = map['na'];
    var textStyle = na['textStyle'];
    if (null != textStyle) {
      textStyle = convert(context, textStyle, methodMap);
    }
    var backgroundColor = na['backgroundColor'];
    if (null != backgroundColor) {
      backgroundColor = convert(context, backgroundColor, methodMap);
    }
    var foregroundColor = na['foregroundColor'];
    if (null != foregroundColor) {
      foregroundColor = convert(context, foregroundColor, methodMap);
    }
    var overlayColor = na['overlayColor'];
    if (null != overlayColor) {
      overlayColor = convert(context, overlayColor, methodMap);
    }
    var shadowColor = na['shadowColor'];
    if (null != shadowColor) {
      shadowColor = convert(context, shadowColor, methodMap);
    }
    var surfaceTintColor = na['surfaceTintColor'];
    if (null != surfaceTintColor) {
      surfaceTintColor = convert(context, surfaceTintColor, methodMap);
    }
    var elevation = na['elevation'];
    if (null != elevation) {
      elevation = convert(context, elevation, methodMap);
    }
    var padding = na['padding'];
    if (null != padding) {
      padding = convert(context, padding, methodMap);
    }
    var minimumSize = na['minimumSize'];
    if (null != minimumSize) {
      minimumSize = convert(context, minimumSize, methodMap);
    }
    var fixedSize = na['fixedSize'];
    if (null != fixedSize) {
      fixedSize = convert(context, fixedSize, methodMap);
    }
    var maximumSize = na['maximumSize'];
    if (null != maximumSize) {
      maximumSize = convert(context, maximumSize, methodMap);
    }
    var side = na['side'];
    if (null != side) {
      side = convert(context, side, methodMap);
    }
    var shape = na['shape'];
    if (null != shape) {
      shape = convert(context, shape, methodMap);
    }
    var mouseCursor = na['mouseCursor'];
    if (null != mouseCursor) {
      mouseCursor = convert(context, mouseCursor, methodMap);
    }
    var visualDensity = na['visualDensity'];
    if (null != visualDensity) {
      visualDensity = convert(context, visualDensity, methodMap);
    }
    var tapTargetSize = na['tapTargetSize'];
    if (null != tapTargetSize) {
      tapTargetSize = convert(context, tapTargetSize, methodMap);
    }
    var animationDuration = na['animationDuration'];
    if (null != animationDuration) {
      animationDuration = convert(context, animationDuration, methodMap);
    }
    var enableFeedback = na['enableFeedback'];
    if (null != enableFeedback) {
      enableFeedback = convert(context, enableFeedback, methodMap);
    }
    var alignment = na['alignment'];
    if (null != alignment) {
      alignment = convert(context, alignment, methodMap);
    }
    var splashFactory = na['splashFactory'];
    if (null != splashFactory) {
      splashFactory = convert(context, splashFactory, methodMap);
    }
    var buttonStyle = Sugar.isButtonStyle(
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      overlayColor: overlayColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
    var params = {
      'pa': [na, buttonStyle]
    };
    return mapEach.call(params);
  }


  SliverGridDelegateWithFixedCrossAxisCount
      _buildSugarSliverGridDelegateWithFixedCrossAxisCount(
          Function mapEach, Map map, Map? methodMap, BuildContext context) {
    Map gridDelegateNa = map['na'];
    var gridProperty = <String, dynamic>{
      'crossAxisCount': gridDelegateNa['crossAxisCount'],
      'mainAxisSpacing': gridDelegateNa['mainAxisSpacing']?.toDouble() ?? 0.0,
      'crossAxisSpacing': gridDelegateNa['crossAxisSpacing']?.toDouble() ?? 0.0,
      'childAspectRatio': gridDelegateNa['childAspectRatio']?.toDouble() ?? 1.0,
    };
    var params = {
      'pa': [gridProperty]
    };
    return mapEach.call(params);
  }

  dynamic _buildIfEqual(
    Map map,
    Map? methodMap,
    BuildContext context,
    Domain? domain,
  ) {
    var na = map['na'];

    var p0 = pa0Value(pa0(map), methodMap, context, domain);
    var p1 = pa0Value(pa1(map), methodMap, context, domain);
    if (p0 == p1) {
      return pa0Value(FunctionDomain.getBody(na['trueValue']), methodMap, context, domain);
    } else {
      return pa0Value(FunctionDomain.getBody(na['falseValue']), methodMap, context, domain);
    }
  }

  dynamic _buildIfEqualBool(
    Map map,
    Map? methodMap,
    BuildContext context,
    Domain? domain,
  ) {
    var na = map['na'];

    if (pa0Value(pa0(map), methodMap, context, domain)) {
      return pa0Value(FunctionDomain.getBody(na['trueValue']), methodMap, context, domain);
    } else {
      return pa0Value(FunctionDomain.getBody(na['falseValue']), methodMap, context, domain);
    }
  }

  dynamic _buildSugarNullableIndexedWidgetBuilder(
      BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    dynamic fairFunction = pa0(map);
    assert(fairFunction is Map);
    List functionParameters = FunctionDomain.pa(fairFunction);
    NullableIndexedWidgetBuilder builder = (builderContext, index) {
      return convert(
        context,
        FunctionDomain.getBody(fairFunction),
        methodMap,
        domain: FunctionDomain(
          {
            functionParameters[0]: builderContext,
            functionParameters[1]: index,
          },
          parent: domain,
        ),
      );
    };
    return builder;
  }

  dynamic _buildSugarIndexedWidgetBuilder(
      BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    dynamic fairFunction = pa0(map);
    assert(fairFunction is Map);
    List functionParameters = FunctionDomain.pa(fairFunction);
    IndexedWidgetBuilder builder = (builderContext, index) {
      return convert(
        context,
        FunctionDomain.getBody(fairFunction),
        methodMap,
        domain: FunctionDomain(
          {
            functionParameters[0]: builderContext,
            functionParameters[1]: index,
          },
          parent: domain,
        ),
      );
    };
    return builder;
  }

  dynamic _buildSugarWidgetBuilder(
      BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    dynamic fairFunction = pa0(map);
    assert(fairFunction is Map);
    List functionParameters = FunctionDomain.pa(fairFunction);
    WidgetBuilder builder = (
      builderContext,
    ) {
      return convert(
        context,
        FunctionDomain.getBody(fairFunction),
        methodMap,
        domain: FunctionDomain(
          {
            functionParameters[0]: builderContext,
          },
          parent: domain,
        ),
      );
    };
    return builder;
  }

  dynamic _buildSugarTransitionBuilder(
      BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    dynamic fairFunction = pa0(map);
    assert(fairFunction is Map);
    List functionParameters = FunctionDomain.pa(fairFunction);
    TransitionBuilder builder = (builderContext, child) {
      return convert(
        context,
        FunctionDomain.getBody(fairFunction),
        methodMap,
        domain: FunctionDomain(
          {
            functionParameters[0]: builderContext,
            functionParameters[1]: child,
          },
          parent: domain,
        ),
      );
    };
    return builder;
  }
  
  dynamic _buildPopMenuButtonItemBuilder(Map map, Map? methodMap, BuildContext context, Domain? domain) {
    final dynamic fairFunction = pa0(map);
    assert(fairFunction is Map);
    final List functionParameters = FunctionDomain.pa(fairFunction);
    final PopupMenuItemBuilder<Object> builder =
        (BuildContext builderContext) {
      final body = FunctionDomain.getBody(fairFunction);
      final List<PopupMenuEntry<Object>> list = <PopupMenuEntry<Object>>[];
      for (final element in body) {
        final widget = convert(
          context,
          element,
          methodMap,
          domain: FunctionDomain(
            {
              functionParameters[0]: builderContext,
            },
            parent: domain,
          ),
        );
        list.add(widget as PopupMenuEntry<Object>);
      }
      return list;
    };
    return builder;    
  }
  
  dynamic _buildCreateFuture(Map map, Map? methodMap, BuildContext context, Domain? domain) {
      var na = named('Sugar.createFuture', map['na'], methodMap, context, domain);
      var props= Property.extract(map: na.data);
      // typeArguments
      var ta = map['ta'];
      if(ta != null) {
        // 暂时只支持单泛型
        var typeArgument= ta.toString().split(',').first;
        return createTResult(typeArgument, <T>() => Sugar.createFuture<T>(
            function: props['function'],
            futureId: props['futureId'],
            argument: props['argument'],
            callback: props['callback'],
        ),
        // 异步不可能回调 Widget 类型
        widgetSupport: false,
        );
      }
      return Sugar.createFuture(
            function: props['function'],
            futureId: props['futureId'],
            argument: props['argument'],
            callback: props['callback'],
      );
  }
  
  
  dynamic _buildFutureValue(Map map, Map? methodMap, BuildContext context, Domain? domain) {
      var pa = map['pa'];
      var value = pa==null? null: pa0Value(pa0(map), methodMap, context, domain);
      // typeArguments
      var ta = map['ta'];
      if(ta != null) {
        // 暂时只支持单泛型
        var typeArgument= ta.toString().split(',').first;
        return createTResult(typeArgument, <T>() => Future<T>.value(value));
      }
      // Future<dynamic>
      return Future.value(value);
  }
}
