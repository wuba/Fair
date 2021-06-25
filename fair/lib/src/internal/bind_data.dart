/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

import 'package:flutter/material.dart';

import '../module/module_registry.dart';
import '../render/expression.dart';
import '../type.dart';

class BindingData {
  // none-null
  final FairModuleRegistry modules;
  final Map<String, Function> _functions;
  final Map<String, PropertyValue> _values;
  Map data;
  final Set<LifeCircle> _boundValue = {};

  BindingData(this.modules,
      {this.data,
      Map<String, Function> functions,
      Map<String, PropertyValue> values})
      : _functions = functions,
        _values = values,
        super();

  dynamic bindDataOf(String key) {
    if (_values != null && _values[key] != null) {
      return Function.apply(_values[key], null);
    } else if (data != null && data[key] != null) {
      return data[key];
    }
    return functionOf(key);
  }

  dynamic runFunctionOf(String key, {String exp}) {
    var result = _functions['runtimeInvokeMethodSync'](key);
    var value = jsonDecode(result);
    return ValueNotifier(value['result']['result']);
  }

  dynamic bindFunctionOf(String props) {
    return () => _functions['runtimeInvokeMethod'](props);
  }


  Function functionOf(String key) {
    return _functions != null ? _functions[key] : null;
  }

  PropertyValue valueOf(String key) {
    return _values != null ? _values[key] : null;
  }

  dynamic dataOf(String key) {
    return data != null ? data[key] : null;
  }

  void addBindValue(LifeCircle value) {
    _boundValue.add(value);
  }

  void clear() {
    _boundValue.forEach((element) {
      element.detach();
    });
    _boundValue.clear();
    _values?.clear();
    _functions?.clear();
  }
}
