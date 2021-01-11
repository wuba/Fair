/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

export 'public_type.dart';

typedef FairWidgetBinding = Map<String, dynamic> Function();

/// Get positional arguments
dynamic pa(dynamic props, {int index = -1}) {
  var arguments = props['pa'];
  assert(arguments is List, 'Failed to get positional arguments');
  if (index >= 0) {
    assert((arguments as List).length > index,
        'Index out of range, please check about the positional arguments');
    return arguments[index];
  }
  return arguments;
}

dynamic pa0(dynamic props) => pa(props, index: 0);

dynamic pa1(dynamic props) => pa(props, index: 1);

dynamic pa2(dynamic props) => pa(props, index: 2);

dynamic pa3(dynamic props) => pa(props, index: 3);
