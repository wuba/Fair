import 'StatementNode.dart';

class WhileStatementNode extends StatementNode {
  String? condition;
  String? body;

  @override
  String toSource() {
    var finalBody = body == null || body?.isEmpty == true
        ? ';'
        : '''
    {
      $body
    }
    ''';
    return '''
    while ($condition) $finalBody
    ''';
  }
}