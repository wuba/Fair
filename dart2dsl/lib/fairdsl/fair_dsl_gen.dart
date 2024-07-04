/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';
import 'dart:io';

import 'package:fair_dart2dsl/fairdsl/fair_ast_logic_unit.dart';

import 'fair_ast_node.dart';

const String kFairWellAnnotaion = 'FairWell';

//解析用到的上下文
class FairDslContex {
  //标明是变量的注解
  Map variableAnnotation;

  //标明是函数的注解
  Map methodAnnotation;

  FairDslContex(this.variableAnnotation, this.methodAnnotation);
}

String fairDsl(Map rootAst) {
  var fairDslContex = _prepareVariableAnnotation(rootAst);
  // var proxy = _genProxy(rootAst, fairDslContex);
  // stdout.writeln('################gen_proxy_begin######################');
  // stdout.writeln(proxy);
  // stdout.writeln('################gen_proxy_end######################');
  var map = _parseRootAst(rootAst, fairDslContex);
  var encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(map);
}

FairDslContex? _prepareVariableAnnotation(Map rootAst) {
  var annotationMap = {};
  var methodAnnotationMap = {};
  var rootExpression = Expression.fromAst(rootAst);
  if (!(rootExpression?.isProgram??false)) {
    return null;
  }
  var bodyList = rootExpression?.asProgram.body;
  if ((bodyList?.length ?? 0) == 0) {
    return null;
  }
  for (var body in bodyList!) {
    if (body?.isClassDeclaration==true) {
      var classBodyList = body!.asClassDeclaration.body;
      for (var bodyNode in classBodyList!) {
        //只处理变量声明
        var annotaions = [];
        if (bodyNode?.isVariableDeclarationList==true) {
          annotaions = bodyNode!.asVariableDeclarationList.annotationList??[];
        } else if (bodyNode?.isMethodDeclaration==true) {
          annotaions = bodyNode?.asMethodDeclaration.annotationList??[];
        }
        for (var annotation in annotaions) {
          if (annotation.name == kFairWellAnnotaion) {
            var arg = annotation.argumentList.first.asStringLiteral;
            if (bodyNode?.isVariableDeclarationList==true) {
              annotationMap.putIfAbsent(
                  arg.value, () => bodyNode?.asVariableDeclarationList);
            } else if (bodyNode?.isMethodDeclaration==true) {
              methodAnnotationMap.putIfAbsent(
                  arg.value, () => bodyNode?.asMethodDeclaration);
            }
          }
        }
      }
    }
  }
  return FairDslContex(annotationMap, methodAnnotationMap);
}

String? _genProxy(Map rootAst, FairDslContex fairDslContex) {
  var imports = '''
  import 'package:fair/fair.dart';
  import 'package:flutter/foundation.dart';
  import 'package:flutter/material.dart';
  ''';
  String? className;
  var rootExpression = Expression.fromAst(rootAst);
  if (!(rootExpression?.isProgram??false)) {
    return null;
  }
  var bodyList = rootExpression?.asProgram.body;
  if ((bodyList?.length ?? 0) == 0) {
    return null;
  }

  //获取类名
  for (var body in bodyList!) {
    if (body?.isClassDeclaration==true) {
      if (body!.asClassDeclaration.superClause == 'StatefulWidget' ||
          body.asClassDeclaration.superClause == 'StatelessWidget') {
        className = '\$' + (body.asClassDeclaration.name??'') + 'Proxy';
        break;
      }
    }
  }

  var func = '';
  var property = '';
  var component = '';
  var variableAnnotation = '';
  var methodAno = '';
  fairDslContex.variableAnnotation.forEach((key, value) {
    if (value is VariableDeclarationList) {
      variableAnnotation += (value.sourceCode??'') + '\n';
      property +=
      '''pros['${value.declarationList?.first?.name}'] =() => ${value.declarationList?.first?.name};\n''';
    }
  });

  fairDslContex.methodAnnotation.forEach((key, value) {
    if (value is MethodDeclaration) {
      if (value.returnType == null || value.returnType?.name == 'void') {
        func += ''' functions['${value.name}'] = ${value.name};\n''';
      } else if (value.returnType?.name == 'Widget') {
        component +=
        '''plugins['${value.name}'] = (props) => ${value.name};\n ''';
      } else {
        property += '''pros['${value.name}'] = ${value.name};\n''';
      }
      methodAno += (value.source??'');
    }
  });

  var classBody = '''
     class $className  extends FairStateProxy {
     $variableAnnotation
      @override
    Map<String, FairWidgetBuilder> component() {
        var plugins = super.component() ?? <String, FairWidgetBuilder>{};
        $component
        return plugins;
    }
    
      @override
     Map<String, FairBlocBuilder> property() {
        var pros = super.property();
        $property
        return pros;
    }
    
    @override
     Map<String, dynamic> func() {
      var functions = super.func();
       $func
      return functions;
    }
    $methodAno
  }
  ''';
  return imports + classBody;
}

