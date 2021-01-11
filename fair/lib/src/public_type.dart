/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:flutter/widgets.dart';

import 'internal/fair_decoder.dart';
import 'widget.dart';

/// Custom router builder
typedef FairRouteBuilder = void Function(BuildContext context, String routeName,
    {Object arguments});

/// state delegate builder
typedef FairDelegateBuilder = FairDelegate Function(
    BuildContext context, Map<String, dynamic> data);
typedef FairModuleBuilder = FairModule Function();
typedef PropertyValue<T> = T Function();

/// Interface of bundle loader
abstract class BundleLoader {
  /// Load resource data into json object; The path can be either assets key or
  /// http url, both should stands for valid json resource.
  /// The `cache` argument indicate cache implementation.
  /// The `h` contains framework relative headers.
  Future<Map> onLoad(String path, FairDecoder decoder,
      {bool cache = true, Map<String, String> h});
}

/// Get context instance
BuildContext $(dynamic props) {
  var context = props['\$'];
  assert(context is BuildContext, 'Failed to get BuildContext');
  return context;
}
