import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertArrayFuncExpression.dart';
import '../../covert/convertFunctionExpression.dart';

String handleFuncitonExpression(FunctionExpression currentNode) {
  return currentNode.body is ExpressionFunctionBody
      ? convertArrayFuncExpression(currentNode)
      : convertFunctionExpression(currentNode.toString());
}