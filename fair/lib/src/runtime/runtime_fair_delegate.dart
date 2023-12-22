/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:flutter/widgets.dart';

import 'fair_runtime_impl.dart';

abstract class RuntimeFairDelegate {
  FairState? _state;
  Runtime? runtime;

  final _bindValuesMap = <String, PropertyValue>{};
  final _bindFunctionsMap = <String, Function>{};
  final _valueMap = <String, ValueNotifier>{};

  void setRunTime(Runtime? runtime) {
    this.runtime = runtime;
  }

  String get pageName => key();

  void setState(VoidCallback fn);

  BuildContext? get context {
    return _state?.context;
  }

  Map<String, PropertyValue> bindValue() {
    bindBaseValue();
    return _bindValuesMap;
  }

  Map<String, Function> bindFunction() {
    bindBaseFunc();
    return _bindFunctionsMap;
  }

  String key();

  ///将绑定js端的方法绑定到当前位置
  void _bindAllFunc(Map data) {
    data.forEach((key, value) {
      _bindFunctionsMap
          .addAll({key: () => runtime?.invokeMethod(pageName, key, null)});
    });
  }

  ///绑定js端的数据，这个方法调用需要在js加载完成之后调用，否则会获取不成功
  ///这个地方需要同步调用，因为涉及到数据的绑定，只有将所有数据绑定成功之后，
  ///才能做接下来的操作
  Future<dynamic> bindAll(Map allVariables) async {
    var map = await runtime?.getBindVariableAndFunc(key());

    var s = map?['result'];
    var d;
    Map<dynamic, dynamic>? variables;
    List<dynamic>? func;
    if (s != null && (d = s['result']) != null) {
      variables = d['variable'];
    }
    _bindAllValue(variables);
    return Future.value(null);
  }

  ///将绑定JS端的变量绑定到当前位置
  void _bindAllValue(Map<dynamic, dynamic>? data) {
    data?.forEach((key, value) {
      _bindValuesMap[key] = () => createValueNotifier(key, value);
    });
  }

  dynamic createValueNotifier(key, value) {
    return _valueMap.putIfAbsent(key, () => ValueNotifier(value));
  }

  //获取js端的数据，刷新指定数据
  void notifyValue(Map values) {
    // values.forEach((key, value) {
    //   _valueMap[key]?.value = value;
    // });
    setState(() {});
  }

  void bindBaseFunc() {
    _bindFunctionsMap['runtimeInvokeMethod'] = (funcName, isMultiParams, [props]) {
      var arguments;
      if (props != null) {
        arguments = [];
        if (isMultiParams) {
          arguments.addAll(props);
        } else {
          arguments.add(props);
        }
      }
      return runtime?.invokeMethod(pageName, funcName, arguments);
    };
    _bindFunctionsMap['runtimeInvokeMethodSync'] = (funcName, [props]) {
      var arguments;
      if (props != null) {
        arguments = [];
        arguments.addAll(props);
      }
      return runtime?.invokeMethodSync(pageName, funcName, arguments);
    };
    _bindFunctionsMap['runtimeParseVar'] = (varNames) {
      return runtime?.variablesSync(pageName, varNames);
    };
  }

  void bindBaseValue() {
    _bindValuesMap.addAll({'_platform': () => 'Fair v$fairVersion'});
  }

  void didChangeDependencies() {
    runtime?.invokeMethodSync(pageName, 'onLoad', null);
  }

  void dispose() {
    runtime?.invokeMethod(pageName, 'onUnload', null);
    runtime?.invokeMethod(pageName, 'releaseJS', null);
  }
}
