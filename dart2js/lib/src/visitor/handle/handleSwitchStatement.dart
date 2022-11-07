import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertExpression.dart';
import '../../covert/convertStatements.dart';
import '../../node/FunctionDeclarationNode.dart';
import '../../node/GenericStatementNode.dart';
import '../../node/SwitchStatementNode.dart';

void handleSwitchStatement(SwitchStatement node,FunctionDeclarationNode? func){
  var gnNode = SwitchStatementNode();
  gnNode.expr =
      GenericStatementNode(convertExpression(node.expression.toString()));
  if (node.members.isNotEmpty) {
    gnNode.cases = [];
    node.members.forEach((element) {
      if (element is SwitchCase) {
        if (element.statements.isEmpty) {
          gnNode.cases?.add([element.expression.toString()]);
        } else {
          gnNode.cases?.add([
            element.expression.toString(),
            convertStatements(
                element.statements.map((e) => e.toString()).join(''))
          ]);
        }
      } else if (element is SwitchDefault) {
        gnNode.default_ = convertStatements(
            element.statements.map((e) => e.toString()).join(''));
      } else {
        throw Exception('error: ${element.toString()}');
      }
    });
  }
  func?.body.push(gnNode);
  return null;
}