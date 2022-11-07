import 'package:analyzer/dart/analysis/utilities.dart';

import '../visitor/SimpleFunctionGenerator.dart';
import '../funs/shouldErrorBeIgnored.dart';

String convertBlock(String code) {
  // print("[convertBlock]" + code);
  var res = parseString(
      content: '''dummy() async $code''', throwIfDiagnostics: false);

  if (res.errors.isNotEmpty) {
    if (shouldErrorBeIgnored(res.errors)) {
      // ignore
    } else {
      throw ArgumentError();
    }
  }

  var generator = SimpleFunctionGenerator();
  res.unit.visitChildren(generator);
  return generator.func?.body.toSource() ?? '';
}
