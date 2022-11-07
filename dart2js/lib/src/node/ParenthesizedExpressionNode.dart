import 'GenericStatementNode.dart';

class ParenthesizedExpressionNode extends GenericStatementNode {
  ParenthesizedExpressionNode(String code_) : super(code_);

  @override
  String toSource() {
    return '''($code)''';
  }
}