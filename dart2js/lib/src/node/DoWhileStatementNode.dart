import 'WhileStatementNode.dart';

class DoWhileStatementNode extends WhileStatementNode {
  @override
  String toSource() {
    return '''
    do {
      $body
    } while ($condition);
    ''';
  }
}