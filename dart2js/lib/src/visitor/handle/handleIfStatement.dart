import 'package:analyzer/dart/ast/ast.dart';

import 'handleChainIfStatement.dart';
import '../../node/FunctionDeclarationNode.dart';
import '../../node/IfStatementNode.dart';

void handleIfStatement(IfStatement node,FunctionDeclarationNode? func){
  var gnNode = IfStatementNode();
  handleChainIfStatement(node, gnNode);
  func?.body.push(gnNode);
}