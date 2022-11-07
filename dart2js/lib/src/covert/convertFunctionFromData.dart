import 'package:analyzer/dart/analysis/utilities.dart';

import '../visitor/SimpleFunctionGenerator.dart';
import '../declaration/ClassDeclarationData.dart';
import '../node/GenericStatementNode.dart';
import '../declaration/MethodDeclarationData.dart';

String convertFunctionFromData(MethodDeclarationData? data,
    [ClassDeclarationData? ctx]) {
  var content = data?.body ?? '';
  if (data?.isStatic ?? false) content = content.replaceAll('static', '');
  var res = parseString(content: content);
  var generator = SimpleFunctionGenerator(
      isArrowFunc: data?.isArrow ?? false,
      renamedParameters: data?.renamedParameters,
      parentClass: ctx?.parentClass);
  generator.func
    ?..withContext = true
    ..classHasStaticFields =
        (ctx?.fields.any((element) => element.isStatic) ?? false) ||
            (ctx?.methods.any((element) =>
            element.isStatic &&
                !element.isFactory &&
                !element.isGenerativeConstructor) ??
                false)
    ..isStatic = data?.isStatic ?? false;
  res.unit.visitChildren(generator);

  if (ctx != null) {
    generator.func?.className = ctx.className;
    generator.func
      ?..isGenerativeConstructor = data?.isGenerativeConstructor ?? false
      ..isRedirectConstructor = data?.isRedirectConstructor ?? false;
  }

  if (data?.abtractedInitializer != null &&
      data!.abtractedInitializer.isNotEmpty) {
    generator.func?.body.statements.insert(
        0, GenericStatementNode(data.abtractedInitializer.join('\r\n')));
  }
  return generator.func?.toSource() ?? '';
}