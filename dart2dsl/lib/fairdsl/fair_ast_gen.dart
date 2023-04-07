/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:io';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'fair_ast_check_gen.dart';
import 'fair_check_node_map.dart';

@AstNodeCheck('lib/fairdsl/fair_ast_gen.dart')
class NodeCheckAstVisitor extends GeneralizingAstVisitor<Map> {
  @override
  Map? visitNode(AstNode node) {
    stdout.writeln('${node.runtimeType}<---->${node.toSource()}');
    return super.visitNode(node);
  }
}

class CustomAstVisitor extends SimpleAstVisitor<Map> {
  Map? _visitNode(AstNode? node) {
    if (node != null) {
      if (!checkNode.containsKey(node.runtimeType.toString())) {
        stdout.writeln('不支持的节点${node.runtimeType}<---->${node.parent?.toSource()}---->${node.toSource()} ');
      }
      return node.accept(this);
    }
    return null;
  }

  Map? _visitIdentifierToken(Token? token) {
    if (token != null) {
      // if (!checkNode.containsKey(token.runtimeType.toString())) {
      //   stdout.writeln('不支持的节点${token.runtimeType}<---->${token.parent?.toSource()}---->${node.toSource()} ');
      // }
      return {
        'type': '${token.type.lexeme.substring(0,1).toUpperCase()}${token.type.lexeme.substring(1)}',
        'name': token.lexeme,
      };
    }
    return null;
  }

  List<Map> _visitNodeList(NodeList<AstNode>? nodes) {
    var maps = <Map>[];
    if (nodes != null) {
      var size = nodes.length;
      for (var i = 0; i < size; i++) {
        var node = nodes[i];
        if (!checkNode.containsKey(node.runtimeType.toString())) {
          stdout.writeln('不支持的节点${node.runtimeType}<---->${node.parent?.toSource()}---->${node.toSource()}');
        }
        var res = node.accept(this);
        if (res != null) {
          maps.add(res);
        }
      }
    }
    return maps;
  }

  @override
  Map? visitMapLiteralEntry(MapLiteralEntry node) {
    return _buildMapLiteralEntry(_visitNode(node.key), _visitNode(node.value));
  }

  @override
  Map? visitSetOrMapLiteral(SetOrMapLiteral node) {
    return _buildSetOrMapLiteral(_visitNodeList(node.elements));
  }

  @override
  Map? visitAnnotation(Annotation node) {
    return _buildAnnotation(_visitNode(node.name), _visitNode(node.arguments));
  }

  @override
  Map? visitListLiteral(ListLiteral node) {
    return _buildVisitListLiteral(_visitNodeList(node.elements));
  }

  @override
  Map? visitInterpolationExpression(InterpolationExpression node) {
    return {'type': 'InterpolationExpression', 'id': _visitNode(node.expression)};
  }

  @override
  Map? visitStringInterpolation(StringInterpolation node) {
    return {'type': 'StringInterpolation', 'elements': _visitNodeList(node.elements), 'sourceString': node.toSource()};
  }

  @override
  Map? visitPostfixExpression(PostfixExpression node) {
    return _buildPrefixExpression(_visitNode(node.operand), node.operator.toString(), false);
  }

  @override
  Map? visitExpressionStatement(ExpressionStatement node) {
    return _visitNode(node.expression);
  }

  @override
  //node.fields子节点类型 VariableDeclarationList
  Map? visitFieldDeclaration(FieldDeclaration node) {
    return _buildVariableDeclarationList(
        _visitNode(node.fields.type), _visitNodeList(node.fields.variables), _visitNodeList(node.metadata), node.toSource());
  }

  @override
  Map? visitCompilationUnit(CompilationUnit node) {
    return _buildAstRoot(_visitNodeList(node.declarations));
  }

  @override
  Map? visitBlock(Block node) {
    return _buildBloc(_visitNodeList(node.statements));
  }

  @override
  Map? visitBlockFunctionBody(BlockFunctionBody node) {
    return _visitNode(node.block);
  }

