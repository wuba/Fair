import 'package:analyzer/dart/ast/ast.dart';

String handleStringTemplate(SingleStringLiteral node) {
  var res = StringBuffer();
  var quote = '';
  if (node is StringInterpolation) {
    quote = '`';
    res.write(quote);
    node.elements.forEach((element) {
      if (element is InterpolationString) {
        res.write(element.value);
      } else if (element is InterpolationExpression) {
        res.write('''\${${element.expression.toString()}}''');
      }
    });
  } else if (node is SimpleStringLiteral) {
    var lexeme = node.literal.lexeme;
    quote =
        lexeme.length > 3 && lexeme.substring(0, 3) == "'''" ? '`' : lexeme[0];
    res.write(quote);
    res.write(node.value);
  } else {
    throw 'Unsupported string literal: ${node.stringValue}';
  }

  res.write(quote);
  return res.toString();
}
