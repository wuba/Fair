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
 
   var parameters = map['parameters']?[isNamed ? 'na' : 'pa'];
   return parameters ?? [];
  }
  
  /// 获取 function 的body
  static dynamic getBody(Map map) {
    if(map['className']!='FairFunction') {
      return map;
    }
    assert(map.containsKey('body'));

    var body= map['body'];
    if(body is Map && body['className']=='Sugar.asT') {
       return body['pa'][0];
    }
    return body;
  }
  
  /// 获取唯一标记
  static String getTag(Map map) {
    assert(map['tag'] != null,'未找到 FairFunction 的 tag');
    return map['tag'];
  }

  /// 获取返回值类型
  static String getReturnType(Map map) {
    assert(map['rt'] != null,'未找到 FairFunction 的 returnType');
    return map['rt'];
  }

  /// 获取返回值类型中的泛型
  static String? getReturnTypeTypeArguments(Map map) {
    // assert(map['rtta'] != null,'未找到 FairFunction 的 returnType 的 TypeArguments');
    return map['rtta'];
  }

   /// 无参数回调
  static bool parametersIsEmpty(Map<dynamic, dynamic> map) {
   
   assert(map['className']=='FairFunction');
   var parameters = map['parameters'];
   if(parameters is Map) {
     return parameters.isEmpty;
   }
   return true;
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
            // {
            //   "className": "Person",
            //   "na": {
            //     "name": "kk",
            //     "age": 18,
            //     "wei": 99
            //   }
            // },
              modelValue = obj;
              if(obj.containsKey('className') && obj.containsKey('na'))
              {
                 modelValue= modelValue['na'];
              }
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
