import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:fair_online_service/src/visitor/fair_patch_visitor.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('custom_code_anno_checker');

/// 检测有无FairPatch注解
bool isValidCustomComponent(String source) {
  //如果传入的source是有错误的，可能会导致抽象语法树转换失败
  ParseStringResult? parseResult;
  try {
    parseResult = parseString(content: source);
  } catch (e) {
    _logger.warning('isValidCustomComponent parseString error ===>$e');
  }

  if (parseResult != null) {
    var compilationUnit = parseResult.unit;
    final visitor = FairPatchVisitor();
    //遍历AST
    compilationUnit.accept(visitor);
    if (visitor.pages.isNotEmpty) {
      return true;
    }
  }
  return false;
}