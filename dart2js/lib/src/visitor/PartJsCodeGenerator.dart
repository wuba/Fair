
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../utils/const.dart';

class PartJsCodeGenerator extends SimpleAstVisitor<PartJsCodeGenerator> {
  // libPath, isDataBean, moduleAlias
  List<Tuple<String, bool, String>> importLocalFiles =
  <Tuple<String, bool, String>>[];
  var BeanDir = '/bean/';
  var PackagePrefix = new RegExp('(dart|package):');

  @override
  PartJsCodeGenerator? visitImportDirective(ImportDirective node) {
    var libraryPath = node.uri.stringValue;
    if (libraryPath?.contains(BeanDir) == true) {
      importLocalFiles.add(Tuple(libraryPath, true, node.prefix?.toSource()));
    } else if (!(libraryPath?.startsWith(PackagePrefix) ?? false)) {
      importLocalFiles.add(Tuple(libraryPath, false, node.prefix?.toSource()));
    }
    return null;
  }

  void parse(String filePath) {
    var file = File(filePath);
    var result = parseFile(
        path: Platform.isWindows
            ? filePath
            : file.absolute.uri.normalizePath().path,
        featureSet: FeatureSet.fromEnableFlags([]));
    result.unit.visitChildren(this);
  }
}