import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertExpression.dart';
import 'handleStringTemplate.dart';
import '../../node/AssignmentStatementNode.dart';
import '../../node/AwaitStatementNode.dart';
import '../../node/BinaryExpressionNode.dart';
import '../../node/CascadeOperatorStatementNode.dart';
import '../../node/ConditionalExpressionNode.dart';
import '../../node/FunctionDeclarationNode.dart';
import '../../node/GenericStatementNode.dart';
import '../../node/IndexExpressionNode.dart';
import '../../node/ListLiteralStatementNode.dart';
import '../../node/NewOperatorStatementNode.dart';
import '../../node/ParenthesizedExpressionNode.dart';
import '../../node/PrefixExpressionNode.dart';
import '../../node/PropertyAccessStatementNode.dart';
import 'handleCreationCall.dart';
import 'handleFuncitonExpression.dart';
import 'handleMethodInvocation.dart';

void handleExpressionStatement(ExpressionStatement node,
    FunctionDeclarationNode? func, String? parentClass) {
  // print('ExpressionStatement:' + node.toSource());
  if (node.expression is MethodInvocation) {
    func?.body.push(handleMethodInvocation(
        node.expression as MethodInvocation, parentClass));
  } else if (node.expression is PropertyAccess) {
    var gnNode = PropertyAccessStatementNode();
    var currentNode = node.expression as PropertyAccess;
    if (currentNode.target != null) {
      gnNode.thiz = convertExpression(currentNode.target.toString());
    }
    gnNode.fieldName = currentNode.propertyName.toString();
    func?.body.push(gnNode);
  } else if (node.expression is FunctionExpression) {
    func?.body.push(GenericStatementNode(
        handleFuncitonExpression(node.expression as FunctionExpression)));
  } else if (node.expression is AssignmentExpression) {
    var gnNode = AssignmentStatementNode();
    var currentNode = node.expression as AssignmentExpression;
    if (currentNode.leftHandSide is IndexExpression) {
      var gnNode1 = IndexExpressionNode();
      var currentNode1 = currentNode.leftHandSide as IndexExpression;
      gnNode1.key = GenericStatementNode(
          convertExpression(currentNode1.index.toString()));
      gnNode1.target = GenericStatementNode(
          convertExpression(currentNode1.target.toString()));
      gnNode1.value = GenericStatementNode(
          convertExpression(currentNode.rightHandSide.toString()));
      gnNode1.isSet = true;
      func?.body.push(gnNode1);
    } else {
      gnNode.leftSide = convertExpression(currentNode.leftHandSide.toString());
      gnNode.operator_ = currentNode.operator.toString();
      gnNode.rightSide = GenericStatementNode(
          convertExpression(currentNode.rightHandSide.toString()));
      func?.body.push(gnNode);
    }
  } else if (node.expression is CascadeExpression) {
    var gnNode = CascadeOperatorStatementNode();
    var currentNode = node.expression as CascadeExpression;
    gnNode.target = convertExpression(currentNode.target.toString());
    gnNode.cascades = [];
    currentNode.cascadeSections.forEach((element) {
      if (element is MethodInvocation) {
        gnNode.cascades?.add(handleMethodInvocation(element, parentClass));
      } else if (element is AssignmentExpression) {
        if (element.leftHandSide is PropertyAccess) {
          var leftSide = element.leftHandSide as PropertyAccess;
          if (leftSide.isCascaded) {
            var assignmentNode = PropertyAccessStatementNode();
            assignmentNode.fieldName = leftSide.propertyName.toString();
            assignmentNode.setVal =
                convertExpression(element.rightHandSide.toString());
            gnNode.cascades?.add(assignmentNode);
          } else {
            throw Exception(
                '''Not supported statement(s): ${element.toString()}''');
          }
        }
      } else {
        throw Exception(
            '''Not supported statement(s): ${element.toString()}''');
      }
    });
    func?.body.push(gnNode);
  } else if (node.expression is ConditionalExpression) {
    var gnNode = ConditionalExpressionNode();
    var currentNode = node.expression as ConditionalExpression;
    gnNode.condition = GenericStatementNode(
        convertExpression(currentNode.condition.toString()));
    gnNode.then = GenericStatementNode(
        convertExpression(currentNode.thenExpression.toString()));
    gnNode.elseExpr = GenericStatementNode(
        convertExpression(currentNode.elseExpression.toString()));
    func?.body.push(gnNode);
  } else if (node.expression is IndexExpression) {
    var gnNode = IndexExpressionNode();
    var currentNode = node.expression as IndexExpression;
    gnNode.key =
        GenericStatementNode(convertExpression(currentNode.index.toString()));
    gnNode.target =
        GenericStatementNode(convertExpression(currentNode.target.toString()));
    func?.body.push(gnNode);
  } else if (node.expression is ParenthesizedExpression) {
    var currentNode = node.expression as ParenthesizedExpression;
    var gnNode = ParenthesizedExpressionNode(
        convertExpression(currentNode.expression.toString()));
    func?.body.push(gnNode);
  } else if (node.expression is BinaryExpression) {
    var currentNode = node.expression as BinaryExpression;
    var gnNode = BinaryExpressionNode();
    gnNode.left = GenericStatementNode(
        convertExpression(currentNode.leftOperand.toString()));
    gnNode.right = GenericStatementNode(
        convertExpression(currentNode.rightOperand.toString()));
    gnNode.operator = currentNode.operator.toString();
    func?.body.push(gnNode);
  } else if (node.expression is PrefixExpression) {
    var currentNode = node.expression as PrefixExpression;
    var gnNode = PrefixExpressionNode();
    gnNode.operand =
        GenericStatementNode(convertExpression(currentNode.operand.toString()));
    gnNode.operator = currentNode.operator.toString();
    func?.body.push(gnNode);
  } else if (node.expression is IsExpression) {
    var currentNode = node.expression as IsExpression;
    func?.body.push(GenericStatementNode(
        convertExpression(currentNode.expression.toString())));
  } else if (node.expression is AsExpression) {
    var currentNode = node.expression as AsExpression;
    func?.body.push(GenericStatementNode(
        convertExpression(currentNode.expression.toString())));
  } else if (node.expression is AwaitExpression) {
    var gnNode = AwaitStatementNode();
    var currentNode = node.expression as AwaitExpression;
    gnNode.expr = GenericStatementNode(
        convertExpression(currentNode.expression.toString()));
    func?.body.push(gnNode);
  } else if (node.expression is SingleStringLiteral) {
    func?.body.push(GenericStatementNode(
        handleStringTemplate(node.expression as SingleStringLiteral)));
  } else if (node.expression is InstanceCreationExpression) {
    var gnNode = NewOperatorStatementNode();
    gnNode = handleCreationCall(node.expression as InstanceCreationExpression);
    func?.body.push(gnNode);
  } else if (node.expression is ListLiteral) {
    var gnNode = ListLiteralStatementNode();
    var currentNode = node.expression as ListLiteral;
    currentNode.elements.forEach((e) => gnNode.addElement(e));
    func?.body.push(gnNode);
  } else {
    func?.body.push(GenericStatementNode(node.toSource()));
  }
  return null;
}
