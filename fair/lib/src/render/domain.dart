/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'base_model.dart';

abstract class Domain {
  final Domain? parent;

  Domain({required this.parent});

  bool match(dynamic exp);

  dynamic bindValue(String exp);
}

abstract class IndexDomain extends Domain {
  IndexDomain({required Domain? parent}) : super(parent: parent);
  int index = 0;
}

/// 暂时留着，适配之前的代码
/// Sugar.popMenuButton
/// Sugar.listBuilder 现在可以简单支持，看需要移除不
/// Sugar.sliverChildBuilderDelegate 现在可以简单支持，看需要移除不
class MapEachDomain extends IndexDomain {
  MapEachDomain(this.source, {required Domain? parent}) : super(parent: parent);

  final List? source;

  @override
  bool match(dynamic exp) {
    if (currentMatch(exp)) {
      return true;
    }
    return parentMatch(exp);
  }

  @override
  dynamic bindValue(String exp) {
    if (currentMatch(exp)) {
      if (exp == 'item') {
        return source?[index];
      } else if (exp == 'index') {
        return index;
      }
      // Carrying ”#(“ indicates value conversion to a string
      final isStringValue = exp.startsWith('#(');
      dynamic processed = exp.substring(2, exp.length - 1);
      if (processed.startsWith('\${')) {
        processed = processed.substring(2, processed.length - 1);
      }

      // ^(item)
      if (processed == 'item') {
        return source?[index];
      }
      // ^(index)
      else if (processed == 'index') {
        return index;
      }

      if (processed.contains('.')) {
        List<String> expList = processed.split('.');
        if (expList.first == '\$item' || expList.first == 'item') {
          dynamic obj = source?[index];
          dynamic modelValue;
          if (obj is BaseModel) {
            var json = (obj).toJson();
            modelValue = json;
          } else if (obj is Map) {
            modelValue = obj;
          }
          if (modelValue != null) {
            expList.removeAt(0);
            for (var k in expList) {
              modelValue = modelValue[k];
            }
            // If conversion to a string is not explicitly indicated, the original type is returned
            processed = isStringValue ? '$modelValue' : modelValue;
          }
        }
      } else {
        processed = processed.replaceAll('\$item', '${source?[index]}');
        processed = processed.replaceAll('\$index', '$index');
      }

      return processed;
    } else if (parentMatch(exp)) {
      return parent!.bindValue(exp);
    }
    return exp;
  }

  List forEach(dynamic Function(Domain $, dynamic element) f) {
    index = 0;
    var result = <dynamic>[];
    for (var i = 0; i < (source?.length ?? 0); i++) {
      result.add(f(this, source![index]));
      index++;
    }
    return result;
  }

  bool currentMatch(exp) {
    return (source != null &&
        exp is String &&
        ((RegExp('#\\(.+\\)', multiLine: true).hasMatch(exp) &&
                (exp.contains('\$item') || exp.contains('\$index'))) ||
            exp == 'item' ||
            exp == 'index' ||
            exp.startsWith('\$(item') ||
            exp.startsWith('\$(index') ||
            exp.startsWith('#(\${index') ||
            exp.startsWith('#(\${item') ||
            exp.startsWith('^(index)') ||
            exp.startsWith('^(item)')));
  }

  bool parentMatch(exp) {
    return parent?.match(exp) ?? false;
  }
}

/// 通用的回调 Function 的域，用于替换域下面对应参数的值
///
///
class FunctionDomain extends Domain {
  FunctionDomain(this.parameters, {required Domain? parent})
      : super(parent: parent);
  Map<String, dynamic> parameters;

  /// 获取 postion 参数
  static List pa(Map map) {
    return _getParameters(map, false);
  }

  /// 获取 named 参数
  /// 命名参数的名字不会变化，使用的时候名字相同对应就行了
  static List na(Map map) {
    return _getParameters(map, true);
  }
  
  /// 获取参数
  static List<dynamic> _getParameters(Map<dynamic, dynamic> map, bool isNamed) {
   
   assert(map['className']=='FairFunction');
   assert(map.containsKey('parameters'));

    var parameters = map['parameters']?[isNamed ? 'na' : 'pa'];
    return parameters ?? [];
  }
  
  /// 获取 function 的body
  static dynamic getBody(Map map) {
    assert(map['className']=='FairFunction');
    assert(map.containsKey('body'));
    return map['body'];
  }


  @override
  dynamic bindValue(String exp) {
    if (currentMatch(exp)) {
      for (var key in parameters.keys) {
        if (key == exp) {
          return parameters[key];
        }
      }

      // Carrying ”#(“ indicates value conversion to a string
      final isStringValue = exp.startsWith('#(');
      dynamic processed = exp.substring(2, exp.length - 1);
      if (processed.startsWith('\${')) {
        processed = processed.substring(2, processed.length - 1);
      }

      for (var key in parameters.keys) {
        if (key == processed) {
          return parameters[key];
        }
      }

      if (processed.contains('.')) {
        List<String> expList = processed.split('.');

        for (var key in parameters.keys) {
          if (expList.first == '\$$key' || expList.first == key) {
            dynamic obj = parameters[key];
            dynamic modelValue;
            if (obj is BaseModel) {
              var json = obj.toJson();
              modelValue = json;
            } else if (obj is Map) {
              modelValue = obj;
            }
            if (modelValue != null) {
              expList.removeAt(0);
              for (var k in expList) {
                modelValue = modelValue[k];
              }
              // If conversion to a string is not explicitly indicated, the original type is returned
              processed = isStringValue ? '$modelValue' : modelValue;
            }
          }
        }
      } else {
        for (var key in parameters.keys) {
          processed = processed.replaceAll('\$$key', '${parameters[key]}');
        }
      }
      return processed;
    } else if (parentMatch(exp)) {
      return parent!.bindValue(exp);
    }
    return exp;
  }

  @override
  bool match(exp) {
    if (currentMatch(exp)) {
      return true;
    }
    return parentMatch(exp);
  }

  bool currentMatch(exp) {
    if (exp is String && parameters.isNotEmpty) {
      for (var key in parameters.keys) {
        if ((RegExp('#\\(.+\\)', multiLine: true).hasMatch(exp) &&
                exp.contains('\$$key')) ||
            exp == key ||
            exp.startsWith('\$($key') ||
            exp.startsWith('#(\${$key') ||
            exp.startsWith('^($key)')) {
          return true;
        }
      }
    }
    return false;
  }

  bool parentMatch(exp) {
    return parent?.match(exp) ?? false;
  }
}
