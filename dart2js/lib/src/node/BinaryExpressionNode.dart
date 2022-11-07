import 'GenericStatementNode.dart';
import 'StatementNode.dart';

class BinaryExpressionNode extends StatementNode {
  String? operator;
  GenericStatementNode? left;
  GenericStatementNode? right;

  @override
  String toSource() {
    return '''${left?.toSource()}$operator${right?.toSource()}''';
  }
}