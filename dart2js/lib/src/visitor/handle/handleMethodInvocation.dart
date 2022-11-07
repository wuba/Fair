import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertExpression.dart';
import '../../node/MethodInvokeStatementNode.dart';

MethodInvokeStatementNode handleMethodInvocation(
    MethodInvocation currentNode, String? parentClass) {
  var gnNode = MethodInvokeStatementNode();
  gnNode.parentClassName = parentClass;
  gnNode.thiz = currentNode.target != null
      ? convertExpression(currentNode.target.toString())
      : '';
  gnNode.methodName = currentNode.methodName.toString();
  currentNode.argumentList.arguments.forEach((arg) {
    if (arg is NamedExpression) {
      gnNode.namedParameters.add([
        arg.name.label.toString(),
        convertExpression(arg.expression.toString())
      ]);
    } else {
      gnNode.unnamedParameters.add(convertExpression(arg.toString()));
    }
  });
  return gnNode;
}
