import 'package:analyzer/dart/ast/ast.dart';

import '../../node/FunctionDeclarationNode.dart';
import '../../node/GenericStatementNode.dart';

void handleContinueStatement(
    ContinueStatement node, FunctionDeclarationNode? func) {
  func?.body.push(GenericStatementNode(node.toString()));
}
