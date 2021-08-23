/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:flutter/foundation.dart';

class HelloWorldDelegate extends FairDelegate {
  final ValueNotifier<int> _count = ValueNotifier<int>(0);

  @override
  Map<String, Function> bindFunction() {
    var functions = super.bindFunction();
    functions.addAll({
      'onTapText': onTapText,
    });
    return functions;
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var pros = super.bindValue();
    pros.addAll({
      '_platform': () => 'Fair v$fairVersion',
      '_count': () => _count,
    });
    return pros;
  }

  void onTapText() {
    debugPrint('click ${_count.value}');
    _count.value++;
    setState(() {});
  }
}
