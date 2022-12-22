import 'package:analysis_server_lib/analysis_server_lib.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:fair_online_service/src/fair_plugin/constant/fair_constants.dart';
import 'package:fair_online_service/src/fair_plugin/model/issue.dart';
import 'package:fair_online_service/src/fair_plugin/model/sugar_type.dart';
import 'package:fair_online_service/src/fair_plugin/model/template.dart';
import 'package:fair_online_service/src/fair_plugin/utils/string_utils.dart';

AnalysisError analysisErrorFor(
    String path, BaseIssue issue, CompilationUnit unit) {
  final offsetLocation = unit.lineInfo.getLocation(issue.offset);
  return AnalysisError(
    issue.analysisErrorSeverity.name,
    issue.analysisErrorType.name,
    Location(
      path,
      issue.offset,
      issue.length,
      offsetLocation.lineNumber,
      offsetLocation.columnNumber,
    ),
    issue.message,
    issue.code,
    correction: FAIR_CORRECTION.format([issue.code]),
    contextMessages: null,
    hasFix: true,
  );
}

AnalysisErrorFixes fixesFromIssue<T extends BaseIssue>(
        T issue, String filePath, CompilationUnit unit) =>
    AnalysisErrorFixes(
      analysisErrorFor(filePath, issue, unit),
      <SourceChange>[
        SourceChange(
          // '在fair项目中，请将build方法下的 \'if\' 替换成 \'Sugar.ifEqualBool\'',
          issue.message,
          <SourceFileEdit>[
            SourceFileEdit(
              filePath,
              DateTime.now().millisecondsSinceEpoch,
              getSourceEdit(issue),
            ),
          ],
          <LinkedEditGroup>[],
        ),
      ],
    );

List<SourceEdit> getSourceEdit(BaseIssue issue) {
  String replacement;
  if (issue is SugarIfIssue) {
    if (issue.type == Sugar.ifEqual) {
      replacement = sugarIfEqualTemplate(
        issue.actualExpression ?? '',
        issue.exceptExpression ?? '',
        issue.ifStatement,
        elseStatement: issue.elseStatement,
      );
    } else if (issue.type == Sugar.ifRange) {
      replacement = sugarIfRangeTemplate(
        issue.actualExpression ?? '',
        issue.exceptExpression ?? '',
        issue.ifStatement,
        elseStatement: issue.elseStatement,
      );
    } else {
      replacement = sugarIfEqualBoolTemplate(
        issue.condition,
        issue.ifStatement,
        elseStatement: issue.elseStatement,
      );
    }
    return [SourceEdit(issue.ifOffset, issue.ifLength, replacement)];
  }
  if (issue is SugarMapIssue) {
    if (issue.type == Sugar.map) {
      if (null == issue.builderParts) {
        replacement = sugarMapTemplate(
          issue.dataVariable,
          issue.localVariable ?? '',
          issue.forLooperBody ?? '',
        );
        return [SourceEdit(issue.mapOffset, issue.mapLength, replacement)];
      } else {
        replacement = sugarMapTemplate2(
          issue.dataVariable,
          issue.builderParts!,
        );
        return [SourceEdit(issue.mapOffset, issue.mapLength, replacement)];
      }
    }
    //mapEach
    if (issue.type == Sugar.mapEach) {
      if (null == issue.builderParts) {
        replacement = sugarMapEachTemplate(
          issue.dataVariable,
          issue.indexVariable ?? '',
          issue.localVariable ?? '',
          issue.forLooperBody ?? '',
        );
        return [SourceEdit(issue.mapOffset, issue.mapLength, replacement)];
      }
      replacement = sugarMapEachTemplate2(
        issue.dataVariable,
        issue.localVariable ?? '',
        issue.builderParts!,
      );
      return [SourceEdit(issue.mapOffset, issue.mapLength, replacement)];
    }
  }
  return [];
}
