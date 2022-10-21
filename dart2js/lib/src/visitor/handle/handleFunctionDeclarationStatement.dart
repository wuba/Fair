import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertFunction.dart';
import '../../node/FunctionDeclarationNode.dart';
import '../../node/GenericStatementNode.dart';

handleFunctionDeclarationStatement(
    FunctionDeclarationStatement node, FunctionDeclarationNode? func) {
  func?.body.push(GenericStatementNode(
      convertFunction(node.functionDeclaration.toString())));
}
