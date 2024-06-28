// flutterVersion = '3.22.2'
// dartVersion = '3.4.3'
// functionCount = 50
// ignore_for_file: deprecated_member_use, prefer_single_quotes, unused_element, unused_field, unused_import, unnecessary_import, implementation_imports, unused_shown_name, prefer_function_declarations_over_variables, void_checks, duplicate_import, no_duplicate_case_values
import 'package:extended_text_library/extended_text_library.dart'
    as extended_text_library;
import 'package:oktoast/src/core/toast.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:highlight/highlight.dart' show highlight, Node;
import 'package:widget_with_codeview/widget_with_codeview.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selectable/selectable.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:widget_with_codeview/src/source_code_view.dart';
import 'package:string_scanner/string_scanner.dart';
import 'package:widget_with_codeview/src/syntax_highlighter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:http/http.dart';
import 'package:http_client_helper/http_client_helper.dart';
import 'dart:async';
import 'dart:ui' as ui show Codec;
import 'package:flutter/foundation.dart';
import 'package:extended_image_library/src/extended_image_provider.dart';
import 'dart:ui' as ui show Codec, ImmutableBuffer;
import 'package:flutter/widgets.dart' hide FileImage;
import 'package:extended_image_library/src/platform.dart';
import 'dart:typed_data';
import 'package:extended_image_library/src/extended_resize_image_provider.dart';
import 'package:flutter/painting.dart' hide imageCache;
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:extended_image_library/src/network/network_image_io.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:extended_image/src/image/raw_image.dart';
import 'package:extended_image/src/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:extended_image/src/extended_image.dart';
import 'package:extended_image/src/editor/crop_layer.dart';
import 'package:extended_image/src/editor/editor_utils.dart';
import 'package:extended_image/src/typedef.dart';
import 'package:extended_image/src/border_painter.dart';
import 'package:extended_image/src/gesture/gesture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/scheduler.dart';
import 'package:flutter/semantics.dart';
import 'package:extended_image/src/editor/editor.dart';
import 'package:extended_image/src/gesture/slide_page.dart';
import 'package:extended_image/src/gesture/slide_page_handler.dart';
import 'package:extended_image/src/gesture/utils.dart';
import 'package:extended_image/src/gesture/page_view/gesture_page_view.dart';
import 'package:extended_image/src/gesture_detector/official.dart';
import 'dart:math' as math;
import 'package:extended_image/src/gesture/page_view/rendering/sliver_fill.dart';
import 'dart:ui' as ui show Image;
import 'package:extended_image/src/image/render_image.dart';
import 'package:extended_image/src/image/painting.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:extended_sliver/src/element.dart';
import 'package:extended_sliver/src/rendering.dart';
import 'package:extended_text/extended_text.dart';
import 'package:extended_text_library/src/special_text_span.dart';
import 'package:extended_text_library/src/text_painter_helper.dart';
import 'package:extended_text_library/src/background_text_span.dart';
import 'package:extended_text_library/src/extended_widget_span.dart';
import 'package:extended_text_library/src/special_inline_span_base.dart';
import 'dart:ui' as ui show PlaceholderAlignment, ParagraphBuilder;
import 'dart:ui' as ui show PlaceholderAlignment;
import 'package:extended_text_library/src/extended_text_typedef.dart';
import 'package:extended_text_library/extended_text_library.dart';
import 'package:extended_text/src/extended/rendering/paragraph.dart';
import 'package:extended_text/src/extended/widgets/text_overflow_widget.dart';
import 'package:extended_text/src/extended/widgets/rich_text.dart';
import 'package:keframe/keframe.dart';
import 'dart:collection';
import 'dart:developer';
import 'package:keframe/src/logcat.dart';
import 'package:keframe/src/frame_separate_task.dart';
import 'package:keframe/src/layout_proxy.dart';
import 'package:keframe/src/size_cache_widget.dart';
import 'package:keframe/src/notification.dart';
import 'package:like_button/like_button.dart';
import 'package:like_button/src/painter/bubbles_painter.dart';
import 'package:like_button/src/painter/circle_painter.dart';
import 'package:like_button/src/utils/like_button_model.dart';
import 'package:like_button/src/utils/like_button_typedef.dart';
import 'package:like_button/src/utils/like_button_util.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:extended_list_library/src/typedef.dart';
import 'package:extended_list_library/src/extended_list_library.dart';
import 'package:extended_list_library/extended_list_library.dart';
import 'package:meta/meta.dart';
import 'package:loading_more_list_library/loading_more_list_library.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart' hide ViewportBuilder;
import 'package:waterfall_flow/src/rendering/sliver_waterfall_flow.dart';
import 'package:waterfall_flow/src/widgets/sliver.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:loading_more_list/src/empty_widget.dart';
import 'package:extended_list/extended_list.dart';
import 'package:loading_more_list/src/list_config/loading_more_list_config.dart';
import 'package:loading_more_list/src/indicator_widget.dart';
import 'package:loading_more_list/src/list_config/sliver_list_config.dart';
import 'package:loading_more_list/src/glow_notification_widget.dart';
import 'package:loading_more_list/src/list_config/list_config.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart' hide Overlay, OverlayEntry, OverlayState;
import 'package:oktoast/src/widget/animation/animation_builder.dart';
import 'package:oktoast/src/widget/overlay.dart';
import 'package:oktoast/src/core/position.dart';
import 'package:oktoast/src/core/toast_manager.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:flutter/cupertino.dart' show CupertinoDynamicColor;
import 'package:extended_tabs/extended_tabs.dart';
import 'package:sync_scroll_library/src/gesture/gesture_mixin.dart';
import 'package:sync_scroll_library/src/drag_hold_controller.dart';
import 'package:sync_scroll_library/src/sync/sync_controller.dart';
import 'package:sync_scroll_library/src/link/link_scroll_state.dart';
import 'package:sync_scroll_library/src/sync/sync_scroll_state.dart';
import 'package:sync_scroll_library/src/link/link_controller.dart';
import 'package:flutter/physics.dart' as physics;
import 'package:sync_scroll_library/src/gesture/gesture_state_mixin.dart';
import 'package:sync_scroll_library/sync_scroll_library.dart';
import 'package:extended_tabs/src/tab_bar.dart';
import 'package:extended_tabs/src/scrollable.dart';
import 'package:extended_tabs/src/tab_indicator.dart';
import 'package:extended_tabs/src/page_view.dart';
import 'package:fair/fair.dart';

