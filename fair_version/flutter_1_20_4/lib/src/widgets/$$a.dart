/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:flutter/material.dart';

import 'utils.dart';

var p = () => {
      'AlwaysStoppedAnimation': (props) => AlwaysStoppedAnimation(
            props['pa'][0],
          ),
      'AnimationMax': (props) => AnimationMax(
            props['pa'][0],
            props['pa'][1],
          ),
      'AnimationMean': (props) => AnimationMean(
            left: props['left'],
            right: props['right'],
          ),
      'AnimationMin': (props) => AnimationMin(
            props['pa'][0],
            props['pa'][1],
          ),
      'CurvedAnimation': (props) => CurvedAnimation(
            parent: props['parent'],
            curve: props['curve'],
            reverseCurve: props['reverseCurve'],
          ),
      'ProxyAnimation': (props) => ProxyAnimation(
            props['pa'][0],
          ),
      'ReverseAnimation': (props) => ReverseAnimation(
            props['pa'][0],
          ),
      'TrainHoppingAnimation': (props) => TrainHoppingAnimation(
            props['pa'][0],
            props['pa'][1],
            onSwitchedTrain: props['onSwitchedTrain'],
          ),
      'AnimationBehavior': {
        'values': AnimationBehavior.values,
        'normal': AnimationBehavior.normal,
        'preserve': AnimationBehavior.preserve,
      },
      'AnimationController': (props) => AnimationController(
            value: props['value']?.toDouble(),
            duration: props['duration'],
            reverseDuration: props['reverseDuration'],
            debugLabel: props['debugLabel'],
            lowerBound: props['lowerBound']?.toDouble() ?? 0.0,
            upperBound: props['upperBound']?.toDouble() ?? 1.0,
            animationBehavior:
                props['animationBehavior'] ?? AnimationBehavior.normal,
            vsync: props['vsync'],
          ),
      'AnimationController.unbounded': (props) => AnimationController.unbounded(
            value: props['value']?.toDouble() ?? 0.0,
            duration: props['duration'],
            reverseDuration: props['reverseDuration'],
            debugLabel: props['debugLabel'],
            vsync: props['vsync'],
            animationBehavior:
                props['animationBehavior'] ?? AnimationBehavior.preserve,
          ),
      'AnimationStatus': {
        'values': AnimationStatus.values,
        'dismissed': AnimationStatus.dismissed,
        'forward': AnimationStatus.forward,
        'reverse': AnimationStatus.reverse,
        'completed': AnimationStatus.completed,
      },
      'Curves': {
        'linear': Curves.linear,
        'decelerate': Curves.decelerate,
        'fastLinearToSlowEaseIn': Curves.fastLinearToSlowEaseIn,
        'ease': Curves.ease,
        'easeIn': Curves.easeIn,
        'easeInToLinear': Curves.easeInToLinear,
        'easeInSine': Curves.easeInSine,
        'easeInQuad': Curves.easeInQuad,
        'easeInCubic': Curves.easeInCubic,
        'easeInQuart': Curves.easeInQuart,
        'easeInQuint': Curves.easeInQuint,
        'easeInExpo': Curves.easeInExpo,
        'easeInCirc': Curves.easeInCirc,
        'easeInBack': Curves.easeInBack,
        'easeOut': Curves.easeOut,
        'linearToEaseOut': Curves.linearToEaseOut,
        'easeOutSine': Curves.easeOutSine,
        'easeOutQuad': Curves.easeOutQuad,
        'easeOutCubic': Curves.easeOutCubic,
        'easeOutQuart': Curves.easeOutQuart,
        'easeOutQuint': Curves.easeOutQuint,
        'easeOutExpo': Curves.easeOutExpo,
        'easeOutCirc': Curves.easeOutCirc,
        'easeOutBack': Curves.easeOutBack,
        'easeInOut': Curves.easeInOut,
        'easeInOutSine': Curves.easeInOutSine,
        'easeInOutQuad': Curves.easeInOutQuad,
        'easeInOutCubic': Curves.easeInOutCubic,
        'easeInOutQuart': Curves.easeInOutQuart,
        'easeInOutQuint': Curves.easeInOutQuint,
        'easeInOutExpo': Curves.easeInOutExpo,
        'easeInOutCirc': Curves.easeInOutCirc,
        'easeInOutBack': Curves.easeInOutBack,
        'fastOutSlowIn': Curves.fastOutSlowIn,
        'slowMiddle': Curves.slowMiddle,
        'bounceIn': Curves.bounceIn,
        'bounceOut': Curves.bounceOut,
        'bounceInOut': Curves.bounceInOut,
        'elasticIn': Curves.elasticIn,
        'elasticOut': Curves.elasticOut,
        'elasticInOut': Curves.elasticInOut,
      },
    };
