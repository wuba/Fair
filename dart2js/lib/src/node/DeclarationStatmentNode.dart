import 'StatementNode.dart';

class DeclarationStatmentNode extends StatementNode {
  List<String> variables = [];

  @override
  String toSource() {
    return '''
      let ${variables.join(',')};
    ''';
  }
}