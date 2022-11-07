import 'package:analyzer/dart/analysis/utilities.dart';

import '../visitor/SimpleFunctionGenerator.dart';

String convertFunction(String code,
    {bool isArrow = false,
      bool isClassMethod = false,
      bool classHasStaticFields = false}) {
  var res = parseString(content: code);
  var generator = SimpleFunctionGenerator(isArrowFunc: isArrow);
  res.unit.visitChildren(generator);
  generator.func
    ?..withContext = isClassMethod
    ..classHasStaticFields = classHasStaticFields;
  return generator.func?.toSource() ?? '';
}