import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertBlock.dart';
import '../../covert/convertExpression.dart';
import '../../node/DoWhileStatementNode.dart';
import '../../node/FunctionDeclarationNode.dart';

void handleDoStatement(DoStatement node, FunctionDeclarationNode? func) {
  var gnNode = DoWhileStatementNode();
  gnNode.condition = convertExpression(node.condition.toString());
  gnNode.body = convertBlock(node.body.toString());
  func?.body.push(gnNode);
  return null;
}
