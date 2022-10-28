import 'dart:collection';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../node/ArrowFunctionExpressionNode.dart';
import '../node/FunctionDeclarationNode.dart';
import 'handle/handleBreakStatement.dart';
import 'handle/handelExpressionStatement.dart';
import 'handle/handleContinueStatement.dart';
import 'handle/handleDoStatement.dart';
import 'handle/handleExpressionFunctionBody.dart';
import 'handle/handleForStatement.dart';
import 'handle/handleFunctionDeclarationStatement.dart';
import 'handle/handleIfStatement.dart';
import 'handle/handleReturnStatement.dart';
import 'handle/handleSwitchStatement.dart';
import 'handle/handleTryStatement.dart';
import 'handle/handleVariableDeclarationStatement.dart';
import 'handle/handleWhileStatement.dart';

class SimpleFunctionGenerator
    extends GeneralizingAstVisitor<SimpleFunctionGenerator> {
  FunctionDeclarationNode? func;
  String? parentClass;
  HashMap<int, String>? renamedParameters;

  SimpleFunctionGenerator(
      {bool isArrowFunc = false, this.renamedParameters, this.parentClass}) {
    func =
        isArrowFunc ? ArrowFunctionExpressionNode() : FunctionDeclarationNode();
  }

  @override
  SimpleFunctionGenerator? visitFunctionDeclaration(FunctionDeclaration node) {
    func?.name = node.name.toString();
    return super.visitFunctionDeclaration(node);
  }

  @override
  SimpleFunctionGenerator? visitFormalParameterList(FormalParameterList node) {
    var idx = 0;
    node.parameters.forEach((param) {
      var ident = param.identifier.toString();
      if (renamedParameters != null && renamedParameters!.containsKey(idx)) {
        ident = renamedParameters![idx]!;
      }
      var arg = [ident];

      if (param.isNamed) {
        if (param is DefaultFormalParameter && (param.defaultValue != null)) {
          arg.add(param.defaultValue.toString());
        }
        func?.namedArgumentList.add(arg);
      } else if (param.isOptional) {
        if (param is DefaultFormalParameter && (param.defaultValue != null)) {
          arg.add(param.defaultValue.toString());
        }
        func?.optionalArgumentList.add(arg);
      } else {
        func?.argumentList.add(arg);
      }

      idx++;
    });
    return null;
  }

  @override
  SimpleFunctionGenerator? visitBlockFunctionBody(BlockFunctionBody node) {
    func?.isAsync = node.isAsynchronous;
    return super.visitBlockFunctionBody(node);
  }

  @override
  SimpleFunctionGenerator? visitNode(AstNode node) {
    if (node is ExpressionStatement) {
      handleExpressionStatement(node, func, parentClass);
    } else if (node is ExpressionFunctionBody) {
      handleExpressionFunctionBody(node, func);
    } else if (node is VariableDeclarationStatement) {
      handleVariableDeclarationStatement(node, func);
    } else if (node is WhileStatement) {
      handleWhileStatement(node, func);
    } else if (node is DoStatement) {
      handleDoStatement(node, func);
    } else if (node is IfStatement) {
      handleIfStatement(node, func);
    } else if (node is SwitchStatement) {
      handleSwitchStatement(node, func);
    } else if (node is ReturnStatement) {
      handleReturnStatement(node, func);
    } else if (node is ForStatement) {
      handleForStatement(node, func);
    } else if (node is ContinueStatement) {
      handleContinueStatement(node, func);
    } else if (node is BreakStatement) {
      handleBreakStatement(node, func);
    } else if (node is FunctionDeclarationStatement) {
      handleFunctionDeclarationStatement(node, func);
    } else if (node is TryStatement) {
      // done 2022-10-8
      handleTryStatement(node,func);
    } else if (node is EmptyStatement) {
      // done 2022-10-8 代码为 ";" 这种情况无需处理忽略即可
    } else if (node is LabeledStatement) {
      // todo 尚未实现
    } else if (node is YieldStatement) {
      // todo 尚未实现
    } else {
      return super.visitNode(node);
    }
  }
}