// ignore: missing_return
Map? _parseRootAst(Map rootAst, FairDslContex? fairDslContex) {
  var rootExpression = Expression.fromAst(rootAst);
  if (!(rootExpression?.isProgram??false)) {
    return null;
  }
  var bodyList = rootExpression!.asProgram.body;
  if ((bodyList?.length ?? 0) == 0) {
    return null;
  }

  var tmpMap = {};
  var methods = {};

  for (var body in bodyList!) {
    if (body?.isClassDeclaration==true) {
      var classBodyList = body!.asClassDeclaration.body;
      for (var bodyNode in classBodyList!) {
        //只处理build函数
        if (bodyNode?.isMethodDeclaration==true) {
          // if(bodyNode.isMethodDeclaration && bodyNode.asMethodDeclaration.name == 'build'){
          var buildBodyReturn = bodyNode?.asMethodDeclaration.body?.body;
          if (buildBodyReturn?.isNotEmpty==true &&
              buildBodyReturn?.last?.isReturnStatement==true &&
              buildBodyReturn?.last?.asReturnStatement.argument != null) {
            //解析build中widgetExpression
            if (bodyNode?.asMethodDeclaration.name == 'build') {
              tmpMap = _buildWidgetDsl(
                  buildBodyReturn?.last?.asReturnStatement.argument,
                  fairDslContex);
            } else if (buildBodyReturn?.last?.asReturnStatement.argument?.isMethodInvocation==true) {
              //混编逻辑处理
              var methodMap = {
                bodyNode?.asMethodDeclaration.name: _buildWidgetDsl(
                    buildBodyReturn?.last?.asReturnStatement.argument,
                    fairDslContex)
              };
              methods.addAll(methodMap);
            }
          }
        } else if (body.isFunctionDeclaration==true) {
          var functionDeclaration = body.asFunctionDeclaration;
          var buildBodyReturn = functionDeclaration.expression?.body?.body;
          var methodMap = {
            functionDeclaration.name: _buildWidgetDsl(
                buildBodyReturn?.last?.asReturnStatement.argument, fairDslContex)
          };
          // methodList.add(methodMap);
          methods.addAll(methodMap);
        }
      }
    }
  }
  tmpMap.putIfAbsent('methodMap', () => methods);
  return tmpMap;
}

