import 'package:analyzer/dart/ast/ast.dart';

import '../covert/convertExpression.dart';
import 'StatementNode.dart';
import 'GenericStatementNode.dart';

class ListLiteralStatementNode extends StatementNode {
  List<StatementNode> elements = [];
  static const elsePlaceholder = '"__if_element_placeholder__"';
  var hasPlaceholder = false;

  void addElement(CollectionElement e) {
    var code = '';
    if (e is SpreadElement) {
      code = '...${convertExpression(e.expression.toString())}';
    } else if (e is IfElement) {
      hasPlaceholder = e.elseElement == null;
      var elseElem = hasPlaceholder
          ? elsePlaceholder
          : convertExpression(e.elseElement.toString());
      code =
      '(${convertExpression(e.condition.toString())}) ? ${convertExpression(e.thenElement.toString())} : $elseElem';
    } else {
      code = convertExpression(e.toString());
    }
    elements.add(GenericStatementNode(code));
  }

  @override
  String toSource() {
    return !hasPlaceholder
        ? '[${elements.map((e) => e.toString()).join(",")}]'
        : '''
    (function() {
      let __arr__ = [${elements.map((e) => e.toString()).join(",")}];
      return __arr__.filter(elem => elem !== $elsePlaceholder);
    })();
    ''';
  }
}