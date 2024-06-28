// ignore_for_file: implementation_imports, prefer_function_declarations_over_variables, void_checks

import 'package:extended_image/extended_image.dart';
import 'package:fair_gallery/src/generated_module/app.function.dart';
import 'package:fair_gallery/src/generated_module/flutter.function.dart';
import 'package:fair_gallery/src/generated_module/packages.function.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:fair/fair.dart';
import 'package:fair/src/extension.dart';

class CustomDynamicWidgetBuilder extends DynamicWidgetBuilder
    with
        AppFunctionDynamicWidgetBuilder,
        PackagesFunctionDynamicWidgetBuilder,
        FlutterFunctionDynamicWidgetBuilder {
  CustomDynamicWidgetBuilder(
    super.proxyMirror,
    super.page,
    super.bound, {
    super.bundle,
  });

  @override
  dynamic convert(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    var name = map[tag];

    switch (name) {
      case 'FairFunction':
        var appFunction =
            convertAppFunction(context, map, methodMap, domain: domain);
        if (appFunction != null) {
          return appFunction;
        }
        var packagesFunction =
            convertPackagesFunction(context, map, methodMap, domain: domain);
        if (packagesFunction != null) {
          return packagesFunction;
        }
        var flutterFunction =
            convertFlutterFunction(context, map, methodMap, domain: domain);
        if (flutterFunction != null) {
          return flutterFunction;
        }
        var tag = FunctionDomain.getTag(map);
        switch (tag) {
          default:
        }
        break;
      // &
      case 'SugarBool.and':
        var p0 = pa0Value(pa0(map), methodMap, context, domain);
        if (!p0) {
          return false;
        }
        return pa0Value(
            FunctionDomain.getBody(pa1(map)), methodMap, context, domain);
      case 'SugarBool.inclusiveOr':
        var p0 = pa0Value(pa0(map), methodMap, context, domain);
        if (p0) {
          return true;
        }
        return pa0Value(
            FunctionDomain.getBody(pa1(map)), methodMap, context, domain);
      case 'SugarCommon.loadingMoreIndicatorBuilder':
        LoadingMoreIndicatorBuilder builder = (
          _,
          IndicatorStatus status,
        ) {
          var source = pa0(map);
          var na = named(name, map['na'], methodMap, context, domain);

          if (source is! List) {
            throw Exception(
                'SugarCommon.loadingMoreIndicatorBuilder has no valid cases array');
          }

          for (final caseItem in source) {
            final na = caseItem['na'];
            final sugarCase = pa0Value(FunctionDomain.getBody(na['sugarCase']),
                methodMap, context, domain);
            if (sugarCase == status) {
              return pa0Value(FunctionDomain.getBody(na['reValue']), methodMap,
                  context, domain);
            }
          }

          var props = na.data;
          return IndicatorWidget(
            status,
            tryAgain: props['tryAgain'],
            text: props['text'],
            backgroundColor: props['backgroundColor'],
            isSliver: props['isSliver'] ?? false,
            emptyWidget: props['emptyWidget'],
          );
        };
        return builder;
      case 'SugarCommon.onImageStateChanged':
        dynamic fairFunction = pa0(map);
        assert(fairFunction is Map);
        List functionParameters = FunctionDomain.pa(fairFunction);
        Widget? Function(ExtendedImageState state) builder = (state) {
          return convert(
            context,
            FunctionDomain.getBody(fairFunction),
            methodMap,
            domain: FunctionDomain(
              {
                functionParameters[0]: state.extendedImageLoadState,
              },
              parent: domain,
            ),
          );
        };
        return builder;
      case 'SugarCore.mapForEachToList':
        final source = pa0Value(pa0(map), methodMap, context, domain);
        var children = [];
        if (source is Map && source.isNotEmpty) {
          final fairFunction = pa1(map);
          // item
          final functionParameters = FunctionDomain.pa(fairFunction);
          assert(functionParameters.length == 2,
              'SugarCore.mapForEachToList 的域入参个数不对');
          for (final key in source.keys) {
            children.add(
              pa0Value(
                FunctionDomain.getBody(fairFunction),
                methodMap,
                context,
                FunctionDomain(
                  {
                    functionParameters[0]: key,
                    functionParameters[1]: source[key],
                  },
                  parent: domain,
                ),
              ),
            );
          }
        }

        children = children.asIteratorOf<Widget>()?.toList() ?? children;
        return children;
      default:
    }

    return super.convert(
      context,
      map,
      methodMap,
      domain: domain,
    );
  }

  dynamic getMapper(String name, BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    var module = bound?.modules?.moduleOf(name)?.call();
    dynamic mapper = module;
    mapper ??= bound?.functionOf(name) ?? bound?.valueOf(name);
    mapper ??= proxyMirror?.componentOf(name);
    return mapper;
  }
}
