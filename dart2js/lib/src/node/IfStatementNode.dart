import 'StatementNode.dart';

class IfStatementNode extends StatementNode {
  String? condition;
  String? thenBody;
  String? lastElseBody;
  IfStatementNode? elseBody;

  @override
  String toSource() {
    var finalElseBody = '';
    if (elseBody != null) {
      finalElseBody = '''
      else ${elseBody?.toSource()}
      ''';
    } else if (lastElseBody != null) {
      finalElseBody = lastElseBody?.isEmpty == true
          ? ''
          : '''
      else {
        $lastElseBody
      }
    ''';
    }

    return '''
    if ($condition) {
      $thenBody
    } $finalElseBody
    ''';
  }
}