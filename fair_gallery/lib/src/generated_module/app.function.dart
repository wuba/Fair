// flutterVersion = '3.22.2'
// dartVersion = '3.4.3'
// functionCount = 25
// ignore_for_file: deprecated_member_use, prefer_single_quotes, unused_element, unused_field, unused_import, unnecessary_import, implementation_imports, unused_shown_name, prefer_function_declarations_over_variables, void_checks, duplicate_import, no_duplicate_case_values
import 'package:extended_text_library/extended_text_library.dart'
    as extended_text_library;
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fair_gallery/src/sugar/common.dart';
import 'package:fair_gallery/src/sugar/dart_core.dart';
import 'package:fair_gallery/src/sugar/extension.dart';
import 'package:fair_gallery/assets.dart';
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:fair_gallery/src/widget/share_data_widget.dart';
import 'package:fair_gallery/src/widget/push_to_refresh_header.dart';
import 'package:fair_gallery/src/widget/hero_widget.dart';
import 'package:fair_gallery/src/widget/image_grid.dart';
import 'package:fair_gallery/src/utils/repository.dart';
import 'package:fair_gallery/src/widget/frame_separate_widget.dart';
import 'package:fair_gallery/src/widget/source_code_view_button.dart';
import 'package:fair_gallery/src/widget/app_bar.dart';
import 'package:fair_gallery/src/widget/listenable_scope.dart';
import 'package:fair_gallery/src/utils/text/selection_area.dart';
import 'package:fair/fair.dart';

/// AppFunctionDynamicWidgetBuilder
mixin AppFunctionDynamicWidgetBuilder on DynamicWidgetBuilder {
  dynamic convertAppFunction(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    var name = map[tag];
    if (name == 'FairFunction') {
      var tag = FunctionDomain.getTag(map);
      switch (tag) {
        case 'Iterable<Object> Function(dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          Iterable<Object> Function(dynamic) builder = (p0) {
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

        case 'Listenable? Function(String, TickerProvider)':
          List functionPaParameters = FunctionDomain.pa(map);
          Listenable? Function(String, TickerProvider) builder = (p0, p1) {
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

        case 'String Function(Match)':
          List functionPaParameters = FunctionDomain.pa(map);
          String Function(Match) builder = (p0) {
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

        case 'String Function(String)':
          List functionPaParameters = FunctionDomain.pa(map);
          String Function(String) builder = (p0) {
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

        case 'dynamic Function(dynamic, dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          dynamic Function(dynamic, dynamic) builder = (p0, p1) {
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

        case 'dynamic Function(dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          dynamic Function(dynamic) builder = (p0) {
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

        case 'dynamic Function(dynamic, dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          dynamic Function(dynamic, dynamic) builder = (p0, p1) {
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

        case 'Widget Function()':
          Widget Function() builder = () {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              domain,
            );
          };
          return builder;
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

        case 'Widget? Function(LoadState)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget? Function(LoadState) builder = (p0) {
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

        case 'bool Function()':
          bool Function() builder = () {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              domain,
            );
          };
          return builder;

        case 'bool Function(dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          bool Function(dynamic) builder = (p0) {
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

        case 'bool Function(dynamic, dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          bool Function(dynamic, dynamic) builder = (p0, p1) {
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

        case 'dynamic Function()':
          dynamic Function() builder = () {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              domain,
            );
          };
          return builder;

        case 'dynamic Function(bool)':
          List functionPaParameters = FunctionDomain.pa(map);
          dynamic Function(bool) builder = (p0) {
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

        case 'dynamic Function(dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          dynamic Function(dynamic) builder = (p0) {
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

        case 'dynamic Function(dynamic, dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          dynamic Function(dynamic, dynamic) builder = (p0, p1) {
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

        case 'dynamic Function(int)':
          List functionPaParameters = FunctionDomain.pa(map);
          dynamic Function(int) builder = (p0) {
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

        case 'int Function(dynamic, dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          int Function(dynamic, dynamic) builder = (p0, p1) {
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

        case 'num Function(String)':
          List functionPaParameters = FunctionDomain.pa(map);
          num Function(String) builder = (p0) {
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

        case 'void Function(Map<dynamic, dynamic>)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(Map<dynamic, dynamic>) builder = (p0) {
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

        case 'void Function(String)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(String) builder = (p0) {
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

        case 'void Function(dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(dynamic) builder = (p0) {
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

        case 'void Function(dynamic, dynamic)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(dynamic, dynamic) builder = (p0, p1) {
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

        case 'void Function(int)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(int) builder = (p0) {
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

        default:
      }
    }
    return null;
  }
}
