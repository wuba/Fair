import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertBlock.dart';
import '../../covert/convertExpression.dart';
import '../../node/FunctionDeclarationNode.dart';
import '../../node/WhileStatementNode.dart';

void handleWhileStatement(WhileStatement node, FunctionDeclarationNode? func) {
  // print('node:' + node.toSource());
  var gnNode = WhileStatementNode();
  gnNode.condition = convertExpression(node.condition.toString());
  gnNode.body =
      node.body is EmptyStatement ? '' : convertBlock(node.body.toString());
  func?.body.push(gnNode);
  return null;
}