dynamic _buildWidgetDsl(
    Expression? widgetExpression, FairDslContex? fairDslContex) {
  var dslMap = {};
  var paMap = [];
  var naMap = {};
  var taMap =[];

  var methodInvocationExpression = widgetExpression?.asMethodInvocation;
  //普通类
  if (methodInvocationExpression?.callee?.isIdentifier==true) {
    //注册的方法不再使用className
    if (fairDslContex?.methodAnnotation
        .containsKey(methodInvocationExpression?.callee?.asIdentifier.name)==true) {
      return '\$(${methodInvocationExpression?.callee?.asIdentifier.name})';
    } else if (fairDslContex?.variableAnnotation
        .containsKey(methodInvocationExpression?.callee?.asIdentifier.name)==true) {
      if (methodInvocationExpression?.argumentList?.isNotEmpty ?? false) {
        var args = methodInvocationExpression?.argumentList?.fold('', (previousValue, element) =>
        '$previousValue,${_buildValueExpression(element, fairDslContex)}').substring(1);
        return '%(${methodInvocationExpression?.callee?.asIdentifier.name}($args))';
      } else {
        return '%(${methodInvocationExpression?.callee?.asIdentifier.name})';
      }
    }

    if (RegExp(r'^[a-z_]')
        .hasMatch(methodInvocationExpression?.callee?.asIdentifier.name??'')) {
      if (methodInvocationExpression?.argumentList?.isNotEmpty ?? false) {
        var args = methodInvocationExpression?.argumentList?.fold('', (previousValue, element) =>
        '$previousValue,${_buildValueExpression(element, fairDslContex)}').substring(1);
        return '%(${methodInvocationExpression?.callee?.asIdentifier.name}($args))';
      } else {
        return '%(${methodInvocationExpression?.callee?.asIdentifier.name})';
      }
    } else {
      dslMap.putIfAbsent('className',
              () => methodInvocationExpression?.callee?.asIdentifier.name);
    }
  } else if (methodInvocationExpression?.callee?.isMemberExpression==true) {
    //方法类

    var memberExpression = methodInvocationExpression?.callee?.asMemberExpression;
    try {
      dslMap.putIfAbsent(
              'className',
                  () =>
                  (memberExpression?.object?.asIdentifier.name??'') +
                  '.' +
                      (memberExpression?.property??''));
    } catch (e) {
      // dslMap.putIfAbsent(
      //     'className',
      //         () =>
      //     'Sugar' +
      //         '.' +
      //         'map');
      print(e);
    }
  } else {
    return null;
  }

  //1.pa
  for (var arg in methodInvocationExpression!.argumentList!) {
    if (arg?.isNamedExpression==true) {
      break;
    }
    //pa 常量处理
    var valueExpression = arg;
    valueExpression?.isFuncParam = true;
    var paValue = _buildValueExpression(valueExpression, fairDslContex);
    paMap.add(paValue);
  }

  //2.na
  for (var arg in methodInvocationExpression.argumentList!) {
    if (arg?.isNamedExpression==true) {
      var nameExpression = arg?.asNamedExpression;
      if (nameExpression == null) {
        continue;
      }

      var valueExpression = nameExpression.expression;
      if (valueExpression == null) {
        continue;
      }
      var naValue = _buildValueExpression(valueExpression, fairDslContex);
      if (bindFunctions.contains(nameExpression.label ?? '')) {
        if (naValue is String && naValue.startsWith('%')) {
          naValue = naValue.replaceFirst('%', '@');
        }
      }
      naMap.putIfAbsent(nameExpression.label, () => naValue);
    }
  }

  //3.ta
  if (methodInvocationExpression.typeArgumentList?.isNotEmpty ?? false) {
    taMap.addAll(methodInvocationExpression.typeArgumentList
            ?.map((ta) => ta?.asTypeNameExpression.name) ??
        []);
  }

  if (paMap.isNotEmpty) {
    dslMap.putIfAbsent('pa', () => paMap);
  }

  if (naMap.isNotEmpty) {
    dslMap.putIfAbsent('na', () => naMap);
  }

  if(taMap.isNotEmpty){
    dslMap.putIfAbsent('typeArgumentList', () => taMap);
  }

  return dslMap;
}

bool isDoubleProperty(PrefixedIdentifier? node) {
  if (!(node is PrefixedIdentifier) || node.prefix != 'double') {
    return false;
  }

  switch (node.identifier) {
    case 'infinity':
      return true;
    default:
      stdout.writeln('Fair 不支持该 常量 double ${node.identifier}');
      return false;
  }
}

