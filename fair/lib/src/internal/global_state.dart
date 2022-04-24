/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:flutter/foundation.dart' as foundation;

import '../type.dart';

/// Singleton instance to hold some data
class GlobalState {
  static final GlobalState _instance = GlobalState._();

  /// Control profile information such as logger
  bool? profile;
  static const Map<String, String> DEFAULT_BUNDLE_PATHS = {
    'undefined': 'assets/bundle/undefined.json',
  };

  /// Provide state proxy for [FairWidget] to manager state of Widget
  Map<String, FairDelegateBuilder>? _builder;

  static int _counter = 0;

  GlobalState._();

  factory GlobalState.instance() {
    return _instance;
  }

  void init(
    bool? profileEnable,
    Map<String, FairDelegateBuilder>? builder,
  ) {
    _counter = 0;
    profile = profileEnable;
    _builder = builder;
  }

  static String id(String? prefix) {
    return '$prefix#${GlobalState._counter++}';
  }

  static FairDelegateBuilder of(String? name) {
    final builders = GlobalState.instance()._builder;
    FairDelegateBuilder? b;
    if (builders != null && name != null) {
      b = builders[name];
    }
    return b ??= (_, d) => FairDelegate();
  }
}

void log(String? message, {int? wrapWidth}) {
  if (GlobalState.instance().profile==true) {
    if (!(message?.startsWith('[Fair]')??false)) {
      foundation.debugPrint('[Fair] $message');
    } else {
      foundation.debugPrint(message);
    }
  }
}