  @override
  Map? visitVariableDeclaration(VariableDeclaration node) {
    // return _buildVariableDeclaration(
    //     _visitNode(node.name), _visitNode(node.initializer));
    return _buildVariableDeclaration(_visitIdentifierToken(node.name), _visitNode(node.initializer));
  }

  @override
  Map? visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    return _visitNode(node.variables);
  }

  @override
  Map? visitVariableDeclarationList(VariableDeclarationList node) {
    return _buildVariableDeclarationList(_visitNode(node.type), _visitNodeList(node.variables), _visitNodeList(node.metadata), node.toSource());
  }

  @override
  Map? visitSimpleIdentifier(SimpleIdentifier node) {
    return _buildIdentifier(node.name);
  }

  // @override
//  Map visitBinaryExpression(BinaryExpression node) {
//    return _buildBinaryExpression(_safelyVisitNode(node.leftOperand),
//        _safelyVisitNode(node.rightOperand), node.operator.lexeme);
//  }

  @override
  Map? visitIntegerLiteral(IntegerLiteral node) {
    if (node.literal.lexeme.toUpperCase().startsWith('0X')) {
      return _buildStringLiteral(node.literal.lexeme);
    }
    return _buildNumericLiteral(node.value);
  }

  @override
  Map? visitDoubleLiteral(DoubleLiteral node) {
    return _buildNumericLiteral(node.value);
  }

  @override
  Map? visitFunctionDeclaration(FunctionDeclaration node) {
    // return _buildFunctionDeclaration(
    //     _visitNode(node.name), _visitNode(node.functionExpression));
    return _buildFunctionDeclaration(_visitIdentifierToken(node.name), _visitNode(node.functionExpression));
  }

  @override
  Map? visitFunctionDeclarationStatement(FunctionDeclarationStatement node) {
    return _visitNode(node.functionDeclaration);
  }

  //()=>方法
  @override
  Map? visitExpressionFunctionBody(ExpressionFunctionBody node) {
    return _buildBloc([_visitNode(node.expression)]);
  }

  @override
  Map? visitFunctionExpression(FunctionExpression node) {
    var functionType= node.staticType as  FunctionType?;
    String? tagString;
    String? returnTypeString;
    if(functionType !=null) {
       var returnType= functionType.returnType;
       tagString = functionType.getDisplayString(withNullability: true);
       returnTypeString = functionType.returnType.getDisplayString(withNullability: true);
       // 特殊处理一下 Widget
       // 
       // itemBuilder: (context, index) {
       //   return Container();
       // }
       // 
       // 会生成这样的， "Container Function(BuildContext, int)"
       // 
       // 但是实际上需要是 "Widget Function(BuildContext, int)"
       // 
       // Widget 是符合大部分的场景
       // 
       // 应该尽量避免使用返回类型是显式类型(比如返回类型必须是Container)，如果真的需要，请在回调执行的地方再做强转。
       // 或者在自定义的 DynamicWidgetBuilder 中做特殊处理
       // 
       // class SugarCommon {
       //   SugarCommon._();
       //   static Container Function() returnContainer(Widget Function() input) {
       //     Container Function() builder =(){
       //       return input() as Container;
       //     };
       //     return builder;
       //   }
       // }
       // 
       // class CustomDynamicWidgetBuilder extends DynamicWidgetBuilder {
       //   CustomDynamicWidgetBuilder(
       //     super.proxyMirror,
       //     super.page,
       //     super.bound, {
       //     super.bundle,
       //   });
       //   @override
       //   dynamic convert(BuildContext context, Map map, Map? methodMap,
       //       {Domain? domain}) {
       //     var name = map[tag];
       //     if(name =='SugarCommon.returnContainer') {
       //        dynamic fairFunction = pa0(map);
       //        assert(fairFunction is Map);
       //        Container Function() builder = (
       //        ) {
       //          return convert(
       //            context,
       //            FunctionDomain.getBody(fairFunction),
       //            methodMap,
       //          ) as Container;
       //        };
       //        return builder;
       //     }
       //     return super.convert(context, map, methodMap, domain:domain);
       //   }
       // }
       if(returnType is InterfaceType && 
       returnType.allSupertypes.any((element) => 
       element.getDisplayString(withNullability: false) == 'Widget')) {
        var nullabilityString = returnTypeString.endsWith('?') ? '?':'';
        tagString = tagString.replaceFirst(returnTypeString, 'Widget'+nullabilityString);
        returnTypeString = 'Widget'+nullabilityString;
       }
    }

    return _buildFunctionExpression(_visitNode(node.parameters),
       _visitNode(node.body), 
       isAsync: node.body.isAsynchronous,
       tag: tagString,
       returnType: returnTypeString,
     );
  }

  @override
  Map? visitSimpleFormalParameter(SimpleFormalParameter node) {
    // return _buildSimpleFormalParameter(
    //     _visitNode(node.type), node.identifier?.name);
    return _buildSimpleFormalParameter(_visitNode(node.type), node.name?.lexeme,node.isNamed);
  }

  @override
  Map? visitDefaultFormalParameter(DefaultFormalParameter node) {
    var type= (node.parameter as SimpleFormalParameter?)?.type;
    return _buildSimpleFormalParameter(_visitNode(type), node.name?.lexeme,node.isNamed);
  }

  @override
  Map? visitFormalParameterList(FormalParameterList node) {
    return _buildFormalParameterList(_visitNodeList(node.parameters));
  }

  // @override
  // Map? visitTypeName(TypeName node) {
  //   return _buildTypeName(node.name.name);
  // }

  @override
  Map visitNamedType(NamedType node) {
    return _buildTypeName(node.name.name);
  }

  @override
  Map? visitReturnStatement(ReturnStatement node) {
    return _buildReturnStatement(_visitNode(node.expression));
  }

  @override
  Map? visitMethodDeclaration(MethodDeclaration node) {
    return _buildMethodDeclaration(
        // _visitNode(node.name),
        _visitIdentifierToken(node.name), _visitNode(node.parameters), _visitNode(node.typeParameters), _visitNode(node.body), _visitNode(node.returnType),
        _visitNodeList(node.metadata), node.toSource(),
        isAsync: node.body.isAsynchronous);
  }

  @override
  Map? visitNamedExpression(NamedExpression node) {
    return _buildNamedExpression(_visitNode(node.name), _visitNode(node.expression));
  }

  @override
  Map? visitPrefixedIdentifier(PrefixedIdentifier node) {
    return _buildPrefixedIdentifier(_visitNode(node.identifier), _visitNode(node.prefix));
  }

  @override
  Map? visitMethodInvocation(MethodInvocation node) {
    Map? callee;
    if (node.target != null) {
      node.target?.accept(this);
      callee = {
        'type': 'MemberExpression',
        'object': _visitNode(node.target),
        'property': _visitNode(node.methodName),
      };
    } else {
      callee = _visitNode(node.methodName);
    }
    return _buildMethodInvocation(callee, _visitNode(node.typeArguments), _visitNode(node.argumentList));
  }

  @override
  Map? visitClassDeclaration(ClassDeclaration node) {
    return _buildClassDeclaration(
        // _visitNode(node.name),
        _visitIdentifierToken(node.name), _visitNode(node.extendsClause), _visitNode(node.implementsClause), _visitNode(node.withClause), _visitNodeList(node.metadata),
        _visitNodeList(node.members));
  }

  @override
  Map? visitInstanceCreationExpression(InstanceCreationExpression node) {
    Map? callee;
    if (node.constructorName.type.name is PrefixedIdentifier) {
      var prefixedIdentifier = node.constructorName.type.name as PrefixedIdentifier;
      callee = {
        'type': 'MemberExpression',
        'object': _visitNode(prefixedIdentifier.prefix),
        'property': _visitNode(prefixedIdentifier.identifier),
      };
    }
    // 换了用 AnalysisContextCollection 解析之后，
    // 可以直接拿到构造的名字
    else if(node.constructorName.name!=null) {
       callee = {
        'type': 'MemberExpression',
        'object': _visitNode(node.constructorName.type.name),
        'property': _visitNode(node.constructorName.name),
      };
    }
    else {
      //如果不是simpleIdentif 需要特殊处理
      callee = _visitNode(node.constructorName.type.name);
    }
    return _buildMethodInvocation(callee, null, _visitNode(node.argumentList));
  }

  @override
  Map? visitSimpleStringLiteral(SimpleStringLiteral node) {
    return _buildStringLiteral(node.value);
  }

  @override
  Map? visitBooleanLiteral(BooleanLiteral node) {
    return _buildBooleanLiteral(node.value);
  }

  @override
  Map? visitArgumentList(ArgumentList node) {
    return _buildArgumentList(_visitNodeList(node.arguments));
  }

  @override
  Map? visitLabel(Label node) {
    return _visitNode(node.label);
  }

  @override
  Map? visitExtendsClause(ExtendsClause node) {
    return _visitNode(node.superclass);
  }

  @override
  Map? visitImplementsClause(ImplementsClause node) {
    return _buildImplementsClause(_visitNodeList(node.interfaces));
  }

  @override
  Map? visitWithClause(WithClause node) {
    return _visitNode(node);
  }

  @override
  Map? visitPropertyAccess(PropertyAccess node) {
    var expression = node.parent?.toSource();
    return _buildVariableExpression(expression);
  }

  ///根节点
  Map? _buildAstRoot(List<Map> body) {
    if (body.isNotEmpty) {
      return {
        'type': 'Program',
        'body': body,
      };
    } else {
      return null;
    }
  }

  //代码块
  Map _buildBloc(List body) => {'type': 'BlockStatement', 'body': body};