dynamic _buildValueExpression(
    Expression? valueExpression, FairDslContex? fairDslContex) {
  var naPaValue;

  if (valueExpression?.isIdentifier==true) {
    //映射变量声明
    if (fairDslContex?.variableAnnotation
        .containsKey(valueExpression?.asIdentifier.name)==true ||
        fairDslContex?.methodAnnotation
            .containsKey(valueExpression?.asIdentifier.name)==true) {
      naPaValue = '#(' + (valueExpression?.asIdentifier.name??'') + ')';
    }
    // else if (fairDslContex.variables
    //     .containsKey(valueExpression.asIdentifier.name)) {
    //   naPaValue = '\$(' + valueExpression.asIdentifier.name + ')';
    // }
    else if (FairLogicUnit().functions.containsKey(valueExpression?.asIdentifier.name)) {
      naPaValue = '@(' + (valueExpression?.asIdentifier.name??'') + ')';
    } else {
      naPaValue = '^(' + (valueExpression?.asIdentifier.name??'') + ')';
    }
  } else if (valueExpression?.isNumericLiteral==true) {
    naPaValue = valueExpression?.asNumericLiteral.value;
  } else if (valueExpression?.isStringLiteral==true) {
    naPaValue = valueExpression?.asStringLiteral.value;
  } else if (valueExpression?.isBooleanLiteral==true) {
    naPaValue = valueExpression?.asBooleanLiteral.value;
  } else if (valueExpression?.isPrefixedIdentifier==true) {
    if (RegExp(r'^[a-z_]') // widget.** 参数类的特殊处理成#(),兼容1期
        .hasMatch(valueExpression?.asPrefixedIdentifier.prefix??'') && ('widget' != valueExpression?.asPrefixedIdentifier.prefix) && !isDoubleProperty(valueExpression?.asPrefixedIdentifier)) {
      naPaValue = '\$(' +
          (valueExpression?.asPrefixedIdentifier.prefix??'') +
          '.' +
          (valueExpression?.asPrefixedIdentifier.identifier??'') +
          ')';
    } else {
      naPaValue = '#(' +
          (valueExpression?.asPrefixedIdentifier.prefix??'') +
          '.' +
          (valueExpression?.asPrefixedIdentifier.identifier??'') +
          ')';
    }
  } else if (valueExpression?.isPropertyAccess==true) {
    if (valueExpression?.asPropertyAccess.expression != null &&
        valueExpression?.asPropertyAccess.expression?.isPrefixedIdentifier==true) {
      var prefixedIdentifier =
          valueExpression?.asPropertyAccess.expression?.asPrefixedIdentifier;
      naPaValue = '\$(${prefixedIdentifier?.prefix}' +
          '.' +
          '${prefixedIdentifier?.identifier}' +
          '.' +
          '${valueExpression?.asPropertyAccess.name})';
    } else {
      naPaValue = '';
    }
  } else if (valueExpression?.isMapLiteral==true) {
    var retMap = <String, dynamic>{};
    valueExpression?.asMapLiteral.elements?.forEach((key, value) {
      retMap.putIfAbsent(key, () => _buildValueExpression(value,fairDslContex));
    });
    naPaValue = retMap;
  } else if (valueExpression?.isListLiteral==true) {
    var widgetExpressionList = [];
    for (var itemWidgetExpression in valueExpression!.asListLiteral.elements!) {
      widgetExpressionList
          .add(_buildValueExpression(itemWidgetExpression, fairDslContex));
    }
    naPaValue = widgetExpressionList;
  } else if (valueExpression?.isFunctionExpression==true) {
    naPaValue = '';
    if (valueExpression?.asFunctionExpression.body != null &&
        valueExpression?.asFunctionExpression.body?.body?.isNotEmpty==true) {
      naPaValue = _buildValueExpression(
          valueExpression?.asFunctionExpression.body?.body?.last, fairDslContex);
    }
    if (naPaValue is Map && valueExpression?.asFunctionExpression.parameterList != null &&
        valueExpression!.asFunctionExpression.parameterList!.isNotEmpty) {
      var na = [];
      var pa = [];
      for (var element in valueExpression.asFunctionExpression.parameterList!) {
        if (element?.isNamed == true) {
          na.add(element?.name);
        } else {
          pa.add(element?.name);
        }
      }
      naPaValue['functionParameters'] = {
        if (na.isNotEmpty) 'na': na,
        if (pa.isNotEmpty) 'pa': pa,
      };
    }
  } else if (valueExpression?.isReturnStatement==true) {
    naPaValue = _buildValueExpression(
        valueExpression?.asReturnStatement.argument, fairDslContex);
  } else if (valueExpression?.isStringInterpolation==true) {
    var sourceString = valueExpression?.asStringInterpolation.sourceString??'';
    if (sourceString.length >= 2) {
      if (sourceString.startsWith('\'') && sourceString.endsWith('\'') ||
          sourceString.startsWith('\"') && sourceString.endsWith('\"')) {
        sourceString = sourceString.substring(1, sourceString.length - 1);
      }
    }
    naPaValue = '#(' + sourceString + ')';
  } else if (valueExpression?.isVariableExpression==true) {
    var expression = valueExpression?.asVariableExpression.expression??'';
    naPaValue = '\$(' + expression + ')';
  } else if (valueExpression?.isPrefixExpression == true) {
    var argument = _buildValueExpression(
        valueExpression?.asPrefixExpression.argument, fairDslContex);
    if (valueExpression?.asPrefixExpression.prefix ?? true) {
      if (argument is num) {
        if (valueExpression?.asPrefixExpression.operator == '-') {
          naPaValue = -argument;
        } else {
          naPaValue = argument;
        }
      } else {
        naPaValue = '${valueExpression?.asPrefixExpression.prefix}$argument';
      }
    } else {
      if (argument is num) {
        naPaValue = argument;
      } else {
        naPaValue = '$argument${valueExpression?.asPrefixExpression.prefix}';
      }
    }
  } else {
    naPaValue = _buildWidgetDsl(valueExpression, fairDslContex);
  }
  return naPaValue;
}

var bindFunctions = [
  'onTap',
  'onTapDown',
  'onTapCancel',
  'onDoubleTap',
  'onPressed',
  'onLongPress',
];