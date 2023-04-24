/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'package:fair/src/extension.dart';
import 'package:fair/src/internal/bind_data.dart';
import 'package:fair/src/module/fair_module.dart';
import 'package:fair/src/render/base.dart';
import 'package:fair/src/render/builder/builder.dart';
import 'package:fair/src/render/domain.dart';
import 'package:fair/src/render/expression.dart';
import 'package:fair/src/render/property.dart';
import 'package:fair/src/widgets/component.dart';
import 'package:flutter/material.dart';

/// 通用逻辑处理
mixin CommonDynamicBuilder on DynamicBuilder {
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

  bool isSupportedNa(Map map) {
    var name = map[tag];
    return name != null;
  }

  dynamic replaceMethod(Map? methodMap, String? exp) {
    var body;
    if (methodMap != null && exp != null && isFuncExp(exp)) {
      body = methodMap[subFunctionName(exp)];
    }
    return body;
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

  dynamic pa0Value(
    dynamic input,
    Map? methodMap,
    BuildContext context,
    Domain? domain,
  ) {
    var pa = _position(input, context, methodMap, domain);
    var data = pa.data;
    if( data is FairValueNotifier) {
      return data.value;
    }

    return data;
  }  
}