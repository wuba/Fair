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
          parentContext:context,name: name, error: '$tag is not supported', url: bundle);
    }
    try {
      var module = bound?.modules?.moduleOf(name)?.call();
      var isWidget = module?.isWidget ?? false;
      dynamic mapper = module;
      if (mapper == null) {
        mapper = bound?.functionOf(name) ?? bound?.valueOf(name);
        if (mapper != null) {
          return _block(map, methodMap, context, domain, mapper, name, false,
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
        return _buildSugarMapEach(mapper, map, methodMap, context);
      } else if (name == 'Sugar.map') {
        return _buildSugarMap(mapper, map, methodMap, context);
      } else if (name == 'Sugar.switchCase') {
        dynamic re = _buildSwitchCase(mapper, map, methodMap, context);
        return re;
      } else if (name == 'Sugar.listBuilder') {
        return _buildSugarListBuilder(
            name, domain, mapper, map, methodMap, context);
      }else if(name == 'Sugar.isNestedScrollViewHeaderSliversBuilder'){
        return _buildNestedScrollViewHeaderSlivers(mapper, map, methodMap, context);
      }else if(name == 'Sugar.isButtonStyle'){
        return _buildSugarButtonStyle(mapper, map, methodMap, context);
      }else if(name == 'Sugar.popMenuButton'){
        return _popupMenuBuilder(mapper, map, methodMap, context);
      }else if (name == 'Sugar.sliverChildBuilderDelegate') {
        return _buildSugarSliverChildBuilderDelegate(mapper, map, methodMap, context);
      }else if (name == 'Sugar.sliverGridDelegateWithFixedCrossAxisCount') {
        return _buildSugarSliverGridDelegateWithFixedCrossAxisCount(mapper, map, methodMap, context);
      }

      var source = map['mapEach'];
      if (source != null && source is List) {
        var children = Domain(source).forEach(($, _) {
          return _block(map, methodMap, context, $, mapper, name, isWidget);
        });
        return children.asListOf<Widget>() ?? children;
      }
      return _block(map, methodMap, context, domain, mapper, name, isWidget);
    } catch (e) {
           return WarningWidget(parentContext:context, name: name, error: e, url: bundle, solution:"Tag name not supported yet,You need to use the @FairBinding annotation to tag the local Widget component");
    }
  }

  dynamic _block(
    Map map,
    Map? methodMap,
    BuildContext ctx,
    Domain? domain,
    dynamic fun,
    String name,
    bool widget, {
    bool forceApply = false,
  }) {
    var na = _named(name, map['na'], methodMap, ctx, domain);
    var pa = _positioned(map['pa'], methodMap, ctx, domain);
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

  W<List> _positioned(
      dynamic paMap, Map? methodMap, BuildContext context, Domain? domain) {
    var pa = [];
    var needBinding = false;
    if (paMap is List) {
      paMap.forEach((e) {
        if (e is Map) {
          pa.add(convert(context, e, methodMap, domain: domain));
        } else if (domain != null && domain.match(e)) {
          pa.add(domain.bindValue(e));
        } else if (e is String) {
          var r = proxyMirror?.evaluate(context, bound, e);
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

  W<Map<String, dynamic>> _named(
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
          na[e.key] = _namedMap(tag, naMap, methodMap, context, domain, e);
        } else if (e.value is List) {
          na[e.key] =
              _namedList(tag, naMap, methodMap, context, domain, e.value);
        } else if (domain != null && domain.match(e)) {
          na[e.key] = domain.bindValue(e as String);
        } else if (e.value is String) {
          var w = _namedString(tag, naMap, methodMap, context, domain, e.value);
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

  dynamic _namedMap(String tag, dynamic naMap, Map? methodMap,
      BuildContext context, Domain? domain, MapEntry e) {
    var result;
    if (tag == 'FairWidget' && e.key.toString() == 'data') {
      result = e.value;
    } else {
      var body;
      if ((body = _replaceMethod(methodMap, e.value['className'])) != null) {
        result = convert(context, body, methodMap, domain: domain);
      } else {
        if (_isSupportedNa(e.value)) {
          result = convert(context, e.value, methodMap, domain: domain);
        } else {
          result = e.value;
        }
      }
    }
    return result;
  }

  dynamic _namedList(String tag, dynamic naMap, Map? methodMap,
      BuildContext context, Domain? domain, List v) {
    var children = [];
    v.forEach((e) {
      var item;
      if (e is Map) {
        var body;
        item = (body = _replaceMethod(methodMap, e['className'])) != null
            ? convert(context, body, methodMap, domain: domain)
            : convert(context, e, methodMap, domain: domain);
      } else if (e is String) {
        if (domain != null && domain.match(e)) {
          item = domain.bindValue(e);
        } else {
          var body;
          if ((body = _replaceMethod(methodMap, e)) != null) {
            item = convert(context, body, methodMap, domain: domain);
          } else {
            item = _namedString(tag, naMap, methodMap, context, domain, e).data;
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

  W _namedString(String tag, dynamic naMap, Map? methodMap,
      BuildContext context, Domain? domain, String v) {
    var result;
    var needBinding = false;
    var body;
    if ((body = _replaceMethod(methodMap, v)) != null) {
      result = convert(context, body, methodMap, domain: domain);
    } else {
      var r = proxyMirror?.evaluate(context, bound, v);
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
      Function mapEach, Map map, Map? methodMap, BuildContext context) {
    dynamic source = pa0(map);
    var children = [];
    if (source is String) {
      var r = proxyMirror?.evaluate(context, bound, source);
      if (r?.data != null) {
        source = r?.data;
      }
    }
    if (!(source is List)) {
      throw Exception('Sugar.mapEach has no valid source array');
    }

    if (source is List) {
      source = Domain(source).forEach(($, element) {
        if (element is Map) {
          return convert(context, element, methodMap, domain: $);
        } else {
          return element;
        }
      });
    }
    if (source is List) {
      children = Domain(source).forEach(($, _) {
        return convert(context, pa1(map), methodMap, domain: $);
      });
    }
    var params = {
      'pa': [source, children]
    };
    return mapEach.call(params);
  }

  List<Widget> _buildSugarMap(
      Function mapEach, Map map, Map? methodMap, BuildContext context) {
    var source = pa0(map);
    var children = [];
    if (source is String) {
      var r = proxyMirror?.evaluate(context, bound, source);
      if (r?.data != null) {
        source = r?.data;
      }
    }
    if (!(source is List)) {
      throw Exception('Sugar.mapEach has no valid source array');
    }

    if (source is List) {
      source = Domain(source).forEach(($, element) {
        if (element is Map) {
          return convert(context, element, methodMap, domain: $);
        } else {
          return element;
        }
      });
    }

    if (source is List) {
      children = Domain(source).forEach(($, _) {
        return convert(context, map['na']['builder'], methodMap, domain: $);
      });
    }
    var params = {
      'pa': [source, children]
    };
    return mapEach.call(params);
  }

  dynamic _buildSwitchCase(
      Function mapEach, Map map, Map? methodMap, BuildContext context) {
    var caseValue = pa0(map);
    var source = pa1(map);
    var defaultValue = pa2(map);
    var children = [];

    if (!(source is List)) {
      throw Exception('Sugar.SwitchCase has no valid cases array');
    }

    if (source is List) {
      children = Domain(source).forEach(($, element) {
        if (element is Map) {
          return convert(context, element, methodMap, domain: $);
        } else {
          return element;
        }
      });
    }
    var params = {
      'pa': [caseValue, children, defaultValue]
    };

    return mapEach.call(params);
  }

  PopupMenuButton _popupMenuBuilder(Function mapEach,
      Map map,
      Map? methodMap,
      BuildContext context){
    var propertyTransMap = Map.from(map);
    Map na = map['na'];
    var itemBuilder  = na['itemBuilder'];
    propertyTransMap['className']='PopupMenuButton';
    //刷新时
    if(itemBuilder is Function){
      var propertiesProvider = convert(context, propertyTransMap, methodMap);
      return mapEach.call({'pa': [ propertiesProvider]});
    }
    //第一次解析
    if(itemBuilder is List){
      var list = Domain(itemBuilder).forEach(($, element) {
        return convert(context, element, methodMap, domain: $) as Widget;
      });
      var children = list.map((e) => e as PopupMenuEntry<Object>).toList();
      na['itemBuilder'] = (BuildContext context) => children;
    }
    var propertiesProvider = convert(context, propertyTransMap, methodMap);
    var params = {
      'pa': [ propertiesProvider]
    };
    return mapEach.call(params);
  }
  
ListView _buildSugarListBuilder(String name, Domain? superDomain,
      Function mapEach, Map map, Map? methodMap, BuildContext context) {
      
    Map propertyTransMap = Map.from(map);

    Map naOrMap = map['na'];
    var itemBuilder = naOrMap['itemBuilder'];
    naOrMap.remove('itemBuilder');

    var na = _named(name, map['na'], methodMap, context, superDomain);
    var pa = _positioned(map['pa'], methodMap, context, superDomain);
    Map naMap = Property.extract(list: pa.data, map: na.data);

    propertyTransMap['className'] = 'ListView';
    propertyTransMap['na'] = naMap;
    var propertiesProvider = convert(context, propertyTransMap, methodMap);

    var count = naMap["itemCount"];
    var source = List<int>.generate(count, (i) => i + 1);
    Domain domain = Domain(source);
    var list = Domain(source).forEach(($, _) {
      return convert(context, itemBuilder, methodMap, domain: $) as Widget;
    });
    List<Widget> children = list.map((e) => e as Widget).toList();

    var params = {
      'pa': [children, propertiesProvider]
    };

    return mapEach.call(params);
  }

  NestedScrollViewHeaderSliversBuilder _buildNestedScrollViewHeaderSlivers (Function mapEach,
      Map map,
      Map? methodMap,
      BuildContext context){
    var na =map['na'];
    var innerBoxIsScrolled=na['innerBoxIsScrolled'];
    var headerSliverBuilder =na['headerSliverBuilder'];
    var source = List<int>.generate(headerSliverBuilder.length, (i) => i + 1);

    var list = Domain(source).forEach(($, index) {
      return convert(context, headerSliverBuilder[index-1], methodMap, domain:$) as Widget;
    });
    List<Widget> headerBuilder = list.map((e) => e as Widget).toList();
    var params = {
      'pa': [context,innerBoxIsScrolled,headerBuilder]
    };
    return mapEach.call(params);
  }
  ButtonStyle _buildSugarButtonStyle (Function mapEach,
      Map map,
      Map? methodMap,
      BuildContext context){
    var na =map['na'];
    var textStyle=na['textStyle'];
    if(null!=textStyle){
      textStyle=convert(context,textStyle , methodMap);
    }
    var backgroundColor=na['backgroundColor'];
    if(null!=backgroundColor){
      backgroundColor=convert(context,backgroundColor , methodMap);
    }
    var foregroundColor=na['foregroundColor'];
    if(null!=foregroundColor){
      foregroundColor=convert(context,foregroundColor , methodMap);
    }
    var overlayColor=na['overlayColor'];
    if(null!=overlayColor){
      overlayColor=convert(context,overlayColor , methodMap);
    }
    var shadowColor=na['shadowColor'];
    if(null!=shadowColor){
      shadowColor=convert(context,shadowColor , methodMap);
    }
    var surfaceTintColor=na['surfaceTintColor'];
    if(null!=surfaceTintColor){
      surfaceTintColor=convert(context,surfaceTintColor , methodMap);
    }
    var elevation=na['elevation'];
    if(null!=elevation){
      elevation=convert(context,elevation , methodMap);
    }
    var padding=na['padding'];
    if(null!=padding){
      padding=convert(context,padding , methodMap);
    }
    var minimumSize=na['minimumSize'];
    if(null!=minimumSize){
      minimumSize=convert(context,minimumSize , methodMap);
    }
    var fixedSize=na['fixedSize'];
    if(null!=fixedSize){
      fixedSize=convert(context,fixedSize , methodMap);
    }
    var maximumSize=na['maximumSize'];
    if(null!=maximumSize){
      maximumSize=convert(context,maximumSize , methodMap);
    }
    var side=na['side'];
    if(null!=side){
      side=convert(context,side , methodMap);
    }
    var shape=na['shape'];
    if(null!=shape){
      shape=convert(context,shape , methodMap);
    }
    var mouseCursor=na['mouseCursor'];
    if(null!=mouseCursor){
      mouseCursor=convert(context,mouseCursor , methodMap);
    }
    var visualDensity=na['visualDensity'];
    if(null!=visualDensity){
      visualDensity=convert(context,visualDensity , methodMap);
    }
    var tapTargetSize=na['tapTargetSize'];
    if(null!=tapTargetSize){
      tapTargetSize=convert(context,tapTargetSize , methodMap);
    }
    var animationDuration=na['animationDuration'];
    if(null!=animationDuration){
      animationDuration=convert(context,animationDuration , methodMap);
    }
    var enableFeedback=na['enableFeedback'];
    if(null!=enableFeedback){
      enableFeedback=convert(context,enableFeedback , methodMap);
    }
    var alignment=na['alignment'];
    if(null!=alignment){
      alignment=convert(context,alignment , methodMap);
    }
    var splashFactory=na['splashFactory'];
    if(null!=splashFactory){
      splashFactory=convert(context,splashFactory , methodMap);
    }
    var buttonStyle=Sugar.isButtonStyle(
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
      'pa': [na,buttonStyle]
    };
    return mapEach.call(params);
  }

  bool _isFuncExp(String exp) {
    return FunctionExpression().hitTest(exp, '');
  }

  String _subFunctionName(String expFunc) {
    if (_isFuncExp(expFunc)) {
      return expFunc.substring(2, expFunc.length - 1);
    } else {
      return expFunc;
    }
  }

  dynamic _replaceMethod(Map? methodMap, String? exp) {
    var body;
    if (methodMap != null && exp != null && _isFuncExp(exp)) {
      body = methodMap[_subFunctionName(exp)];
    }
    return body;
  }

  bool _isSupportedNa(Map map) {
    var name = map[tag];
    return name != null;
  }

  SliverChildBuilderDelegate _buildSugarSliverChildBuilderDelegate(
      Function mapEach,
      Map map,
      Map? methodMap,
      BuildContext context) {

    Map na = map['na'];
    var childCount = na['childCount'];
    var source = List<int>.generate(childCount, (i) => i + 1);
    var list = Domain(source).forEach(($, _) {//拿到所有itemBuilder对应的数组
      return convert(context, na['builder'], methodMap, domain:$) as Widget;
    });
    List<Widget> children = list.map((e) => e as Widget).toList();


    var params = {
      'pa': [context,children,childCount]
    };

    return mapEach.call(params);
  }

  SliverGridDelegateWithFixedCrossAxisCount _buildSugarSliverGridDelegateWithFixedCrossAxisCount(
      Function mapEach,
      Map map,
      Map? methodMap,
      BuildContext context) {
    Map gridDelegateNa = map['na'];
    double mainAxisSpacing = 0.0;
    double crossAxisSpacing = 0.0;
    double childAspectRatio = 1.0;
    var crossAxisCount = gridDelegateNa['crossAxisCount'];

    if (gridDelegateNa.containsKey('mainAxisSpacing') == true) {
      mainAxisSpacing = gridDelegateNa['mainAxisSpacing'];
    }
    if (gridDelegateNa.containsKey('crossAxisSpacing') == true) {
      crossAxisSpacing = gridDelegateNa['crossAxisSpacing'];
    }
    if (gridDelegateNa.containsKey('childAspectRatio') == true) {
      childAspectRatio = gridDelegateNa['childAspectRatio'];
    }
    Map<String, dynamic> gridProperty = {
      'crossAxisCount': crossAxisCount,
      'mainAxisSpacing': mainAxisSpacing,
      'crossAxisSpacing': crossAxisSpacing,
      'childAspectRatio': childAspectRatio,
    };
    var params = {
      'pa': [gridProperty]
    };

    return mapEach.call(params);
  }
}
