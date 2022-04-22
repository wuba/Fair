/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

abstract class Transformer {
  List<String>? getImports();

  String onTransform(String data);
}

class DefaultTransformer implements Transformer {
  final List<String>? imports;
  static DefaultTransformer? _r;
  static DefaultTransformer? _g;

  DefaultTransformer(this.imports);

  factory DefaultTransformer.rendering() {
    return _r ?? (_r = DefaultTransformer(['package:flutter/rendering.dart']));
  }

  factory DefaultTransformer.gestures() {
    return _g ?? (_g = DefaultTransformer(['package:flutter/gestures.dart']));
  }

  @override
  List<String>? getImports() => imports;

  @override
  String onTransform(String data) => data;
}

class AppendTransformer extends DefaultTransformer {
  final List<String>? lines;

  AppendTransformer({List<String>? importList, this.lines}) : super(importList);

  @override
  String onTransform(String data) {
    var buffer = StringBuffer(data);
    lines?.forEach((element) {
      buffer.write(element);
    });
    return buffer.toString();
  }
}

class TransformProxy {
  /// 兼容生成代码的报错问题，主要是导包和可见性
  var compacts = {
    'basic': DefaultTransformer.rendering(),
    'floating_action_button': AppendTransformer(importList: [
      'package:flutter/rendering.dart'
    ], lines: [
      '''class _DefaultHeroTag {
  const _DefaultHeroTag();
  @override
  String toString() => '<default FloatingActionButton tag>';
}
      '''
    ]),
    'scaffold': DefaultTransformer.gestures(),
    'scroll_view': DefaultTransformer.gestures(),
    'single_child_scroll_view': DefaultTransformer.gestures(),
    'date_picker_deprecated': DefaultTransformer.gestures(),
    'drawer': DefaultTransformer.gestures(),
    'icon_button': DefaultTransformer.rendering(),
    'selectable_text': DefaultTransformer.gestures(),
    'switch': DefaultTransformer.gestures(),
    'tabs': DefaultTransformer.gestures(),
    'text_field': AppendTransformer(importList: [
      'package:flutter/gestures.dart',
    ], lines: [
      'import \'dart:ui\' as ui show BoxHeightStyle, BoxWidthStyle;'
    ]),
    'snack_bar': AppendTransformer(lines: [
      'const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);'
    ]),
    'paginated_data_table': AppendTransformer(
      importList: ['package:flutter/gestures.dart'],
      lines: ['const int defaultRowsPerPage = 10;'],
    ),
    'popup_menu':
        AppendTransformer(lines: ['const double _kMenuDividerHeight = 16.0;']),
    'viewport': DefaultTransformer.rendering(),
    'scrollable': DefaultTransformer.gestures(),
    'platform_view': DefaultTransformer.rendering(),
    'page_view': DefaultTransformer.gestures(),
    'nested_scroll_view': DefaultTransformer.gestures(),
    'navigation_toolbar': AppendTransformer(
      lines: ['const double kMiddleSpacing = 16.0;'],
    ),
    'list_wheel_scroll_view': DefaultTransformer.rendering(),
    'gesture_detector': DefaultTransformer.gestures(),
    'editable_text': AppendTransformer(
      importList: ['package:flutter/gestures.dart'],
      lines: ['import \'dart:ui\' as ui show BoxHeightStyle, BoxWidthStyle;'],
    ),
    'dismissible':
        AppendTransformer(importList: ['package:flutter/gestures.dart']),
    'actions': DefaultTransformer.rendering(),
    'viewport_offset': DefaultTransformer.rendering(),
    'mouse_cursor': DefaultTransformer.rendering(),
    'animated_size': DefaultTransformer.rendering(),
    'banner': AppendTransformer(lines: [
      ' const Color _kColor = Color(0xA0B71C1C);',
      'const double _kHeight = 12.0; // height of banner',
      '''
      const TextStyle _kTextStyle = TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: _kHeight * 0.85,
        fontWeight: FontWeight.w900,
        height: 1.0,
      );
      '''
    ]),
    // cupertino
    'activity_indicator': AppendTransformer(
        lines: ['const double _kDefaultIndicatorRadius = 10.0;']),
    'bottom_tab_bar': AppendTransformer(
      lines: [
        'const Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;',
        '''
        const Color _kDefaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
          color: Color(0x4C000000),
          darkColor: Color(0x29000000),
        );
        '''
      ],
    ),
    'button': AppendTransformer(
        lines: ['const double kMinInteractiveDimensionCupertino = 44.0;']),
    'nav_bar': AppendTransformer(lines: [
      'const Color _kDefaultNavBarBorderColor = Color(0x4D000000);',
      '''
      const Border _kDefaultNavBarBorder = Border(
        bottom: BorderSide(
          color: _kDefaultNavBarBorderColor,
          width: 0.0, // One physical pixel.
          style: BorderStyle.solid,
        ),
      );''',
      'const  _defaultHeroTag = "";'
    ]),
    'picker': AppendTransformer(lines: [
      'const double _kDefaultDiameterRatio = 1.07;',
      'const double _kSqueeze = 1.45;'
    ]),
    'refresh': AppendTransformer(lines: [
      'const double _defaultRefreshTriggerPullDistance = 100.0;',
      'const double _defaultRefreshIndicatorExtent = 60.0;',
      'var buildRefreshIndicator = CupertinoSliverRefreshControl.buildRefreshIndicator;',
    ]),
    'sliding_segmented_control': AppendTransformer(lines: [
      '''
      const CupertinoDynamicColor _kThumbColor = CupertinoDynamicColor.withBrightness(
        color: Color(0xFFFFFFFF),
        darkColor: Color(0xFF636366),
      );''',
      'const EdgeInsetsGeometry _kHorizontalItemPadding = EdgeInsets.symmetric(vertical: 2, horizontal: 3);',
    ]),
    'cupertino_text_field': AppendTransformer(lines: [
      '''
      // Value inspected from Xcode 11 & iOS 13.0 Simulator.
      const BorderSide _kDefaultRoundedBorderSide = BorderSide(
        color: CupertinoDynamicColor.withBrightness(
          color: Color(0x33000000),
          darkColor: Color(0x33FFFFFF),
        ),
        style: BorderStyle.solid,
        width: 0.0,
      );''',
      '''
      const Border _kDefaultRoundedBorder = Border(
        top: _kDefaultRoundedBorderSide,
        bottom: _kDefaultRoundedBorderSide,
        left: _kDefaultRoundedBorderSide,
        right: _kDefaultRoundedBorderSide,
      );
      ''',
      '''
      const BoxDecoration _kDefaultRoundedBorderDecoration = BoxDecoration(
        color: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white,
          darkColor: CupertinoColors.black,
        ),
        border: _kDefaultRoundedBorder,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      );
      '''
    ])
  };

