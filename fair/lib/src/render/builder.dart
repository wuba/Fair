
// ignore_for_file: omit_local_variable_types

/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';
import 'dart:developer' as developer;
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
  @mustCallSuper
  dynamic convert(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    var name = map[tag];
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
      } else if (name == 'Sugar.listBuilder') {
        return _buildSugarListBuilder(
            name, domain, mapper, map, methodMap, context);
      } else if (name == 'Sugar.isNestedScrollViewHeaderSliversBuilder') {
        return _buildNestedScrollViewHeaderSlivers(
          mapper,
          map,
          methodMap,
          context,
          domain,
        );
      } else if (name == 'Sugar.isButtonStyle') {
        return _buildSugarButtonStyle(mapper, map, methodMap, context);
      } else if (name == 'Sugar.popMenuButton') {
        return _popupMenuBuilder(
          mapper,
          map,
          methodMap,
          context,
          domain,
        );
      } else if (name == 'Sugar.sliverChildBuilderDelegate') {
        return _buildSugarSliverChildBuilderDelegate(
          name,
          mapper,
          map,
          methodMap,
          context,
          domain,
        );
      } else if (name == 'Sugar.sliverGridDelegateWithFixedCrossAxisCount') {
        return _buildSugarSliverGridDelegateWithFixedCrossAxisCount(
            mapper, map, methodMap, context);
      }

      var source = map['mapEach'];
      if (source != null && source is List) {
        var children = MapEachDomain(
          source,
          parent: domain,
        ).forEach(($, _) {
          return block(map, methodMap, context, $, mapper, name, isWidget);
        });
        return children.asListOf<Widget>() ?? children;
      }
      return block(map, methodMap, context, domain, mapper, name, isWidget);
    } catch (e, stack) {
      return WarningWidget(
          parentContext: context,
          name: name,
          error: e,
          url: bundle,
          stackTrace: stack.toString(),
          errorBlock: map,
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
    var ta = map['typeArgumentList'];
    // var arguments = map['arguments'];
    final bind = widget && (na.binding == true || pa.binding == true);
    try {
      fun = FairModule.cast(ctx, fun);
      if (forceApply || !bind) {
        if (ta != null) {
          var properties = <String, dynamic>{};
          properties['pa'] = pa.data;
          properties.addAll(na.data);
          properties['ta'] = ta;
          return Function.apply(
              fun, [Property.extract(data: properties)], null);
        } else {
          return Function.apply(
              fun, [Property.extract(list: pa.data, map: na.data)], null);
        }
      }
      return FairComponent(name, func: fun, na: na.data, pa: pa.data);
    } catch (e, stack) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        library: 'Fair Runtime',
        stack: stack,
        context: ErrorSummary('while parsing widget of $name, $fun'),
      ));

      //print StackTrack in console
      _dumpErrorToConsole(name, map, e, stack);

      rethrow;
    }
  }

  void _dumpErrorToConsole(String name, Map map, Object e, StackTrace stack) {
    var encoder = JsonEncoder.withIndent('  ');
    final formattedJson = encoder.convert(map);

    final errorFormatText = '''
      
      ══╡ EXCEPTION CAUGHT BY FAIR RUNTIME ╞══════════════════════════════════════════════════════════════
      Error Tag:$name, while parsing:
      
$formattedJson
      
      $e
      
      When the exception was thrown, this was the stack:
      ''';

    developer.log('', error: errorFormatText, level: 900, stackTrace: stack);
  }

  W<List> positioned(
      dynamic paMap, Map? methodMap, BuildContext context, Domain? domain) {
    var pa = [];
    var needBinding = false;
    if (paMap is List) {
      paMap.forEach((e) {
        if (e is Map) {
          pa.add(convert(context, e, methodMap, domain: domain));
        } else if (domain != null && domain.match(e)) {
          pa.add(domain.bindValue(e));
        } else if (domain != null && e is MapEntry && domain.match(e.value)) {
          pa.add(domain.bindValue(e.value));
        } else if (e is String) {
          var r = proxyMirror?.evaluate(context, bound, e, domain: domain);
          if (r?.binding == true) {
            needBinding = true;
          }
          pa.add(r?.data);
        } else {
          pa.add(e);
        }
      });
    }
    return W<List>(pa, needBinding);
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

  List<Widget> _buildSugarMapEach(
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
      var itemBuilder = pa1(map);
      // index, item
      List functionParameters = FunctionDomain.pa(itemBuilder);
      assert(functionParameters.length == 2, 'Sugar.mapEach 的域入参个数不对');

      for (var i = 0; i < source.length; i++) {
        var element = source[i];
        children.add(
          convert(
            context,
            itemBuilder,
            methodMap,
            domain: FunctionDomain(
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
    var params = {
      'pa': [source, children]
    };
    return mapEach.call(params);
  }

  List<Widget> _buildSugarMap(
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
      var itemBuilder = map['na']['builder'];
      // item
      var functionParameters = FunctionDomain.pa(itemBuilder);
      assert(functionParameters.length == 1, 'Sugar.map 的域入参个数不对');
      for (var i = 0; i < source.length; i++) {
        var element = source[i];
        children.add(
          convert(
            context,
            itemBuilder,
            methodMap,
            domain: FunctionDomain(
              {
                functionParameters[0]: element,
              },
              parent: domain,
            ),
          ),
        );
      }
    }
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
        if (pa0Value(na['sugarCase'], methodMap, context, domain) == caseValue) {
          return pa0Value(na['reValue'], methodMap, context, domain);
        }
      }
    }

    var defaultValue = pa2(map);
    return pa0Value(defaultValue, methodMap, context, domain);
  }

  PopupMenuButton _popupMenuBuilder(Function mapEach, Map map, Map? methodMap,
      BuildContext context, Domain? domain) {
    var propertyTransMap = Map.from(map);
    Map na = map['na'];
    var itemBuilder = na['itemBuilder'];
    propertyTransMap['className'] = 'PopupMenuButton';
    //刷新时
    if (itemBuilder is Function) {
      var propertiesProvider = convert(context, propertyTransMap, methodMap);
      return mapEach.call({
        'pa': [propertiesProvider]
      });
    }
    //第一次解析
    if (itemBuilder is List) {
      var list =
          MapEachDomain(itemBuilder, parent: domain).forEach(($, element) {
        return convert(context, element, methodMap, domain: $) as Widget;
      });
      var children = list.map((e) => e as PopupMenuEntry<Object>).toList();
      na['itemBuilder'] = (BuildContext context) => children;
    }
    var propertiesProvider = convert(context, propertyTransMap, methodMap);
    var params = {
      'pa': [propertiesProvider]
    };
    return mapEach.call(params);
  }

  ListView _buildSugarListBuilder(
    String name,
    Domain? domain,
    Function mapEach,
    Map map,
    Map? methodMap,
    BuildContext context,
  ) {
    var propertyTransMap = Map.from(map);

    var naOrMap = {};
    if (map['na'] != null) {
      naOrMap.addAll(map['na']);
    }
    var itemBuilder = naOrMap['itemBuilder'];
    naOrMap.remove('itemBuilder');

    var na = named(name, naOrMap, methodMap, context, domain);
    var pa = positioned(map['pa'], methodMap, context, domain);
    Map naMap = Property.extract(list: pa.data, map: na.data);

    propertyTransMap['className'] = 'ListView';
    propertyTransMap['na'] = naMap;
    var propertiesProvider = convert(context, propertyTransMap, methodMap);

    var count = naMap['itemCount'];
    var source = List<int>.generate(count, (i) => i + 1);
    var list = MapEachDomain(source, parent: domain).forEach(($, _) {
      return convert(context, itemBuilder, methodMap, domain: $) as Widget;
    });
    var children = list.map((e) => e as Widget).toList();
    var params = {
      'pa': [children, propertiesProvider]
    };

    return mapEach.call(params);
  }

  NestedScrollViewHeaderSliversBuilder _buildNestedScrollViewHeaderSlivers(
      Function mapEach,
      Map map,
      Map? methodMap,
      BuildContext context,
      Domain? domain) {
    var na = map['na'];
    var innerBoxIsScrolled = na['innerBoxIsScrolled'];
    var headerSliverBuilder = na['headerSliverBuilder'];
    var source = List<int>.generate(headerSliverBuilder.length, (i) => i + 1);

    var list = MapEachDomain(source, parent: domain).forEach(($, index) {
      return convert(context, headerSliverBuilder[index - 1], methodMap,
          domain: $) as Widget;
    });
    List<Widget> headerBuilder = list.map((e) => e as Widget).toList();
    var params = {
      'pa': [context, innerBoxIsScrolled, headerBuilder]
    };
    return mapEach.call(params);
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

  SliverChildBuilderDelegate _buildSugarSliverChildBuilderDelegate(
      String name,
      Function mapEach,
      Map map,
      Map? methodMap,
      BuildContext context,
      Domain? domain) {
    var naOrMap = {};
    if (map['na'] != null) {
      naOrMap.addAll(map['na']);
    }
    naOrMap.remove('builder');
    var naPre = named(name, naOrMap, methodMap, context, domain);
    var paPre = positioned(map['pa'], methodMap, context, domain);
    Map naMap = Property.extract(list: paPre.data, map: naPre.data);

    Map na = map['na'];
    var childCount = naMap['childCount'];
    var builder = na['builder'];
    Map builderMap = <String, dynamic>{};

    //函数传入处理
    if (methodMap != null && methodMap.keys.isNotEmpty) {
      methodMap.keys.forEach((element) {
        if (builder is String && builder.contains(element)) {
          builderMap = methodMap[element];
        }
      });
    }
    // 常规
    if (builderMap.isEmpty) {
      builderMap = na['builder'];
    }

    var source = List<int>.generate(childCount, (i) => i + 1);

    var list = MapEachDomain(source, parent: domain).forEach(($, _) {
      //拿到所有itemBuilder对应的数组
      return convert(context, builderMap, methodMap, domain: $) as Widget;
    });
    List<Widget> children = list.map((e) => e as Widget).toList();

    var params = {
      'pa': [context, children, childCount]
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
      return pa0Value(na['trueValue'], methodMap, context, domain);
    } else {
      return pa0Value(na['falseValue'], methodMap, context, domain);
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
      return pa0Value(na['trueValue'], methodMap, context, domain);
    } else {
      return pa0Value(na['falseValue'], methodMap, context, domain);
    }
  }

  dynamic pa0Value(
    dynamic input,
    Map? methodMap,
    BuildContext context,
    Domain? domain,
  ) {
    var pa = positioned([input], methodMap, context, domain);
    var values = Property.extract(
      list: pa.data,
    );
    return pa0(values);
  }

  dynamic _buildSugarNullableIndexedWidgetBuilder(
      BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    dynamic source = pa0(map);
    assert(source is Map);
    List functionParameters = FunctionDomain.pa(source);            
    NullableIndexedWidgetBuilder builder = (builderContext, index) {
      return convert(
        context,
        source,
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
    dynamic source = pa0(map);
    assert(source is Map);
    List functionParameters = FunctionDomain.pa(source);            
    IndexedWidgetBuilder builder = (builderContext, index) {
      return convert(
        context,
        source,
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
    dynamic source = pa0(map);
    assert(source is Map);
    List functionParameters = FunctionDomain.pa(source);    
    WidgetBuilder builder = (
      builderContext,
    ) {
      return convert(
        context,
        source,
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
    dynamic source = pa0(map);
    assert(source is Map);
    List functionParameters = FunctionDomain.pa(source);    
    TransitionBuilder builder = (builderContext, child) {
      return convert(
        context,
        source,
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
}
