import 'StatementNode.dart';

class ReturnStatementNode extends StatementNode {
  String? expr;

  @override
  String toSource() {
    String exprR = expr ?? "";
    if (exprR != null && exprR.isNotEmpty) {
      if (exprR.startsWith("Future(")) {
        exprR = exprR.replaceAll("Future(", "Promise.resolve().then(");
      }
    }

    return '''
    return $exprR${!(exprR.endsWith(';')) ? ';' : ''}
    ''';
  }
}