  /// 不需要处理的源码组件（一般是未公开的内部组件）
  var skipSource = [
    '.g.dart', //model
    'input_date_range_picker.dart', //内部api
    'calendar_date_range_picker.dart', //内部api
    'date_picker_header.dart', //内部api
    'deprecated.dart', //废弃的api，不予支持
    '_io.dart', // 平台适配的api
    'list_wheel_viewport.dart', // 不常用
    'performance_overlay.dart',
    'animated_size',
    'widget_inspector.dart',// dart2js遇到WidgetInspector会崩溃
  ];

  /// 黑名单，不支持的属性
  var blackList = [
    'expandedHeaderPadding',
    'insetPadding',
    'layoutBuilder', // 不常用？
  ];

  List<String>? getImports(String className) {
    return compacts[className]?.getImports();
  }

  /// 不支持的属性，执行黑名单跳过
  bool isPropSupported(String? tag) => !blackList.contains(tag);

  List<String> getLines(String className, bool isCupertino) {
    var lines = <String>[];
    var t = compacts[className];
    if (t is AppendTransformer && t.lines != null) {
      lines.addAll(t.lines!);
    }
    if (isCupertino) {
      var t = compacts['cupertino_' + className];
      if (t is AppendTransformer && t.lines != null) {
        lines.addAll(t.lines!);
      }
    }
    return lines;
  }
}
