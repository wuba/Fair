import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';

import '../visitor/ClassDeclarationVisitor.dart';

String convertClassString(String content, [bool isDataBean = false]) {
  var result =
  // parseString(content: content, featureSet: FeatureSet.fromEnableFlags([]));
  parseString(content: content, featureSet: FeatureSet.latestLanguageVersion());
  var visitor = ClassDeclarationVisitor(isDataBean);
  result.unit.visitChildren(visitor);
  return visitor.genJsCode();
}