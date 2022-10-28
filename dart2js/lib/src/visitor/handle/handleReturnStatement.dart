import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertExpression.dart';
import '../../node/FunctionDeclarationNode.dart';
import '../../node/ReturnStatementNode.dart';

handleReturnStatement(ReturnStatement node, FunctionDeclarationNode? func) {
  var gnNode = ReturnStatementNode();
  gnNode.expr = convertExpression(node.expression.toString());
  func?.body.push(gnNode);
  return null;
}
