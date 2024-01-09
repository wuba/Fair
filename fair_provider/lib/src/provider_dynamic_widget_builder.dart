import 'package:fair/src/render/builder.dart';
import 'package:fair/src/render/proxy.dart';
import 'package:fair/src/render/domain.dart';
import 'package:fair/src/internal/bind_data.dart';
import 'package:fair/src/type.dart';
import 'package:flutter/material.dart';

import 'fair_provider_core.dart';

class ProviderDynamicWidgetBuilder extends DynamicWidgetBuilder {
  ProviderDynamicWidgetBuilder(
      ProxyMirror? proxyMirror, String? page, BindingData? bound,
      {String? bundle})
      : super(proxyMirror, page, bound, bundle: bundle);

  @override
  dynamic convert(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    var name = map[tag];
    if (name == 'SugarProvider.consumerBuilder' ||
        name == 'SugarProvider.selectorBuilder') {
      return _buildFairSugarConsumerBuilder(
        context,
        map,
        methodMap,
        domain: domain,
      );
    } else if (name == 'SugarProvider.selector') {
      return _buildFairSugarSelector(
        context,
        map,
        methodMap,
        domain: domain,
      );
    } else if (name == 'SugarProvider.widgetBuilder') {
      return _buildFairSugarWidgetBuilder(
        context,
        map,
        methodMap,
        domain: domain,
      );
    }
    return super.convert(
      context,
      map,
      methodMap,
      domain: domain,
    );
  }

  dynamic _buildFairSugarConsumerBuilder(
      BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    dynamic source = pa0(map);
    assert(source is Map);
    List functionParameters = FunctionDomain.pa(source);
    FairConsumerBuilder builder = (builderContext, value, child) {
      return convert(
        context,
        source,
        methodMap,
        domain: FunctionDomain(
          {
            functionParameters[0]: builderContext,
            functionParameters[1]: value,
            functionParameters[2]: child,
          },
          parent: domain,
        ),
      );
    };
    return builder;
  }

  dynamic _buildFairSugarSelector(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    dynamic source = pa0(map);
    assert(source is Map);
    List functionParameters = FunctionDomain.pa(source);
    FairSelectorSelector selector = (builderContext, value) {
      return convert(
        context,
        source,
        methodMap,
        domain: FunctionDomain(
          {
            functionParameters[0]: builderContext,
            functionParameters[1]: value,
          },
          parent: domain,
        ),
      );
    };
    return selector;
  }

  dynamic _buildFairSugarWidgetBuilder(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    dynamic source = pa0(map);
    assert(source is Map);
    List functionParameters = FunctionDomain.pa(source);
    FairContextWidgetBuilder builder = (builderContext) {
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

}
