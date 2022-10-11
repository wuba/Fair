import '../funs/removeCommaAsNeeded.dart';
import 'StatementNode.dart';
import '../funs/addCommaAsNeeded.dart';

class ForStatementNode extends StatementNode {
  String initExpr = '';
  String? conditionalExpr;
  String stepExpr = '';
  String? body;

  @override
  String toSource() {
    return '''
    for (${initExpr.isEmpty ? ';' : initExpr} ${addCommaAsNeeded(conditionalExpr)} ${removeCommaAsNeeded(stepExpr)}) {
      $body
    }
    ''';
  }
}