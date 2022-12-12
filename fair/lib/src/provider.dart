/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair_version/fair_version.dart';
import 'package:flutter/foundation.dart';

import 'bloc/common.dart' as common;
import 'bloc/flow.dart' as flow;
import 'bloc/geometry.dart' as geometry;
import 'internal/global_state.dart';

class BindingProvider with $BindingImpl {
  final Map<String, dynamic> _binding = {};
  final Map<String, dynamic> _specialBinding = {
    ...common.provider(),
    ...geometry.provider(),
    ...flow.provider(),
  };
  var _loadedIndex = 0;

  dynamic loadTag(String? tag) {
    var spResult = _specialBinding[tag];
    if (spResult != null) {
      return spResult;
    }
    var result = _binding[tag];
    if (result != null) {
      return result;
    }
    if (_loadedIndex >= provider.length - 1) {
      return null;
    }
    for (var i = _loadedIndex; i < provider.length; i++) {
      var binder = provider[i]();
      result = binder[tag];
      _binding.addAll(binder);
      if (result != null) {
        return result;
      }
      _loadedIndex++;
    }
    return result;
  }

  Map<String, dynamic> get binding => _binding;

  bool preload(List<String>? tags) {
    tags?.forEach((element) {
      log('[Fair] preload $element...');
      loadTag(element);
    });
    if (tags == null) {
      debugPrint('[Fair] preload all components...');
      provider.forEach((p) => _binding.addAll(p()));
    }
    log('[Fair] preload completed');
    return true;
  }
}
