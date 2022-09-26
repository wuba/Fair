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
          name: name, error: '$tag is not supported', url: bundle);
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
      throw ArgumentError('name=$name, fun=$fun, error=$e, $map');
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
}
