import 'package:analyzer/dart/ast/ast.dart';

import '../../covert/convertExpression.dart';

String handleMapLiteral(SetOrMapLiteral literal) {
  if (literal.elements.isEmpty) {
    return '{}';
  } else {
    if (literal.elements.first is MapLiteralEntry) {
      var res = StringBuffer('{');
      literal.elements.cast<MapLiteralEntry>().forEach((element) {
        res.write(
            '[${convertExpression(element.key.toString())}]: ${element.value is MapLiteralEntry ? handleMapLiteral(element.value as SetOrMapLiteral) : convertExpression(element.value.toString())},');
      });
      res.write('}');
      return res.toString();
    } else {
      var res = StringBuffer('[');
      literal.elements.forEach((element) {
        res.write('${convertExpression(element.toString())},');
      });
      res.write(']');
      return res.toString();
    }
  }
}