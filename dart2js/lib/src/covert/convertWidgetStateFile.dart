//
// 去掉类型转换
// 支持匿名集合对象
// try-catch
// yeild
// 列表、Map对象、RegExp、Date、其他基础数据类型及其对应操作
//
// 操作符：,、~/
// escaped string（r修饰符）
// int.parse
// operator override
// get & set
// 高级特性：扩展方法 & part文件合并 & mixin & noSuchMethod
// 范型
// 注解(annotation)
// async: stream completer yield zone
// 省略的this
//
//
// done
// declare
// asignment
// static
// extend & super & constructor
// if / for / do-while / while-do / switch / for-in
// continue&break
// method-invoke&cacades
// inner function
// async&await
// new操作
// ?. / ... / ?: if表达式
// 对 bool表达式中的 is 进行处理
// 表达式嵌套
// is 类型检测 直接判断对象是否为空
// as 类型转换 直接去掉类型转换
//
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';

import '../utils/const.dart';
import '../utils/uglify.dart';
import '../visitor/WidgetStateGenerator.dart';

String convertWidgetStateFile(String filePath, [bool isCompressed = false]) {
  var file = File(filePath);
  var stateFilePath =
  Platform.isWindows ? filePath : file.absolute.uri.normalizePath().path;
  var result = parseFile(
      // path: stateFilePath, featureSet: FeatureSet.fromEnableFlags([]));
      path: stateFilePath, featureSet: FeatureSet.latestLanguageVersion());
  var visitor = WidgetStateGenerator(stateFilePath);
  result.unit.visitChildren(visitor);

  transpileOption.modifySetState = true;
  return isCompressed ? uglify(visitor.genJsCode()) : visitor.genJsCode();
}