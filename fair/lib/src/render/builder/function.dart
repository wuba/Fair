/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
// ignore_for_file: omit_local_variable_types

import 'package:fair/src/extension.dart';
import 'package:fair/src/internal/error_tips.dart';
import 'package:fair/src/render/builder/common.dart';
import 'package:fair/src/render/domain.dart';
import 'package:flutter/material.dart';

/// Function逻辑处理
mixin FunctionDynamicBuilder on CommonDynamicBuilder {
 dynamic buildFairFunction(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    
    var name = map[tag];
    if(name != 'FairFunction') {
      throw Exception('这个不是一个 FairFunction 节点！');
    }
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