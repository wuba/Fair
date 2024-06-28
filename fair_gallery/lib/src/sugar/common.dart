// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:fair/fair.dart';
import 'package:fair_gallery/src/utils/repository.dart';
import 'package:fair_gallery/src/widget/share_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:flutter_highlight/themes/vs.dart' as vs;

class SugarCommon {
  SugarCommon._();
  static Container Function() returnContainer(Widget Function() input) {
    Container Function() builder = () {
      return input() as Container;
    };
    return builder;
  }

  static LoadStateChanged onImageStateChanged(
    Widget? Function(LoadState loadState) callback,
  ) {
    return (ExtendedImageState state) {
      return callback(state.extendedImageLoadState);
    };
  }

  static double colorComputeLuminance(Color color) {
    return color.computeLuminance();
  }

  static final List<Color> _color = <Color>[];
  static Color getRandomColor(int index) {
    while (_color.length <= index) {
      _color.add(Color.fromARGB(255, Random.secure().nextInt(255),
          Random.secure().nextInt(255), Random.secure().nextInt(255)));
    }

    return _color[index];
  }

  static Color getLuminanceColor(double luminance) {
    return luminance < 0.5 ? Colors.white : Colors.black;
  }

  static LikeButtonTapCallback likeButtonTapCallback(
    BuildContext context, {
    int? index,
  }) {
    return (bool isLiked) async {
      dynamic item;
      if (index != null) {
        LoadingMoreRepository repository =
            ShareDataWidget.of(context) as LoadingMoreRepository;
        item = repository[index];
      } else {
        item = ShareDataWidget.getValue(context, ['item']);
      }

      if (item != null) {
        item['is_favorite'] = !isLiked;
      }
      return !isLiked;
    };
  }

  static void Function() voidCallBack({
    required Function function,
    required dynamic value,
  }) {
    return () {
      function.call(value);
    };
  }

  static OnSlidingPage onSlidingPage(Function(bool) callBack) {
    return (ExtendedImageSlidePageState state) {
      callBack(state.isSliding);
    };
  }

  static LoadingMoreIndicatorBuilder loadingMoreIndicatorBuilder(
    List<SugarSwitchCaseObj<IndicatorStatus, Widget>> caseObjects, {
    Function? tryAgain,
    String? text,
    Color? backgroundColor,
    bool isSliver = false,
    Widget? emptyWidget,
  }) {
    return (
      BuildContext context,
      IndicatorStatus status,
    ) {
      for (SugarSwitchCaseObj<IndicatorStatus, Widget?> sugarCase
          in caseObjects) {
        if (sugarCase.sugarCase() == status) {
          return sugarCase.reValue();
        }
      }
      return IndicatorWidget(
        status,
        tryAgain: tryAgain,
        text: text,
        backgroundColor: backgroundColor,
        isSliver: isSliver,
        emptyWidget: emptyWidget,
      );
    };
  }

  static dynamic nullOrDefault(dynamic value, dynamic defaultValue) =>
      value ?? defaultValue;

  static Map<String, TextStyle> vsTheme() => vs.vsTheme;

  static bool isNull(dynamic value) => value == null;

  static List<T> mapForEachToList<T>(
    Map map,
    T Function(dynamic key, dynamic value) forEach,
  ) {
    final List<T> list = <T>[];
    map.forEach(forEach);
    return list;
  }

  static Map<String, dynamic> dartObjectToMap(dynamic dartObject) {
    // 可以增加自己的判断
    return Sugar.dartObjectToMap(dartObject);
  }
}
