import 'package:analyzer/dart/ast/ast.dart';

import '../node/ArrowFunctionExpressionNode.dart';
import '../node/GenericStatementNode.dart';
import 'convertExpression.dart';

String convertArrayFuncExpression(FunctionExpression code) {
  var body = code.body as ExpressionFunctionBody;
  if (body.functionDefinition.toString() == '=>') {
    var gnNode = ArrowFunctionExpressionNode();
    // TODO: 支持命名参数、可选参数
    code.parameters?.parameters.forEach((element) {
      // gnNode.argumentList.add([element.identifier.toString()]);
      gnNode.argumentList.add([element.name.toString()]);
    });
    gnNode.body.push(
        GenericStatementNode(convertExpression(body.expression.toString())));
    return gnNode.toSource();
  } else {
    throw 'error';
  }
}