/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair/src/type.dart';
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
  final String tag;
  final ProxyMirror proxyMirror;
  final String page;
  final BindingData bound;
  final String bundle;

  DynamicBuilder(this.tag, this.proxyMirror, this.page, this.bound,
      {this.bundle});

  dynamic convert(BuildContext context, Map map, Map methodMap);
}

class DynamicWidgetBuilder extends DynamicBuilder {
  DynamicWidgetBuilder(ProxyMirror proxyMirror, String page, BindingData bound,
      {String bundle})
      : super('className', proxyMirror, page, bound, bundle: bundle);

  @override
  dynamic convert(BuildContext context, Map map, Map methodMap, {Domain domain}) {
    assert(map != null, 'bundle map is null');
    var name = map[tag];
    print('name:$name');
    if (name == null) {
      return WarningWidget(
          name: name, error: '$tag is not supported', url: bundle);
    }
    try {
      var module = bound?.modules?.moduleOf(name)?.call();
      var isWidget = module?.isWidget ?? false;

      dynamic mapper = module;
      if (mapper == null) {
        mapper = bound?.functionOf(name) ?? bound.valueOf(name);
        if (mapper != null) {
          return _block(map, methodMap, context, domain, mapper, name, false,
              forceApply: true);
        }
      }
      if (mapper == null) {
        mapper = proxyMirror.componentOf(name);
        final internal = widgetNames.containsKey(name);
        isWidget = internal ? widgetNames[name] : true;
      }
      assert(mapper != null, '$name is not registered!');
      if (name == 'Sugar.mapEach') {
        return _buildSugarMapEach(mapper, map, methodMap, context);
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
      return WarningWidget(name: name, error: e, url: bundle);
    }
  }

  dynamic _block(
      Map map,
      Map methodMap,
      BuildContext ctx,
      Domain domain,
      dynamic fun,
      String name,
      bool widget, {
        bool forceApply = false,
      }) {
    var na = _named(name, map['na'], methodMap, ctx, domain);
    var pa = _positioned(map['pa'], methodMap, ctx, domain);
    final bind = widget && (na.binding || pa.binding);
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
      throw ArgumentError('name=$name, fun=$fun, error=$e, $map');
    }
  }

  W<List> _positioned(dynamic paMap, Map methodMap, BuildContext context, Domain domain) {
    var pa = [];
    var needBinding = false;
    if (paMap is List) {
      paMap.forEach((e) {
        if (e is Map) {
          pa.add(convert(context, e, methodMap, domain: domain));
        } else if (domain != null && domain.match(e)) {
          pa.add(domain.bindValue(e));
        } else if (e is String) {
          var r = proxyMirror.evaluate(context, bound, e);
          if (r.binding) {
            needBinding = true;
          }
          pa.add(r.data);
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
      Map methodMap,
      BuildContext context,
      Domain domain,
      ) {
    var na = <String, dynamic>{};
    var needBinding = false;
    if (naMap is Map) {
      naMap.entries.forEach((e) {
        if (e.value is Map) {
          if (tag == 'FairWidget' && e.key.toString() == 'data') {
            na[e.key] = e.value;
          } else {
            // 主要修改的地方，此处将目标函数代入到解析的过程中
            if (methodMap != null && e.value['className'] is String && methodMap[e.value['className']] is Map) {
              na[e.key] = convert(context,methodMap[e.value['className']], methodMap, domain: domain);
            }
            else {
              na[e.key] = convert(context, e.value, methodMap, domain: domain);
            }          }
        } else if (e.value is List) {
          var a = e.value as List;

          var children = [];
          a.forEach((e) {
            var item ;
            if (e is Map) {
              // 主要修改的地方，此处将目标函数代入到解析的过程中
              item = (methodMap != null && (e['className'] is String && methodMap[e['className']] is Map) ? convert(context, methodMap[e['className']], methodMap, domain: domain) : convert(context, e, methodMap, domain: domain));
            } else {
              if (e is String && domain != null && domain.match(e)) {
                item = domain.bindValue(e);
              } else {
                var body;
                if(methodMap != null && _isFuncExp(e) && (body = methodMap[_subFunctionName(e)]) != null){
                  item = convert(context, body, methodMap, domain: domain);
                }else{
                  item = e;
                }

              }
            }
            children.add(item);
          });
          na[e.key] = (children.asIteratorOf<Widget>()?.toList() ?? children);
        } else if (domain != null && domain.match(e)) {
          na[e.key] = domain.bindValue(e as String);
        } else if (e.value is String) {
          var r = proxyMirror.evaluate(context, bound, e.value);
          if (r.binding) {
            needBinding = true;
          }
          if (r.data is FairModule) {
            na[e.key] = (r.data as FairModule).onCreateComponent(context, null);
          } else {
            na[e.key] = r.data;
          }
        } else {
          na[e.key] = e.value;
        }
      });
    }
    na['\$'] = context;
    return W<Map<String, dynamic>>(na, needBinding);
  }

  List<Widget> _buildSugarMapEach(
      Function mapEach, Map map, Map methodMap, BuildContext context) {
    var source = pa0(map);
    var children = [];
    if (source is String) {
      var r = proxyMirror.evaluate(context, bound, source);
      if (r.data != null) {
        source = r.data;
      }
    }
    if (!(source is List)) {
      throw Exception('Sugar.mapEach has no valid source array');
    }
    if (source != null && source is List) {
      children = Domain(source).forEach(($, _) {
        return convert(context, pa1(map), methodMap, domain: $);
      });
    }
    var params = {
      'pa': [source, children]
    };
    return mapEach.call(params);
  }

  bool _isFuncExp(String exp){
    return FunctionExpression().hitTest(exp, '');
  }

  String _subFunctionName(String expFunc){
    if(_isFuncExp(expFunc)){
      return expFunc.substring(2,expFunc.length-1);
    }else{
      return expFunc;
    }
  }
}