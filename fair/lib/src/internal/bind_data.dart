/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

import 'package:flutter/material.dart';

import '../module/module_registry.dart';
import '../render/domain.dart';
import '../render/expression.dart';
import '../render/proxy.dart';
import '../type.dart';

/// 区别于 ValueNotifier
class FairValueNotifier<T> extends ValueNotifier<T> {
  FairValueNotifier(T value) : super(value);
}

class BindingData {
  // none-null
  final FairModuleRegistry? modules;
  final Map<String, Function>? _functions;
  final Map<String, PropertyValue>? _values;
  Map? data;
  final Set<LifeCircle> _boundValue = {};

  BindingData(this.modules,
      {this.data,
      Map<String, Function>? functions,
      Map<String, PropertyValue>? values,
      Map<String, PropertyValue>? delegateValues})
      : _functions = functions,
        _values = values,
        super();

  dynamic bindDataOf(String key) {
    if (_values != null && _values![key] != null) {
      return Function.apply(_values![key]!, null);
    } else if (data != null && data![key] != null) {
      return data![key];
    }
    return functionOf(key);
  }

  dynamic runFunctionOf(String funcName, ProxyMirror? proxyMirror,
      BindingData? bound, Domain? domain,
      {String? exp}) {
    if (_functions?[funcName] == null) {
      var result;
      if (RegExp(r'.+\(.+\)', multiLine: false).hasMatch(funcName)) {
        var rFuncName = funcName.substring(0, funcName.indexOf('('));
        var params = funcName.substring(
            funcName.indexOf('(') + 1, funcName.lastIndexOf(')'));
        var args = params.split(',').map((e) {
          if (domain != null && domain.match(e)) {
            return domain.bindValue(e);
          } else {
            var r = proxyMirror?.evaluate(null, bound, e, domain: domain);
            if (r?.data == null) {
              return e;
            } else {
              return r?.data is FairValueNotifier ? r?.data.value : r?.data;
            }
          }
        }).toList();
        result = _functions?['runtimeInvokeMethodSync']?.call(rFuncName, args);
      } else {
        result = _functions?['runtimeInvokeMethodSync']?.call(funcName);
      }
      try {
        var value = jsonDecode(result);
        return value['result']['result'];
      } catch (e) {
        throw RuntimeError(errorMsg: result);
      }
    } else {
      return _functions?[funcName]?.call();
    }
  }

  dynamic bindFunctionOf(String funcName, ProxyMirror? proxyMirror,
      BindingData? bound, Domain? domain,
      {String? exp}) {
    if (_functions?[funcName] == null) {
      if (RegExp(r'.+\(.+\)', multiLine: false).hasMatch(funcName)) {
        var rFuncName = funcName.substring(0, funcName.indexOf('('));
        var params = funcName.substring(
            funcName.indexOf('(') + 1, funcName.lastIndexOf(')'));
        var args = params.split(',').map((e) {
          // if (RegExp(r'\^\(index\)', multiLine: false).hasMatch(e) &&
          //     domain is IndexDomain?) {
          //   return domain?.index;
          // } else
          if (domain != null && domain.match(e)) {
            return domain.bindValue(e);
          } else {
            var r = proxyMirror?.evaluate(null, bound, e, domain: domain);
            if (r?.data == null) {
              return e;
            } else {
              return r?.data is ValueNotifier ? r?.data.value : r?.data;
            }
          }
        }).toList();
        return ([props]) {
          var arguments = [];
          if (props != null) {
            arguments.addAll(props);
          }
          if (args != null) {
            arguments.addAll(args);
          }
          _functions?['runtimeInvokeMethod']?.call(rFuncName, arguments);
        };
      } else {
        return ([props]) =>
            _functions?['runtimeInvokeMethod']?.call(funcName, props);
      }
    } else {
      return _functions?[funcName];
    }
  }

  dynamic bindRuntimeValueOf(String name) {
    // _delegateValues优先级高于JS，如果要使用JS的变量，需要重命名变量
    if (_values?[name] == null) {
      var result = _functions?['runtimeParseVar']?.call({name: ''});
      var value = jsonDecode(result);
      if (value['result'][name] != null) {
        return value['result'][name];
      }
    } else {
      if (_values != null && _values?[name] != null) {
        return Function.apply(_values![name]!, null);
      }
    }
    return null;
  }

  Function? functionOf(String key) {
    return _functions != null ? _functions![key] : null;
  }

  PropertyValue? valueOf(String key) {
    return _values != null ? _values![key] : null;
  }

  dynamic dataOf(String key) {
    return data != null ? data![key] : null;
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

class RuntimeError extends Error {
  final String errorMsg;

  RuntimeError({required this.errorMsg});

  @override
  String toString() {
    return errorMsg;
  }
}
