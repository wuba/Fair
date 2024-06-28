// flutterVersion = '3.13.9'
// dartVersion = '3.1.5'
// functionCount = 2
// ignore_for_file: deprecated_member_use, prefer_single_quotes, unused_element, unused_field, unused_import, unnecessary_import, implementation_imports, unused_shown_name, prefer_function_declarations_over_variables, void_checks, duplicate_import, no_duplicate_case_values
import 'package:flutter_staggered_grid_view/src/widgets/staggered_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/src/rendering/staggered_grid.dart';
import 'package:flutter_staggered_grid_view/src/widgets/staggered_grid_tile.dart';
import 'package:flutter_staggered_grid_view/src/widgets/masonry_grid_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_staggered_grid_view/src/rendering/sliver_simple_grid_delegate.dart';
import 'package:flutter_staggered_grid_view/src/widgets/sliver_masonry_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/src/icon_data.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/src/fa_icon.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:fair/fair.dart';

/// PackagesFunctionDynamicWidgetBuilder
mixin PackagesFunctionDynamicWidgetBuilder on DynamicWidgetBuilder {
  dynamic convertPackagesFunction(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    var name = map[tag];
    if (name == 'FairFunction') {
      var tag = FunctionDomain.getTag(map);
      switch (tag) {
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
        // typedef RatingChangeCallback = void Function(double rating)
        // package:smooth_star_rating_nsafe/smooth_star_rating.dart
        case 'void Function(double)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(double) builder = (p0) {
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
