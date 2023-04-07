// ignore_for_file: omit_local_variable_types

/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair/src/type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../extension.dart';
import '../internal/bind_data.dart';
import '../internal/error_tips.dart';
import '../widgets/component.dart';
import '../widgets/version.dart';
import 'base.dart';
import 'domain.dart';
import 'expression.dart';
import 'property.dart';
import 'proxy.dart';

abstract class Binding {}

abstract class DynamicBuilder {
  final String? tag;
  final ProxyMirror? proxyMirror;
  final String? page;
  final BindingData? bound;
  final String? bundle;

  DynamicBuilder(this.tag, this.proxyMirror, this.page, this.bound,
      {this.bundle});

  dynamic convert(BuildContext context, Map map, Map methodMap);
}

class DynamicWidgetBuilder extends DynamicBuilder {
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
        return _buildFairFunction(context, map, methodMap, domain: domain);
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
        final internal = widgetNames.containsKey(name);
        isWidget = internal ? (widgetNames[name] ?? false) : true;
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

  dynamic block(
    Map map,
    Map? methodMap,
    BuildContext ctx,
    Domain? domain,
    dynamic fun,
    String name,
    bool widget, {
    bool forceApply = false,
  }) {
    var na = named(name, map['na'], methodMap, ctx, domain);
    var pa = positioned(map['pa'], methodMap, ctx, domain);
    // var arguments = map['arguments'];
    final bind = widget && (na.binding == true || pa.binding == true);
    try {
      fun = FairModule.cast(ctx, fun);
      if (forceApply || !bind) {
        return Function.apply(
            fun, [Property.extract(list: pa.data, map: na.data)], null);
      }
      return FairComponent(name, func: fun, na: na.data, pa: pa.data);
    } catch (e, stack) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        library: 'Fair Runtime',
        stack: stack,
        context: ErrorSummary('while parsing widget of $name, $fun'),
      ));
      throw ArgumentError('name===$name,fun===$fun, error===$e, map===$map');
    }
  }
  
  /// 处理多个位置参数
  W<List> positioned(
      dynamic paMap, Map? methodMap, BuildContext context, Domain? domain) {
    var pa = [];
    var needBinding = false;
    if (paMap is List) {
      paMap.forEach((e) {
        var value =_position(e, context, methodMap, domain);
        pa.add(value.data);
        needBinding = needBinding || (value.binding ?? false);
      });
    }
    return W<List>(pa, needBinding);
  }
  
  /// 处理单个位置参数
  W<dynamic> _position(dynamic e,BuildContext context, Map? methodMap, Domain? domain) {
    var pa;
    var needBinding = false;
    if (e is Map) {
      pa = convert(context, e, methodMap, domain: domain);
    } else if (e is List) {
      var list = positioned(e,methodMap,context,domain);
      needBinding = list.binding ?? false;
      pa = list.data.asIteratorOf<Widget>()?.toList() ?? list.data;
    } else if (domain != null && domain.match(e)) {
      pa = domain.bindValue(e);
    } else if (domain != null && e is MapEntry && domain.match(e.value)) {
      pa = domain.bindValue(e.value);
    } else if (e is String) {
      var r = proxyMirror?.evaluate(context, bound, e, domain: domain);
      if (r?.binding == true) {
        needBinding = true;
      }
      pa = r?.data;
    } else {
      pa = e;
    }
    return W<dynamic>(pa,needBinding);
  }

  W<Map<String, dynamic>> named(
    String tag,
    dynamic naMap,
    Map? methodMap,
    BuildContext context,
    Domain? domain,
  ) {
    var na = <String, dynamic>{};
    var needBinding = false;
    if (naMap is Map) {
      naMap.entries.forEach((e) {
        if (e.value is Map) {
          na[e.key] = namedMap(tag, naMap, methodMap, context, domain, e);
        } else if (e.value is List) {
          na[e.key] =
              namedList(tag, naMap, methodMap, context, domain, e.value);
        } else if (domain != null && domain.match(e)) {
          na[e.key] = domain.bindValue(e as String);
        } else if (domain != null && e is MapEntry && domain.match(e.value)) {
          na[e.key] = domain.bindValue(e.value);
        } else if (e.value is String) {
          var w = namedString(tag, naMap, methodMap, context, domain, e.value);
          needBinding = w.binding ?? false;
          na[e.key] = w.data;
        } else {
          na[e.key] = e.value;
        }
      });
    }
    na['\$'] = context;
    return W<Map<String, dynamic>>(na, needBinding);
  }

  dynamic namedMap(String tag, dynamic naMap, Map? methodMap,
      BuildContext context, Domain? domain, MapEntry e) {
    var result;
    if (tag == 'FairWidget' && e.key.toString() == 'data') {
      result = e.value;
    } else {
      var body;
      if ((body = replaceMethod(methodMap, e.value['className'])) != null) {
        result = convert(context, body, methodMap, domain: domain);
      } else {
        if (isSupportedNa(e.value)) {
          result = convert(context, e.value, methodMap, domain: domain);
        } else {
          result = e.value;
        }
      }
    }
    return result;
  }

  dynamic namedList(String tag, dynamic naMap, Map? methodMap,
      BuildContext context, Domain? domain, List v) {
    var children = [];
    v.forEach((e) {
      var item;
      if (e is Map) {
        var body;
        item = (body = replaceMethod(methodMap, e['className'])) != null
            ? convert(context, body, methodMap, domain: domain)
            : convert(context, e, methodMap, domain: domain);
      } else if (e is String) {
        if (domain != null && domain.match(e)) {
          item = domain.bindValue(e);
        } else {
          var body;
          if ((body = replaceMethod(methodMap, e)) != null) {
            item = convert(context, body, methodMap, domain: domain);
          } else {
            item = namedString(tag, naMap, methodMap, context, domain, e).data;
          }
        }
      } else {
        item = e;
      }
      children.add(item);
    });
    if (children.every((element) => element is Widget) == true) {
      return children.asIteratorOf<Widget>()?.toList() ?? children;
    }
    return children;
  }

  W namedString(String tag, dynamic naMap, Map? methodMap, BuildContext context,
      Domain? domain, String v) {
    var result;
    var needBinding = false;
    var body;
    if ((body = replaceMethod(methodMap, v)) != null) {
      result = convert(context, body, methodMap, domain: domain);
    } else {
      var r = proxyMirror?.evaluate(context, bound, v, domain: domain);
      if (r?.binding == true) {
        needBinding = true;
      }
      if (r?.data is FairModule) {
        result = (r?.data as FairModule).onCreateComponent(context, null);
      } else {
        result = r?.data;
      }
    }
    return W(result, needBinding);
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

  bool isFuncExp(String exp) {
    return FunctionExpression().hitTest(exp, '');
  }

  String subFunctionName(String expFunc) {
    if (isFuncExp(expFunc)) {
      return expFunc.substring(2, expFunc.length - 1);
    } else {
      return expFunc;
    }
  }

  dynamic replaceMethod(Map? methodMap, String? exp) {
    var body;
    if (methodMap != null && exp != null && isFuncExp(exp)) {
      body = methodMap[subFunctionName(exp)];
    }
    return body;
  }

  bool isSupportedNa(Map map) {
    var name = map[tag];
    return name != null;
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

  dynamic pa0Value(
    dynamic input,
    Map? methodMap,
    BuildContext context,
    Domain? domain,
  ) {
    var pa = _position(input, context, methodMap, domain);
    var data = pa.data;
    if(data is ValueNotifier) {
      return data.value;
    }
    return data;
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

  dynamic _buildFairFunction(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
   var functionTag = FunctionDomain.getTag(map);
   T Function() Function<T>() _builder = <T>(){
     T Function() builder=(){
       return pa0Value(
         FunctionDomain.getBody(map),        
         methodMap,
         context,
         domain,
       ) as T;
     };
     return builder;
   };

   List<T> Function() Function<T>() _listBuilder = <T>(){
     List<T> Function() builder=(){
       return (pa0Value(
         FunctionDomain.getBody(map),        
         methodMap,
         context,
         domain,
       ) as List).asListOf<T>()!;
     };
     return builder;
   };
       
    switch (functionTag) {
       case 'void Function()':
          return _builder<void>();       
       case 'int Function()':
          return _builder<int>();
       case 'int? Function()':
          return _builder<int?>();
       case 'double Function()':
          return _builder<double>();
       case 'double? Function()':
          return _builder<double?>();
       case 'String Function()':
          return _builder<String>();
       case 'String? Function()':
          return _builder<String?>();
       case 'bool Function()':
          return _builder<bool>();
       case 'bool? Function()':
          return _builder<bool?>();
       case 'Widget Function()':
          return _builder<Widget>();
       case 'Widget? Function()':
          return _builder<Widget?>();
       case 'List<int> Function()':
          return _listBuilder<int>();
       case 'List<int?> Function()':
          return _listBuilder<int?>();
       case 'List<double> Function()':
          return _listBuilder<double>();
       case 'List<double?> Function()':
          return _listBuilder<double?>();
       case 'List<String> Function()':
          return _listBuilder<String>();
       case 'List<String?> Function()':
          return _listBuilder<String?>();
       case 'List<bool> Function()':
          return _listBuilder<bool>();
       case 'List<bool?> Function()':
          return _listBuilder<bool?>();
       case 'List<Widget> Function()':
          return _listBuilder<Widget>();
       case 'List<Widget?> Function()':
          return _listBuilder<Widget?>();                      
       // typedef WidgetBuilder = Widget Function(BuildContext context)
       // package:flutter/src/widgets/framework.dart
       case 'Widget Function(BuildContext)':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget Function(BuildContext) builder = (p0) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index)
       // package:flutter/src/widgets/framework.dart
       case 'Widget Function(BuildContext, int)':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget Function(BuildContext, int) builder = (p0, p1) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef NullableIndexedWidgetBuilder = Widget? Function(BuildContext context, int index)
       // package:flutter/src/widgets/framework.dart
       case 'Widget? Function(BuildContext, int)':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget? Function(BuildContext, int) builder = (p0, p1) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef TransitionBuilder = Widget Function(BuildContext context, Widget? child)
       // package:flutter/src/widgets/framework.dart
       case 'Widget Function(BuildContext, Widget?)':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget Function(BuildContext, Widget?) builder = (p0, p1) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef GenerateAppTitle = String Function(BuildContext context)
       // package:flutter/src/widgets/app.dart
       case 'String Function(BuildContext)':
         List functionPaParameters = FunctionDomain.pa(map);
         String Function(BuildContext) builder = (p0) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef InputCounterWidgetBuilder = Widget? Function(BuildContext context, {required int currentLength, required int? maxLength, required bool isFocused})
       // package:flutter/src/material/text_field.dart
       case 'Widget? Function(BuildContext, {required int currentLength, required int? maxLength, required bool isFocused})':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget? Function(BuildContext,
                 {required int currentLength,
                 required bool isFocused,
                 required int? maxLength}) builder =
             (p0,
                 {required int currentLength,
                 required bool isFocused,
                 required int? maxLength}) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {
                 functionPaParameters[0]: p0,
                 'currentLength': currentLength,
                 'isFocused': isFocused,
                 'maxLength': maxLength
               },
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef ToolbarBuilder = Widget Function(BuildContext context, Widget child)
       // package:flutter/src/widgets/text_selection.dart
       case 'Widget Function(BuildContext, Widget)':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget Function(BuildContext, Widget) builder = (p0, p1) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef ReorderCallback = void Function(int oldIndex, int newIndex)
       // package:flutter/src/widgets/reorderable_list.dart
       case 'void Function(int, int)':
         List functionPaParameters = FunctionDomain.pa(map);
         void Function(int, int) builder = (p0, p1) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef ReorderItemProxyDecorator = Widget Function(Widget child, int index, Animation<double> animation)
       // package:flutter/src/widgets/reorderable_list.dart
       case 'Widget Function(Widget, int, Animation<double>)':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget Function(Widget, int, Animation<double>) builder =
             (p0, p1, p2) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {
                 functionPaParameters[0]: p0,
                 functionPaParameters[1]: p1,
                 functionPaParameters[2]: p2
               },
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef ExpansionPanelCallback = void Function(int panelIndex, bool isExpanded)
       // package:flutter/src/material/expansion_panel.dart
       case 'void Function(int, bool)':
         List functionPaParameters = FunctionDomain.pa(map);
         void Function(int, bool) builder = (p0, p1) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef ControlsWidgetBuilder = Widget Function(BuildContext context, ControlsDetails details)
       // package:flutter/src/material/stepper.dart
       case 'Widget Function(BuildContext, ControlsDetails)':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget Function(BuildContext, ControlsDetails) builder = (p0, p1) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef PopupMenuItemBuilder<out T> = List<PopupMenuEntry<T>> Function(BuildContext context)
       // package:flutter/src/material/popup_menu.dart
       case 'List<PopupMenuEntry<dynamic>> Function(BuildContext)':
         List functionPaParameters = FunctionDomain.pa(map);
         List<PopupMenuEntry<Object>> Function(BuildContext) builder = (p0) {
           return (pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0},
               parent: domain,
             ),
           ) as List).asListOf<PopupMenuEntry<Object>>()!;
         };
         return builder;
       // typedef DropdownButtonBuilder = List<Widget> Function(BuildContext context)
       // package:flutter/src/material/dropdown.dart
       case 'List<Widget> Function(BuildContext)':
         List functionPaParameters = FunctionDomain.pa(map);
         List<Widget> Function(BuildContext) builder = (p0) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef ExpansionPanelHeaderBuilder = Widget Function(BuildContext context, bool isExpanded)
       // package:flutter/src/material/expansion_panel.dart
       case 'Widget Function(BuildContext, bool)':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget Function(BuildContext, bool) builder = (p0, p1) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef AnimatedCrossFadeBuilder = Widget Function(Widget topChild, Key topChildKey, Widget bottomChild, Key bottomChildKey)
       // package:flutter/src/widgets/animated_cross_fade.dart
       case 'Widget Function(Widget, Key, Widget, Key)':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget Function(Widget, Key, Widget, Key) builder = (p0, p1, p2, p3) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {
                 functionPaParameters[0]: p0,
                 functionPaParameters[1]: p1,
                 functionPaParameters[2]: p2,
                 functionPaParameters[3]: p3
               },
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef ValueWidgetBuilder<in T> = Widget Function(BuildContext context, T value, Widget? child)
       // package:flutter/src/widgets/value_listenable_builder.dart
       case 'Widget Function(BuildContext, dynamic, Widget?)':
         List functionPaParameters = FunctionDomain.pa(map);
         Widget Function(BuildContext, dynamic, Widget?) builder =
             (p0, p1, p2) {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             FunctionDomain(
               {
                 functionPaParameters[0]: p0,
                 functionPaParameters[1]: p1,
                 functionPaParameters[2]: p2
               },
               parent: domain,
             ),
           );
         };
         return builder;
       // typedef WillPopCallback = Future<bool> Function()
       // package:flutter/src/widgets/navigator.dart
       case 'Future<bool> Function()':
         Future<bool> Function() builder = () {
           return pa0Value(
             FunctionDomain.getBody(map),
             methodMap,
             context,
             domain,
           );
         };
         return builder;
        // typedef StatefulWidgetBuilder = Widget Function(BuildContext context, void Function(void Function()) setState)
        // package:flutter/src/widgets/basic.dart
        case 'Widget Function(BuildContext, void Function(void Function()))':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, void Function(void Function()))
              builder = (p0, p1) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
                parent: domain,
              ),
            );
          };
          return builder;
       // typedef ImageFrameBuilder = Widget Function(BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded)
        // package:flutter/src/widgets/image.dart
        case 'Widget Function(BuildContext, Widget, int?, bool)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, Widget, int?, bool) builder =
              (p0, p1, p2, p3) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {
                  functionPaParameters[0]: p0,
                  functionPaParameters[1]: p1,
                  functionPaParameters[2]: p2,
                  functionPaParameters[3]: p3
                },
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef ImageLoadingBuilder = Widget Function(BuildContext context, Widget child, ImageChunkEvent? loadingProgress)
        // package:flutter/src/widgets/image.dart
        case 'Widget Function(BuildContext, Widget, ImageChunkEvent?)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, Widget, ImageChunkEvent?) builder =
              (p0, p1, p2) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {
                  functionPaParameters[0]: p0,
                  functionPaParameters[1]: p1,
                  functionPaParameters[2]: p2
                },
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef ImageErrorWidgetBuilder = Widget Function(BuildContext context, Object error, StackTrace? stackTrace)
        // package:flutter/src/widgets/image.dart
        case 'Widget Function(BuildContext, Object, StackTrace?)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, Object, StackTrace?) builder =
              (p0, p1, p2) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {
                  functionPaParameters[0]: p0,
                  functionPaParameters[1]: p1,
                  functionPaParameters[2]: p2
                },
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef NestedScrollViewHeaderSliversBuilder = List<Widget> Function(BuildContext context, bool innerBoxIsScrolled)
        // package:flutter/src/widgets/nested_scroll_view.dart
        case 'List<Widget> Function(BuildContext, bool)':
          List functionPaParameters = FunctionDomain.pa(map);
          List<Widget> Function(BuildContext, bool) builder = (p0, p1) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef ChildIndexGetter = int? Function(Key key)
        // package:flutter/src/widgets/sliver.dart
        case 'int? Function(Key)':
          List functionPaParameters = FunctionDomain.pa(map);
          int? Function(Key) builder = (p0) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {functionPaParameters[0]: p0},
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef ScrollableWidgetBuilder = Widget Function(BuildContext context, ScrollController scrollController)
        // package:flutter/src/widgets/draggable_scrollable_sheet.dart
        case 'Widget Function(BuildContext, ScrollController)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, ScrollController) builder = (p0, p1) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef LayoutWidgetBuilder = Widget Function(BuildContext context, BoxConstraints constraints); 
        // package:flutter/src/widgets/layout_builder.dart
        case 'Widget Function(BuildContext, BoxConstraints)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, BoxConstraints) builder = (p0, p1) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef OrientationWidgetBuilder = Widget Function(BuildContext context, Orientation orientation)
        // package:flutter/src/widgets/orientation_builder.dart
        case 'Widget Function(BuildContext, Orientation)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, Orientation) builder = (p0, p1) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef AnimatedSwitcherTransitionBuilder = Widget Function(Widget child, Animation<double> animation)
        // package:flutter/src/widgets/animated_switcher.dart
        case 'Widget Function(Widget, Animation<double>)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(Widget, Animation<double>) builder = (p0, p1) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef AnimatedSwitcherLayoutBuilder = Widget Function(Widget? currentChild, List<Widget> previousChildren)
        // package:flutter/src/widgets/animated_switcher.dart
        case 'Widget Function(Widget?, List<Widget>)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(Widget?, List<Widget>) builder = (p0, p1) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {functionPaParameters[0]: p0, functionPaParameters[1]: p1},
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef AnimatedTransitionBuilder = Widget Function(BuildContext context, Animation<double> animation, Widget? child)
        // package:flutter/src/widgets/dual_transition_builder.dart
        case 'Widget Function(BuildContext, Animation<double>, Widget?)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, Animation<double>, Widget?) builder =
              (p0, p1, p2) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {
                  functionPaParameters[0]: p0,
                  functionPaParameters[1]: p1,
                  functionPaParameters[2]: p2
                },
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef HeroFlightShuttleBuilder = Widget Function(BuildContext flightContext, Animation<double> animation, HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext)
        // package:flutter/src/widgets/heroes.dart
        case 'Widget Function(BuildContext, Animation<double>, HeroFlightDirection, BuildContext, BuildContext)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, Animation<double>, HeroFlightDirection,
              BuildContext, BuildContext) builder = (p0, p1, p2, p3, p4) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {
                  functionPaParameters[0]: p0,
                  functionPaParameters[1]: p1,
                  functionPaParameters[2]: p2,
                  functionPaParameters[3]: p3,
                  functionPaParameters[4]: p4
                },
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef HeroPlaceholderBuilder = Widget Function(BuildContext context, Size heroSize, Widget child)
        // package:flutter/src/widgets/heroes.dart
        case 'Widget Function(BuildContext, Size, Widget)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, Size, Widget) builder = (p0, p1, p2) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {
                  functionPaParameters[0]: p0,
                  functionPaParameters[1]: p1,
                  functionPaParameters[2]: p2
                },
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef AnimatedListItemBuilder = Widget Function(BuildContext context, int index, Animation<double> animation)
        // package:flutter/src/widgets/animated_list.dart
        case 'Widget Function(BuildContext, int, Animation<double>)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, int, Animation<double>) builder =
              (p0, p1, p2) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {
                  functionPaParameters[0]: p0,
                  functionPaParameters[1]: p1,
                  functionPaParameters[2]: p2
                },
                parent: domain,
              ),
            );
          };
          return builder;                             
       default:
    }
     

    assert(false,'$functionTag 回调没有找到对应的映射。请自定义 DynamicWidgetBuilder 并在其中增加对应映射');
    return WarningWidget(
          parentContext: context,
          name: 'FairFunction',
          error: '$functionTag 没有找到对应的映射。请自定义 DynamicWidgetBuilder 并在其中增加对应映射',
          url: bundle,
    );
  }
}
