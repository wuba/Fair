import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertBlock.dart';
import '../../covert/convertExpression.dart';
import '../../covert/convertStatements.dart';
import '../../node/ForInStatementNode.dart';
import '../../node/ForStatementNode.dart';
import '../../node/FunctionDeclarationNode.dart';
import '../../node/GenericStatementNode.dart';

void handleForStatement(ForStatement node,FunctionDeclarationNode? func){
  var gnNode = ForStatementNode();
  if (node.forLoopParts is ForPartsWithDeclarations) {
    var forLoopParts = node.forLoopParts as ForPartsWithDeclarations;
    gnNode.initExpr =
        convertStatements(forLoopParts.variables.toString() + ';');
    if (forLoopParts.condition != null) {
      gnNode.conditionalExpr =
          convertStatements(forLoopParts.condition.toString() + ';');
    }
    gnNode.stepExpr = forLoopParts.updaters
        .map((e) => convertExpression(e.toString()))
        .join(',');
    gnNode.body = node.body is Block
        ? convertBlock(node.body.toString())
        : convertStatements(node.body.toString());
    func?.body.push(gnNode);
  } else if (node.forLoopParts is ForPartsWithExpression) {
    var forLoopParts = node.forLoopParts as ForPartsWithExpression;
    if (forLoopParts.condition != null) {
      gnNode.conditionalExpr =
          convertStatements(forLoopParts.condition.toString() + ';');
    }
    gnNode.stepExpr = forLoopParts.updaters
        .map((e) => convertExpression(e.toString()))
        .join(',');
    gnNode.body = node.body is Block
        ? convertBlock(node.body.toString())
        : convertStatements(node.body.toString());
    func?.body.push(gnNode);
  } else if (node.forLoopParts is ForEachPartsWithDeclaration) {
    var forLoopParts = node.forLoopParts as ForEachPartsWithDeclaration;
    var gnForInNode = ForInStatementNode();
    gnForInNode.loopVariable =
        // forLoopParts.loopVariable.identifier.toString();
        forLoopParts.loopVariable.name.toString();
    gnForInNode.iterable = GenericStatementNode(
        convertExpression(forLoopParts.iterable.toString()));
    gnForInNode.body = node.body is Block
        ? convertBlock(node.body.toString())
        : convertStatements(node.body.toString());
    func?.body.push(gnForInNode);
  }

  return null;
}