//  //运算表达式结构
//  Map _buildBinaryExpression(Map left, Map right, String lexeme) => {
//    'type': 'BinaryExpression',
//    'operator': lexeme,
//    'left': left,
//    'right': right
//  };

  //变量声明
  Map _buildVariableDeclaration(Map? id, Map? init) => {
        'type': 'VariableDeclarator',
        'id': id,
        'init': init,
      };

  //变量声明列表
  Map _buildVariableDeclarationList(Map? typeAnnotation, List<Map> declarations, List<Map> annotations, String source) => {
        'type': 'VariableDeclarationList',
        'typeAnnotation': typeAnnotation,
        'declarations': declarations,
        'annotations': annotations,
        'source': source
      };

  //标识符定义
  Map _buildIdentifier(String name) => {'type': 'Identifier', 'name': name};

  //数值定义
  Map _buildNumericLiteral(num? value) => {'type': 'NumericLiteral', 'value': value};

  //函数声明
  Map _buildFunctionDeclaration(Map? id, Map? expression) => {
        'type': 'FunctionDeclaration',
        'id': id,
        'expression': expression,
      };

  //函数表达式
  Map _buildFunctionExpression(Map? params, Map? body, {bool isAsync = false,String? tag, String? returnType}) => {
        'type': 'FunctionExpression',
        'parameters': params,
        'body': body,
        'isAsync': isAsync,
        if(tag != null)
        'tag': tag,
        if(returnType != null)
        'returnType': returnType,
      };

  //函数参数列表
  Map _buildFormalParameterList(List<Map> parameterList) => {'type': 'FormalParameterList', 'parameterList': parameterList};

  //函数参数
  //函数参数
  Map _buildSimpleFormalParameter(Map? type, String? name, bool isNamed) => {
        'type': 'SimpleFormalParameter',
        'paramType': type,
        'name': name,
        'isNamed': isNamed,
      };
  //函数参数类型
  Map _buildTypeName(String name) => {
        'type': 'TypeName',
        'name': name,
      };

  //返回数据定义
  Map _buildReturnStatement(Map? argument) => {
        'type': 'ReturnStatement',
        'argument': argument,
      };

  //方法声明
  Map _buildMethodDeclaration(Map? id, Map? parameters, Map? typeParameters, Map? body, Map? returnType, List<Map> annotations, String source,
          {bool isAsync = false}) =>
      {
        'type': 'MethodDeclaration',
        'id': id,
        'parameters': parameters,
        'typeParameters': typeParameters,
        'body': body,
        'isAsync': isAsync,
        'returnType': returnType,
        'annotations': annotations,
        'source': source
      };

  Map _buildNamedExpression(Map? id, Map? expression) => {
        'type': 'NamedExpression',
        'id': id,
        'expression': expression,
      };

  Map _buildPrefixedIdentifier(Map? identifier, Map? prefix) => {
        'type': 'PrefixedIdentifier',
        'identifier': identifier,
        'prefix': prefix,
      };

  Map _buildMethodInvocation(Map? callee, Map? typeArguments, Map? argumentList) => {
        'type': 'MethodInvocation',
        'callee': callee,
        'typeArguments': typeArguments,
        'argumentList': argumentList,
      };

  Map _buildClassDeclaration(Map? id, Map? superClause, Map? implementsClause, Map? mixinClause, List<Map> metadata, List<Map> body) => {
        'type': 'ClassDeclaration',
        'id': id,
        'superClause': superClause,
        'implementsClause': implementsClause,
        'mixinClause': mixinClause,
        'metadata': metadata,
        'body': body,
      };

  Map _buildArgumentList(List<Map> argumentList) => {'type': 'ArgumentList', 'argumentList': argumentList};

  Map _buildStringLiteral(String value) => {'type': 'StringLiteral', 'value': value};

  Map _buildBooleanLiteral(bool value) => {'type': 'BooleanLiteral', 'value': value};

  Map _buildImplementsClause(List<Map> implementList) => {'type': 'ImplementsClause', 'implements': implementList};

  Map _buildPropertyAccess(Map id, Map expression) => {
        'type': 'PropertyAccess',
        'id': id,
        'expression': expression,
      };

  Map _buildVariableExpression(String? expression) => {'type': 'VariableExpression', 'expression': expression};

