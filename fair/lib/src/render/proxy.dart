/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:collection';

import 'package:fair/src/render/domain.dart';
import 'package:fair_version/fair_version.dart';
import 'package:flutter/widgets.dart';

import '../internal/bind_data.dart';
import '../provider.dart';
import 'base.dart';
import 'expression.dart';

class ProxyMirror with P {
  final _provider = BindingProvider();
  final List<Expression> _expressions = [
    ComponentExpression(),
    InlineExpression(),
    InlineObjectExpression(),
    WidgetParamExpression(),
    FunctionExpression(),
    GestureExpression(),
    PropValueExpression(),
    ValueExpression(),
  ];
  final SplayTreeMap<String,bool>  _generatedMapping = SplayTreeMap();

  void addGeneratedBinding(GeneratedModule? generated) {
    if (generated == null) {
      return;
    }
    _generatedMapping.addAll(generated.mapping());
    _provider.binding.addAll(generated.components());
  }

  bool preload(List<String> tags) {
    return _provider.preload(tags);
  }

  @override
  bool hasComponent(String key) => _provider.binding.containsKey(key);

  @override
  dynamic componentOf(String? key) => _provider.loadTag(key);

  bool isWidget(String? key) {
    return widgetNames[key] ?? _generatedMapping[key] ?? true;
  }

  W<dynamic> evaluate(
      BuildContext? context, BindingData? bindingData, String text, {Domain? domain}) {
    var pre = '';
    for (var exp in _expressions) {
      if (!exp.hitTest(text, pre)) {
        continue;
      }
      var result = exp.onEvaluate(this, bindingData, domain, text, pre);
      pre = result.exp??'';
      if (result.valid()) {
        return W<dynamic>(result.data, result.needBinding);
      }
    }
    return W<dynamic>(text, false);
  }
}
