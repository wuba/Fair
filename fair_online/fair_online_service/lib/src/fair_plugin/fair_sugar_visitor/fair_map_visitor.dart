import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:fair_online_service/src/fair_plugin/constant/fair_constants.dart';
import 'package:fair_online_service/src/fair_plugin/model/issue.dart';
import 'package:fair_online_service/src/fair_plugin/model/sugar_type.dart';
import 'package:fair_online_service/src/fair_plugin/utils/string_utils.dart';

class SugarMapVisitor extends RecursiveAstVisitor<void> {
  final issues = <BaseIssue>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    node.visitChildren(this);
    var target = node.target;
    var token = node.methodName.token;
    if (target != null &&
        token.value() == 'map' &&
        node.argumentList.arguments.first is FunctionExpression) {
      var offset = token.offset;
      var length = token.length;
      var argument = node.argumentList.arguments.first;

      issues.add(SugarMapIssue(
          offset,
          length,
          SUGGEST_MESSAGE.format(['map', Sugar.map]),
          Sugar.map.toString(),
          node.offset,
          node.length,
          null,
          null,
          null,
          argument.toSource(),
          target.toSource(),
          type: Sugar.map));
      var body = argument.childEntities
          .firstWhere((element) => element.toString().contains("=>"));
      issues.add(SugarMapIssue(
          offset,
          length,
          SUGGEST_MESSAGE.format(['map', "带索引的${Sugar.mapEach}"]),
          Sugar.mapEach.toString(),
          node.offset,
          node.length,
          null,
          null,
          "item",
          body.toString().replaceAll("=>", ""),
          target.toSource(),
          type: Sugar.mapEach));
    }
  }

  @override
  void visitForStatement(ForStatement node) {
    node.visitChildren(this);
    var looperBody = node.body.toSource();

    var forLoopParts = node.forLoopParts;
    var forKeyword = node.forKeyword;
    var localVariable;
    var dataVariable;
    if (forLoopParts is ForPartsWithDeclarations) {
      var iterable = forLoopParts.condition?.childEntities;
      if (null != iterable && iterable.length > 2) {
        var dataStr = iterable.elementAt(2).toString();
        dataVariable = dataStr.substring(0, dataStr.indexOf("."));
      }

      issues.add(SugarMapIssue(
          forKeyword.offset,
          forKeyword.length,
          SUGGEST_MESSAGE.format([forKeyword, Sugar.mapEach]),
          Sugar.mapEach.toString(),
          node.offset,
          node.length,
          iterable?.elementAt(0).toString(),
          looperBody.replaceAll(";", ""),
          "item",
          null,
          dataVariable,
          type: Sugar.mapEach));
      return;
    }

    var beginIndex = looperBody.indexOf(";");
    var endIndex = looperBody.lastIndexOf(";");
    if (beginIndex != endIndex) {
      return;
    }
    looperBody =
        looperBody.replaceAll("{", "").replaceAll("}", "").replaceAll(";", "");
    if (forLoopParts is ForEachPartsWithDeclaration) {
      localVariable = forLoopParts.loopVariable.identifier.toSource();
      dataVariable = forLoopParts.iterable.toSource();
      issues.add(SugarMapIssue(
        forKeyword.offset,
        forKeyword.length,
        SUGGEST_MESSAGE.format(['for', Sugar.map]),
        Sugar.map.toString(),
        node.offset,
        node.length,
        null,
        looperBody,
        localVariable,
        null,
        dataVariable,
        type: Sugar.map,
      ));
    }
  }
}