//  Map _buildPostfixExpression(Map operand, String operator) =>
//      {'type': 'PostfixExpression', 'operand': operand, 'operator': operator};

  Map _buildPrefixExpression(Map? argument, String oprator, bool prefix) =>
      {'type': 'PrefixExpression', 'argument': argument, 'prefix': prefix, 'operator': oprator};

  Map _buildVisitListLiteral(List<Map> literal) => {'type': 'ListLiteral', 'elements': literal};

  Map _buildAnnotation(Map? name, Map? argumentList) => {'type': 'Annotation', 'id': name, 'argumentList': argumentList};

  Map _buildSetOrMapLiteral(List<Map> elements) => {'type': 'SetOrMapLiteral', 'elements': elements};

  Map _buildMapLiteralEntry(Map? key, Map? expression) => {'type': 'MapLiteralEntry', 'key': key, 'value': expression};
}

Future<Map> generateAstMap(String path) async {
  if (path.isEmpty) {
    stdout.writeln('File not found');
  } else {
    await _pathCheck(path);
    if (exitCode == 2) {
      try {
        ///FeatureSet.latestLanguageVersion()方法待测试
        // var parseResult = parseFile(path: path, featureSet: FeatureSet.latestLanguageVersion());
        var collection = AnalysisContextCollection(includedPaths: [path]);
        // 为了获取 Function 的描述，改用该方法
        var parseResult = await collection.contextFor(path).currentSession.getResolvedUnit(path) as ResolvedUnitResult;
         
        var compilationUnit = parseResult.unit;
       
        //遍历AST
        var astData = compilationUnit.accept(CustomAstVisitor());

        // var encode = json.encode(astData);
        // print(encode);
        // stdout.writeln('################gen_ast_begin######################');
        // stdout.writeln(jsonEncode(astData));
        // stdout.writeln('################gen_ast_end######################');
        return Future.value(astData);
      } catch (e) {
        stdout.writeln('Visit dart ast error: ${e.toString()}');
      }
    }
  }
  return Future.value();
}

Future _pathCheck(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