/// PackagesFunctionDynamicWidgetBuilder
mixin PackagesFunctionDynamicWidgetBuilder on DynamicWidgetBuilder {
  dynamic convertPackagesFunction(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    var name = map[tag];
    if (name == 'FairFunction') {
      var tag = FunctionDomain.getTag(map);
      switch (tag) {
        // typedef EditorMaskColorHandler = Color Function(BuildContext context, bool pointerDown)
        // package:extended_image/src/typedef.dart
        case 'Color Function(BuildContext, bool)':
          List functionPaParameters = FunctionDomain.pa(map);
          Color Function(BuildContext, bool) builder = (p0, p1) {
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
        // typedef SlidePageBackgroundHandler = Color Function(Offset offset, Size pageSize)
        // package:extended_image/src/typedef.dart
        case 'Color Function(Offset, Size)':
          List functionPaParameters = FunctionDomain.pa(map);
          Color Function(Offset, Size) builder = (p0, p1) {
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
        // typedef InitEditorConfigHandler = EditorConfig? Function(ExtendedImageState? state)
        // package:extended_image/src/typedef.dart
        case 'EditorConfig? Function(ExtendedImageState?)':
          List functionPaParameters = FunctionDomain.pa(map);
          EditorConfig? Function(ExtendedImageState?) builder = (p0) {
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
        // typedef RefreshCallback = Future<bool> Function()
        // package:pull_to_refresh_notification/src/pull_to_refresh_notification.dart
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
        // typedef LikeButtonTapCallback = Future<bool?> Function(bool isLiked)
        // package:like_button/src/utils/like_button_typedef.dart
        case 'Future<bool?> Function(bool)':
          List functionPaParameters = FunctionDomain.pa(map);
          Future<bool?> Function(bool) builder = (p0) {
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
        // typedef TaskCallback<out T> = FutureOr<T> Function()
        // package:flutter/src/scheduler/binding.dart
        case 'FutureOr<Object> Function()':
          FutureOr<Object> Function() builder = () {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              domain,
            );
          };
          return builder;
        // typedef InitGestureConfigHandler = GestureConfig Function(ExtendedImageState state)
        // package:extended_image/src/typedef.dart
        case 'GestureConfig Function(ExtendedImageState)':
          List functionPaParameters = FunctionDomain.pa(map);
          GestureConfig Function(ExtendedImageState) builder = (p0) {
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
        // typedef LastChildLayoutTypeBuilder = LastChildLayoutType Function(int index)
        // package:extended_list_library/src/typedef.dart
        case 'LastChildLayoutType Function(int)':
          List functionPaParameters = FunctionDomain.pa(map);
          LastChildLayoutType Function(int) builder = (p0) {
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
        // typedef SlideOffsetHandler = Offset? Function(Offset offset, {ExtendedImageSlidePageState state})
        // package:extended_image/src/typedef.dart
        case 'Offset? Function(Offset, {ExtendedImageSlidePageState state})':
          List functionPaParameters = FunctionDomain.pa(map);
          Offset? Function(Offset, {ExtendedImageSlidePageState state})
              builder = (p0, {ExtendedImageSlidePageState? state}) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {functionPaParameters[0]: p0, 'state': state},
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef LoadingMoreItemBuilder<in T> = Widget Function(BuildContext context, T item, int index)
        // package:loading_more_list/src/list_config/loading_more_list_config.dart
        case 'Widget Function(BuildContext, dynamic, int)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, dynamic, int) builder = (p0, p1, p2) {
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
        // typedef ViewportBuilder = Widget Function(BuildContext context, ViewportOffset position)
        // package:flutter/src/widgets/scrollable.dart
        case 'Widget Function(BuildContext, ViewportOffset)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, ViewportOffset) builder = (p0, p1) {
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
        // typedef OKToastAnimationBuilder = Widget Function(BuildContext context, Widget child, AnimationController controller, double percent)
        // package:oktoast/src/widget/animation/animation_builder.dart
        case 'Widget Function(BuildContext, Widget, AnimationController, double)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(BuildContext, Widget, AnimationController, double)
              builder = (p0, p1, p2, p3) {
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
        // typedef PullToRefreshContainerBuilder = Widget Function(PullToRefreshScrollNotificationInfo? info)
        // package:pull_to_refresh_notification/src/pull_to_refresh_notification.dart
        case 'Widget Function(PullToRefreshScrollNotificationInfo?)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(PullToRefreshScrollNotificationInfo?) builder = (p0) {
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
        // typedef HeroBuilderForSlidingPage = Widget Function(Widget widget)
        // package:extended_image/src/typedef.dart
        case 'Widget Function(Widget)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget Function(Widget) builder = (p0) {
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
        // typedef LoadingMoreIndicatorBuilder = Widget? Function(BuildContext context, IndicatorStatus status)
        // package:loading_more_list/src/list_config/loading_more_list_config.dart
        case 'Widget? Function(BuildContext, IndicatorStatus)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget? Function(BuildContext, IndicatorStatus) builder = (p0, p1) {
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
        // typedef LoadStateChanged = Widget? Function(ExtendedImageState state)
        // package:extended_image/src/typedef.dart
        case 'Widget? Function(ExtendedImageState)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget? Function(ExtendedImageState) builder = (p0) {
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
        // typedef CountDecoration = Widget? Function(Widget count, int? likeCount)
        // package:like_button/src/utils/like_button_typedef.dart
        case 'Widget? Function(Widget, int?)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget? Function(Widget, int?) builder = (p0, p1) {
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
        // typedef LikeWidgetBuilder = Widget? Function(bool isLiked)
        // package:like_button/src/utils/like_button_typedef.dart
        case 'Widget? Function(bool)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget? Function(bool) builder = (p0) {
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
        // typedef LikeCountWidgetBuilder = Widget? Function(int? likeCount, bool isLiked, String text)
        // package:like_button/src/utils/like_button_typedef.dart
        case 'Widget? Function(int?, bool, String)':
          List functionPaParameters = FunctionDomain.pa(map);
          Widget? Function(int?, bool, String) builder = (p0, p1, p2) {
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
        // typedef ValueGetter<out T> = T Function()
        // package:flutter/src/foundation/basic_types.dart
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
        // typedef PaintBackground = bool Function(BackgroundTextSpan backgroundTextSpan, Canvas canvas, Offset offset, TextPainter? painter, Rect rect, {Offset? endOffset, TextPainter? wholeTextPainter})
        // package:extended_text_library/src/background_text_span.dart
        case 'bool Function(BackgroundTextSpan, Canvas, Offset, TextPainter?, Rect, {Offset? endOffset, TextPainter? wholeTextPainter})':
          List functionPaParameters = FunctionDomain.pa(map);
          bool Function(BackgroundTextSpan, Canvas, Offset, TextPainter?, Rect,
                  {Offset? endOffset, TextPainter? wholeTextPainter}) builder =
              (p0, p1, p2, p3, p4,
                  {Offset? endOffset, TextPainter? wholeTextPainter}) {
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
                  functionPaParameters[4]: p4,
                  'endOffset': endOffset,
                  'wholeTextPainter': wholeTextPainter
                },
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef BeforePaintImage = bool Function(Canvas canvas, Rect rect, Image image, Paint paint)
        // package:extended_image/src/typedef.dart
        case 'bool Function(Canvas, Rect, Image, Paint)':
          List functionPaParameters = FunctionDomain.pa(map);
          bool Function(Canvas, Rect, Image, Paint) builder = (p0, p1, p2, p3) {
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
        // typedef CanScrollPage = bool Function(GestureDetails? gestureDetails)
        // package:extended_image/src/typedef.dart
        case 'bool Function(GestureDetails?)':
          List functionPaParameters = FunctionDomain.pa(map);
          bool Function(GestureDetails?) builder = (p0) {
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

        case 'bool Function(ScrollNotification)':
          List functionPaParameters = FunctionDomain.pa(map);
          bool Function(ScrollNotification) builder = (p0) {
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
        // typedef SlideEndHandler = bool? Function(Offset offset, {ExtendedImageSlidePageState state, ScaleEndDetails details})
        // package:extended_image/src/typedef.dart
        case 'bool? Function(Offset, {ScaleEndDetails details, ExtendedImageSlidePageState state})':
          List functionPaParameters = FunctionDomain.pa(map);
          bool? Function(Offset,
                  {ScaleEndDetails details, ExtendedImageSlidePageState state})
              builder = (p0,
                  {ScaleEndDetails? details,
                  ExtendedImageSlidePageState? state}) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {
                  functionPaParameters[0]: p0,
                  'details': details,
                  'state': state
                },
                parent: domain,
              ),
            );
          };
          return builder;
        // typedef ScrollIncrementCalculator = double Function(ScrollIncrementDetails details)
        // package:flutter/src/widgets/scrollable_helpers.dart
        case 'double Function(ScrollIncrementDetails)':
          List functionPaParameters = FunctionDomain.pa(map);
          double Function(ScrollIncrementDetails) builder = (p0) {
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
        // typedef SlideScaleHandler = double? Function(Offset offset, {ExtendedImageSlidePageState state})
        // package:extended_image/src/typedef.dart
        case 'double? Function(Offset, {ExtendedImageSlidePageState state})':
          List functionPaParameters = FunctionDomain.pa(map);
          double? Function(Offset, {ExtendedImageSlidePageState state})
              builder = (p0, {ExtendedImageSlidePageState? state}) {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              FunctionDomain(
                {functionPaParameters[0]: p0, 'state': state},
                parent: domain,
              ),
            );
          };
          return builder;

        case 'dynamic Function(LikeButtonState)':
          List functionPaParameters = FunctionDomain.pa(map);
          dynamic Function(LikeButtonState) builder = (p0) {
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

        case 'dynamic Function(Size)':
          List functionPaParameters = FunctionDomain.pa(map);
          dynamic Function(Size) builder = (p0) {
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

        case 'int Function(int)':
          List functionPaParameters = FunctionDomain.pa(map);
          int Function(int) builder = (p0) {
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
        // typedef SemanticIndexCallback = int? Function(Widget widget, int localIndex)
        // package:flutter/src/widgets/scroll_delegate.dart
        case 'int? Function(Widget, int)':
          List functionPaParameters = FunctionDomain.pa(map);
          int? Function(Widget, int) builder = (p0, p1) {
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
        // typedef GestureTapCallback = void Function()
        // package:flutter/src/gestures/tap.dart
        case 'void Function()':
          void Function() builder = () {
            return pa0Value(
              FunctionDomain.getBody(map),
              methodMap,
              context,
              domain,
            );
          };
          return builder;
        // typedef OnSliverPinnedPersistentHeaderDelegateBuild = void Function(BuildContext context, double shrinkOffset, double? minExtent, double maxExtent, bool overlapsContent)
        // package:extended_sliver/src/widget.dart
        case 'void Function(BuildContext, double, double?, double, bool)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(BuildContext, double, double?, double, bool) builder =
              (p0, p1, p2, p3, p4) {
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
        // typedef AfterPaintImage = void Function(Canvas canvas, Rect rect, Image image, Paint paint)
        // package:extended_image/src/typedef.dart
        case 'void Function(Canvas, Rect, Image, Paint)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(Canvas, Rect, Image, Paint) builder = (p0, p1, p2, p3) {
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
        // typedef EditActionDetailsIsChanged = void Function(EditActionDetails? details)
        // package:extended_image/src/typedef.dart
        case 'void Function(EditActionDetails?)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(EditActionDetails?) builder = (p0) {
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
        // typedef DoubleTap = void Function(ExtendedImageGestureState state)
        // package:extended_image/src/typedef.dart
        case 'void Function(ExtendedImageGestureState)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(ExtendedImageGestureState) builder = (p0) {
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
        // typedef OnSlidingPage = void Function(ExtendedImageSlidePageState state)
        // package:extended_image/src/typedef.dart
        case 'void Function(ExtendedImageSlidePageState)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(ExtendedImageSlidePageState) builder = (p0) {
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
        // typedef GestureDetailsIsChanged = void Function(GestureDetails? details)
        // package:extended_image/src/typedef.dart
        case 'void Function(GestureDetails?)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(GestureDetails?) builder = (p0) {
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
        // typedef CollectGarbage = void Function(List<int> garbages)
        // package:extended_list_library/src/typedef.dart
        case 'void Function(List<int>)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(List<int>) builder = (p0) {
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
        // typedef GestureOffsetAnimationCallBack = void Function(Offset offset)
        // package:extended_image/src/typedef.dart
        case 'void Function(Offset)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(Offset) builder = (p0) {
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
        // typedef PointerEnterEventListener = void Function(PointerEnterEvent event)
        // package:flutter/src/services/mouse_tracking.dart
        case 'void Function(PointerEnterEvent)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(PointerEnterEvent) builder = (p0) {
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
        // typedef PointerExitEventListener = void Function(PointerExitEvent event)
        // package:flutter/src/services/mouse_tracking.dart
        case 'void Function(PointerExitEvent)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(PointerExitEvent) builder = (p0) {
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

        case 'void Function(TabController)':
          List functionPaParameters = FunctionDomain.pa(map);
          void Function(TabController) builder = (p0) {
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
        // typedef ValueChanged<in T> = void Function(T value)
        // package:flutter/src/foundation/basic_types.dart
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
        // typedef SpecialTextGestureTapCallback = void Function(dynamic parameter)
        // package:extended_text_library/src/extended_text_typedef.dart
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
        // typedef ValueChanged<in T> = void Function(T value)
        // package:flutter/src/foundation/basic_types.dart
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
        // typedef ViewportBuilder = void Function(int firstIndex, int lastIndex)
        // package:extended_list_library/src/typedef.dart
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

        default:
      }
    }
    return null;
  }
}
