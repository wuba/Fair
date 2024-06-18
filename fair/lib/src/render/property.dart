/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/src/internal/bind_data.dart';
import 'package:fair/src/render/expression.dart';
import 'package:flutter/widgets.dart';

class Property {
  static Map<String, dynamic> combined(
    List<dynamic>? pa,
    Map<String, dynamic>? na,
  ) {
    final parameter = <String, dynamic>{};
    na?.forEach((key, value) {
      parameter[key] = value;
    });
    parameter['pa'] = pa;
    return parameter;
  }

  static Map<String, dynamic> extract({
    List<dynamic>? list,
    Map<String, dynamic>? map,
    Map<String, dynamic>? data,
  }) {
    final na = map ?? data;
    final pa = list ?? data?['pa'];
    final result = <String, dynamic>{};
    na?.forEach((key, value) {
      if (value is FairValueNotifier) {
        if (value is BindValueBuilder) {
          result[key] = value.value;
        } else {
          result[key] = value;
        }
      } else {
        result[key] = value;
      }
    });
    if (pa is List) {
      result['pa'] =
          pa.map((e) => e is FairValueNotifier ? e.value : e).toList();
    } else {
      result['pa'] = pa;
    }
    return result;
  }
}
