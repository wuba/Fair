import 'package:fair/fair.dart';
import 'package:fair_gallery/src/generated_module/flutter.bindings.dart';
import 'package:fair_gallery/src/widget/listenable_scope.dart';
import 'package:flutter/material.dart';

/// ListenableScopePlugin
mixin ListenableScopePlugin implements FairCommonPluginMixin {
  Future<dynamic> scrollController(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          var uniqueKey = requestMap['uniqueKey'];
          var type = requestMap['type'];
          var method = requestMap['method'];
          var parameter = requestMap['parameter'];
          var scrollController =
              ListenableScope.get(uniqueKey, type) as ScrollController?;
          if (scrollController != null) {
            switch (method) {
              case 'animateTo':
                var offset = parameter['offset'].toDouble();
                var duration = parameter['duration'];

                // 从 js 过来
                if (duration is! Duration) {
                  duration = Sugar.durationFromJs(duration);
                }
                var curve = parameter['curve'];

                // Curves.bounceIn
                if (curve is! Curve) {
                  curve = flutterComponents[curve.toString()];
                }
                scrollController.animateTo(
                  offset,
                  duration: duration,
                  curve: curve,
                );
                break;
              case 'jumpTo':
                scrollController.jumpTo(parameter.toDouble());
                break;
              case 'get':
                return Sugar.dartObjectToMap(scrollController);
              default:
            }
          }

          return null;
        },
      );

  Future<dynamic> animationController(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          var uniqueKey = requestMap['uniqueKey'];
          var type = requestMap['type'];
          var method = requestMap['method'];
          var parameter = requestMap['parameter'];
          var animationController =
              ListenableScope.get(uniqueKey, type) as AnimationController?;
          if (animationController != null) {
            switch (method) {
              case 'set':
                animationController.value = parameter?.toDouble();
                break;
              case 'get':
                return Sugar.dartObjectToMap(animationController);
              case 'reset':
                animationController.reset();
                break;
              case 'forward':
                animationController.forward(from: parameter?.toDouble());
                break;
              case 'reverse':
                animationController.reverse(from: parameter?.toDouble());
                break;
              case 'repeat':
                var min = parameter['min']?.toDouble();
                var max = parameter['max']?.toDouble();
                var reverse = parameter['reverse'] ?? false;
                var period = parameter['period'];
                // 从 js 过来
                if (period != null && period is! Duration) {
                  period = Sugar.durationFromJs(period);
                }
                animationController.repeat(
                  min: min,
                  max: max,
                  reverse: reverse,
                  period: period,
                );
                break;
              case 'animateBack':
              case 'animateTo':
                var target = parameter['target'].toDouble();

                var curve = parameter['curve'];
                // Curves.bounceIn
                if (curve is! Curve) {
                  curve = flutterComponents[curve.toString()];
                }
                var duration = parameter['duration'];
                // 从 js 过来
                if (duration != null && duration is! Duration) {
                  duration = Sugar.durationFromJs(duration);
                }
                if (method == 'animateBack') {
                  animationController.animateBack(
                    target,
                    duration: duration,
                    curve: curve,
                  );
                } else {
                  animationController.animateTo(
                    target,
                    duration: duration,
                    curve: curve,
                  );
                }

                break;
              // 自己根据情况实现
              case 'animateWith':
                // animationController.animateWith(Simulation());
                break;
              case 'stop':
                animationController.stop(canceled: parameter ?? true);
                break;
              // 不好实现
              // animationController.drive(child);
              // animationController.fling()
              // animationController.resync(vsync)
              default:
            }
          }

          return null;
        },
      );

  /// uniqueKey
  /// type
  /// method
  /// parameter
  Future<dynamic> tabController(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          var uniqueKey = requestMap['uniqueKey'];
          var type = requestMap['type'];
          var method = requestMap['method'];
          var parameter = requestMap['parameter'];
          var tabController =
              ListenableScope.get(uniqueKey, type) as TabController?;
          if (tabController != null) {
            switch (method) {
              case 'animateTo':
                tabController.animateTo(parameter);
                break;
              case 'set':
                tabController.index = parameter;
                break;
              case 'get':
                return Sugar.dartObjectToMap(tabController);
              default:
            }
          }

          return null;
        },
      );

  Future<dynamic> valueNotifier(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          var uniqueKey = requestMap['uniqueKey'];
          var type = requestMap['type'];
          var method = requestMap['method'];
          var parameter = requestMap['parameter'];
          var valueNotifier =
              ListenableScope.get(uniqueKey, type) as ValueNotifier?;
          if (valueNotifier != null) {
            switch (method) {
              case 'set':
                if (valueNotifier.value is double && parameter is! double) {
                  parameter = parameter.toDouble();
                }
                valueNotifier.value = parameter;
                break;
              case 'get':
                return Sugar.dartObjectToMap(valueNotifier);
              default:
            }
          }

          return null;
        },
      );
}
