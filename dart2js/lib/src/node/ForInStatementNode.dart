import 'GenericStatementNode.dart';
import 'StatementNode.dart';

class ForInStatementNode extends StatementNode {
  String? loopVariable;
  GenericStatementNode? iterable;
  String? body;

  @override
  String toSource() {
    return '''
    for (let $loopVariable in ${iterable?.toSource()}) {
      $body
    }
    ''';
  }
}
