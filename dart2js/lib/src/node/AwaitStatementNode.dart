import 'StatementNode.dart';
import '../funs/addCommaAsNeeded.dart';

class AwaitStatementNode extends StatementNode {
  StatementNode? expr;

  @override
  String toSource() {
    return '''await ${addCommaAsNeeded(expr?.toSource())}''';
  }
}