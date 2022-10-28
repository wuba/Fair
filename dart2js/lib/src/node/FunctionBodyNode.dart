import 'StatementNode.dart';

class FunctionBodyNode {
  List<StatementNode> statements = [];

  void push(StatementNode node) {
    statements.add(node);
  }

  String toSource() {
    return statements.map((e) => e.toSource()).join('\r\n');
  }
}