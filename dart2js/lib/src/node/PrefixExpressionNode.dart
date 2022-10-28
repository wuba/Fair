import 'GenericStatementNode.dart';
import 'StatementNode.dart';

class PrefixExpressionNode extends StatementNode {
  String? operator;
  GenericStatementNode? operand;

  @override
  String toSource() {
    return '''$operator${operand?.toSource()}''';
  }
}