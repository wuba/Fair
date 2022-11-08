import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertExpression.dart';
import '../../node/FunctionDeclarationNode.dart';
import '../../node/TryStatementNode.dart';
import '../../covert/convertBlock.dart';

handleTryStatement(TryStatement node, FunctionDeclarationNode? func) {
  // print("try1: " + node.toString());
  // print("try2: " + node.body.toString());

  var gnNode = TryStatementNode();

  // 处理try 中的body
  gnNode.tryBody = node.body is Block
      ? convertBlock(node.body.toString())
      : convertExpression(node.body.toString());

  // 处理catch 中的内容

  node.catchClauses.forEach((element) {
    // 暂时不支持on 语法，有 on语法的 expception 暂时不处理
    if (element.onKeyword == null) {
      gnNode.catchBody = convertBlock(element.body.toString());
      gnNode.exceptionParameter = element.exceptionParameter.toString();
      gnNode.stackTraceParameter = element.stackTraceParameter.toString();
    }
  });

  // 处理final 中的逻辑
  if (node.finallyBlock != null) {
    gnNode.finallyBody = convertBlock(node.finallyBlock.toString());
  }

  func?.body.push(gnNode);
}
