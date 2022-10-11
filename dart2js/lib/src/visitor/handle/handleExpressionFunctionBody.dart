import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertExpression.dart';
import '../../node/FunctionDeclarationNode.dart';
import '../../node/GenericStatementNode.dart';

void handleExpressionFunctionBody(ExpressionFunctionBody node,FunctionDeclarationNode? func){
  // print('ExpressionFunctionBody:' + node.toSource());
  func?.body.push(
      GenericStatementNode(convertExpression(node.expression.toString())));
  return null;
}