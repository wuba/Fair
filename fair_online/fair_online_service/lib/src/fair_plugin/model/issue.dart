import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:fair_online_service/src/fair_plugin/model/sugar_type.dart';

class BaseIssue {
  final plugin.AnalysisErrorSeverity analysisErrorSeverity;
  final plugin.AnalysisErrorType analysisErrorType;
  final int offset;
  final int length;
  final String message;
  final String code;
  final Sugar? type;

  BaseIssue(
    this.analysisErrorSeverity,
    this.analysisErrorType,
    this.offset,
    this.length,
    this.message,
    this.code, {
    this.type,
  });

  @override
  String toString() {
    return 'BaseIssue{analysisErrorSeverity: $analysisErrorSeverity, analysisErrorType: $analysisErrorType, offset: $offset, length: $length, message: $message, code: $code, type: $type}';
  }
}

class SugarIfIssue extends BaseIssue {
  final String condition;
  final String ifStatement;
  final String? elseStatement;
  final int ifOffset;
  final int ifLength;
  final String? exceptExpression;
  final String? actualExpression;
  final Sugar? type;

  SugarIfIssue(
    int offset,
    int length,
    String message,
    String code,
    this.ifOffset,
    this.ifLength,
    this.condition,
    this.ifStatement, {
    this.elseStatement,
    this.exceptExpression,
    this.actualExpression,
    this.type,
  }) : super(
          plugin.AnalysisErrorSeverity.ERROR,
          plugin.AnalysisErrorType.LINT,
          offset,
          length,
          message,
          code,
          type: type,
        );

  @override
  String toString() {
    return 'SugarIfIssue{condition: $condition, ifStatement: $ifStatement, elseStatement: $elseStatement, ifOffset: $ifOffset, ifLength: $ifLength, type: $type, analysisErrorSeverity: $analysisErrorSeverity, analysisErrorType: $analysisErrorType, targetExpression: $exceptExpression, actualExpression: $actualExpression}';
  }
}

class SugarMapIssue extends BaseIssue {
  final int mapOffset;
  final int mapLength;
  final String? indexVariable;
  final String? forLooperBody;
  final String? localVariable;
  final String? builderParts;
  final String dataVariable;
  final Sugar? type;

  SugarMapIssue(
    int offset,
    int length,
    String message,
    String code,
    this.mapOffset,
    this.mapLength,
    this.indexVariable,
    this.forLooperBody,
    this.localVariable,
    this.builderParts,
    this.dataVariable, {
    this.type,
  }) : super(
          plugin.AnalysisErrorSeverity.ERROR,
          plugin.AnalysisErrorType.LINT,
          offset,
          length,
          message,
          code,
          type: type,
        );

  @override
  String toString() {
    return 'SugarMapIssue{mapOffset: $mapOffset, mapLength: $mapLength, forLoopParts: $indexVariable, forLooperBody: $forLooperBody, localVariable: $localVariable, builderParts: $builderParts, dataVariable: $dataVariable, type: $type, analysisErrorSeverity: $analysisErrorSeverity, analysisErrorType: $analysisErrorType}';
  }
}
