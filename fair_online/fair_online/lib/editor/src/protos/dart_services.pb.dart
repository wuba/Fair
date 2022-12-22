///
//  Generated code. Do not modify.
//  source: protos/dart_services.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CompileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CompileRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'source')
    ..aOB(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'returnSourceMap',
        protoName: 'returnSourceMap')
    ..hasRequiredFields = false;

  CompileRequest._() : super();
  factory CompileRequest({
    $core.String? source,
    $core.bool? returnSourceMap,
  }) {
    final _result = create();
    if (source != null) {
      _result.source = source;
    }
    if (returnSourceMap != null) {
      _result.returnSourceMap = returnSourceMap;
    }
    return _result;
  }
  factory CompileRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CompileRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CompileRequest clone() => CompileRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CompileRequest copyWith(void Function(CompileRequest) updates) =>
      super.copyWith((message) => updates(message as CompileRequest))
          as CompileRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CompileRequest create() => CompileRequest._();
  CompileRequest createEmptyInstance() => create();
  static $pb.PbList<CompileRequest> createRepeated() =>
      $pb.PbList<CompileRequest>();
  @$core.pragma('dart2js:noInline')
  static CompileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompileRequest>(create);
  static CompileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get source => $_getSZ(0);
  @$pb.TagNumber(1)
  set source($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSource() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get returnSourceMap => $_getBF(1);
  @$pb.TagNumber(2)
  set returnSourceMap($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasReturnSourceMap() => $_has(1);
  @$pb.TagNumber(2)
  void clearReturnSourceMap() => clearField(2);
}

class CompileDDCRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CompileDDCRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'source')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageName',
        protoName: 'pageName')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'type')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'runMode',
        protoName: 'runMode')
    ..hasRequiredFields = false;

  CompileDDCRequest._() : super();
  factory CompileDDCRequest({
    $core.String? source,
    $core.String? pageName,
    $core.String? type,
    $core.String? runMode,
  }) {
    final _result = create();
    if (source != null) {
      _result.source = source;
    }
    if (pageName != null) {
      _result.pageName = pageName;
    }
    if (type != null) {
      _result.type = type;
    }
    if (runMode != null) {
      _result.runMode = runMode;
    }
    return _result;
  }
  factory CompileDDCRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CompileDDCRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CompileDDCRequest clone() => CompileDDCRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CompileDDCRequest copyWith(void Function(CompileDDCRequest) updates) =>
      super.copyWith((message) => updates(message as CompileDDCRequest))
          as CompileDDCRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CompileDDCRequest create() => CompileDDCRequest._();
  CompileDDCRequest createEmptyInstance() => create();
  static $pb.PbList<CompileDDCRequest> createRepeated() =>
      $pb.PbList<CompileDDCRequest>();
  @$core.pragma('dart2js:noInline')
  static CompileDDCRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompileDDCRequest>(create);
  static CompileDDCRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get source => $_getSZ(0);
  @$pb.TagNumber(1)
  set source($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSource() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageName => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageName() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get runMode => $_getSZ(3);
  @$pb.TagNumber(4)
  set runMode($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasRunMode() => $_has(3);
  @$pb.TagNumber(4)
  void clearRunMode() => clearField(4);
}

class SourceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SourceRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'source')
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'offset',
        $pb.PbFieldType.O3)
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'filePath',
        protoName: 'filePath')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'type')
    ..hasRequiredFields = false;

  SourceRequest._() : super();
  factory SourceRequest({
    $core.String? source,
    $core.int? offset,
    $core.String? filePath,
    $core.String? type,
  }) {
    final _result = create();
    if (source != null) {
      _result.source = source;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    if (filePath != null) {
      _result.filePath = filePath;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory SourceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourceRequest clone() => SourceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourceRequest copyWith(void Function(SourceRequest) updates) =>
      super.copyWith((message) => updates(message as SourceRequest))
          as SourceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SourceRequest create() => SourceRequest._();
  SourceRequest createEmptyInstance() => create();
  static $pb.PbList<SourceRequest> createRepeated() =>
      $pb.PbList<SourceRequest>();
  @$core.pragma('dart2js:noInline')
  static SourceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceRequest>(create);
  static SourceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get source => $_getSZ(0);
  @$pb.TagNumber(1)
  set source($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSource() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get filePath => $_getSZ(2);
  @$pb.TagNumber(3)
  set filePath($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFilePath() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilePath() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);
}

class AnalysisResults extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'AnalysisResults',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<AnalysisIssue>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'issues',
        $pb.PbFieldType.PM,
        subBuilder: AnalysisIssue.create)
    ..pPS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'packageImports',
        protoName: 'packageImports')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  AnalysisResults._() : super();
  factory AnalysisResults({
    $core.Iterable<AnalysisIssue>? issues,
    $core.Iterable<$core.String>? packageImports,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (issues != null) {
      _result.issues.addAll(issues);
    }
    if (packageImports != null) {
      _result.packageImports.addAll(packageImports);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory AnalysisResults.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AnalysisResults.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AnalysisResults clone() => AnalysisResults()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AnalysisResults copyWith(void Function(AnalysisResults) updates) =>
      super.copyWith((message) => updates(message as AnalysisResults))
          as AnalysisResults; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AnalysisResults create() => AnalysisResults._();
  AnalysisResults createEmptyInstance() => create();
  static $pb.PbList<AnalysisResults> createRepeated() =>
      $pb.PbList<AnalysisResults>();
  @$core.pragma('dart2js:noInline')
  static AnalysisResults getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnalysisResults>(create);
  static AnalysisResults? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AnalysisIssue> get issues => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get packageImports => $_getList(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(2);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(2);
}

class AnalysisIssue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'AnalysisIssue',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'kind')
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'line',
        $pb.PbFieldType.O3)
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'sourceName',
        protoName: 'sourceName')
    ..aOB(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'hasFixes',
        protoName: 'hasFixes')
    ..a<$core.int>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'charStart',
        $pb.PbFieldType.O3,
        protoName: 'charStart')
    ..a<$core.int>(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'charLength',
        $pb.PbFieldType.O3,
        protoName: 'charLength')
    ..aOS(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'url')
    ..pc<DiagnosticMessage>(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'diagnosticMessages',
        $pb.PbFieldType.PM,
        protoName: 'diagnosticMessages',
        subBuilder: DiagnosticMessage.create)
    ..aOS(
        10,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'correction')
    ..hasRequiredFields = false;

  AnalysisIssue._() : super();
  factory AnalysisIssue({
    $core.String? kind,
    $core.int? line,
    $core.String? message,
    $core.String? sourceName,
    $core.bool? hasFixes,
    $core.int? charStart,
    $core.int? charLength,
    $core.String? url,
    $core.Iterable<DiagnosticMessage>? diagnosticMessages,
    $core.String? correction,
  }) {
    final _result = create();
    if (kind != null) {
      _result.kind = kind;
    }
    if (line != null) {
      _result.line = line;
    }
    if (message != null) {
      _result.message = message;
    }
    if (sourceName != null) {
      _result.sourceName = sourceName;
    }
    if (hasFixes != null) {
      _result.hasFixes = hasFixes;
    }
    if (charStart != null) {
      _result.charStart = charStart;
    }
    if (charLength != null) {
      _result.charLength = charLength;
    }
    if (url != null) {
      _result.url = url;
    }
    if (diagnosticMessages != null) {
      _result.diagnosticMessages.addAll(diagnosticMessages);
    }
    if (correction != null) {
      _result.correction = correction;
    }
    return _result;
  }
  factory AnalysisIssue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AnalysisIssue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AnalysisIssue clone() => AnalysisIssue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AnalysisIssue copyWith(void Function(AnalysisIssue) updates) =>
      super.copyWith((message) => updates(message as AnalysisIssue))
          as AnalysisIssue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AnalysisIssue create() => AnalysisIssue._();
  AnalysisIssue createEmptyInstance() => create();
  static $pb.PbList<AnalysisIssue> createRepeated() =>
      $pb.PbList<AnalysisIssue>();
  @$core.pragma('dart2js:noInline')
  static AnalysisIssue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnalysisIssue>(create);
  static AnalysisIssue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get kind => $_getSZ(0);
  @$pb.TagNumber(1)
  set kind($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get line => $_getIZ(1);
  @$pb.TagNumber(2)
  set line($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLine() => $_has(1);
  @$pb.TagNumber(2)
  void clearLine() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceName => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceName($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSourceName() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceName() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasFixes => $_getBF(4);
  @$pb.TagNumber(5)
  set hasFixes($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasHasFixes() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasFixes() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get charStart => $_getIZ(5);
  @$pb.TagNumber(6)
  set charStart($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCharStart() => $_has(5);
  @$pb.TagNumber(6)
  void clearCharStart() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get charLength => $_getIZ(6);
  @$pb.TagNumber(7)
  set charLength($core.int v) {
    $_setSignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasCharLength() => $_has(6);
  @$pb.TagNumber(7)
  void clearCharLength() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get url => $_getSZ(7);
  @$pb.TagNumber(8)
  set url($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearUrl() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<DiagnosticMessage> get diagnosticMessages => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get correction => $_getSZ(9);
  @$pb.TagNumber(10)
  set correction($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasCorrection() => $_has(9);
  @$pb.TagNumber(10)
  void clearCorrection() => clearField(10);
}

class DiagnosticMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DiagnosticMessage',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'line',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'charStart',
        $pb.PbFieldType.O3,
        protoName: 'charStart')
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'charLength',
        $pb.PbFieldType.O3,
        protoName: 'charLength')
    ..hasRequiredFields = false;

  DiagnosticMessage._() : super();
  factory DiagnosticMessage({
    $core.String? message,
    $core.int? line,
    $core.int? charStart,
    $core.int? charLength,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    if (line != null) {
      _result.line = line;
    }
    if (charStart != null) {
      _result.charStart = charStart;
    }
    if (charLength != null) {
      _result.charLength = charLength;
    }
    return _result;
  }
  factory DiagnosticMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DiagnosticMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DiagnosticMessage clone() => DiagnosticMessage()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DiagnosticMessage copyWith(void Function(DiagnosticMessage) updates) =>
      super.copyWith((message) => updates(message as DiagnosticMessage))
          as DiagnosticMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiagnosticMessage create() => DiagnosticMessage._();
  DiagnosticMessage createEmptyInstance() => create();
  static $pb.PbList<DiagnosticMessage> createRepeated() =>
      $pb.PbList<DiagnosticMessage>();
  @$core.pragma('dart2js:noInline')
  static DiagnosticMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DiagnosticMessage>(create);
  static DiagnosticMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get line => $_getIZ(1);
  @$pb.TagNumber(2)
  set line($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLine() => $_has(1);
  @$pb.TagNumber(2)
  void clearLine() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get charStart => $_getIZ(2);
  @$pb.TagNumber(3)
  set charStart($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCharStart() => $_has(2);
  @$pb.TagNumber(3)
  void clearCharStart() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get charLength => $_getIZ(3);
  @$pb.TagNumber(4)
  set charLength($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCharLength() => $_has(3);
  @$pb.TagNumber(4)
  void clearCharLength() => clearField(4);
}

class VersionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'VersionRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  VersionRequest._() : super();
  factory VersionRequest() => create();
  factory VersionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory VersionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  VersionRequest clone() => VersionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  VersionRequest copyWith(void Function(VersionRequest) updates) =>
      super.copyWith((message) => updates(message as VersionRequest))
          as VersionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VersionRequest create() => VersionRequest._();
  VersionRequest createEmptyInstance() => create();
  static $pb.PbList<VersionRequest> createRepeated() =>
      $pb.PbList<VersionRequest>();
  @$core.pragma('dart2js:noInline')
  static VersionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionRequest>(create);
  static VersionRequest? _defaultInstance;
}

class CompileResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CompileResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'sourceMap',
        protoName: 'sourceMap')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  CompileResponse._() : super();
  factory CompileResponse({
    $core.String? result,
    $core.String? sourceMap,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (sourceMap != null) {
      _result.sourceMap = sourceMap;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CompileResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CompileResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CompileResponse clone() => CompileResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CompileResponse copyWith(void Function(CompileResponse) updates) =>
      super.copyWith((message) => updates(message as CompileResponse))
          as CompileResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CompileResponse create() => CompileResponse._();
  CompileResponse createEmptyInstance() => create();
  static $pb.PbList<CompileResponse> createRepeated() =>
      $pb.PbList<CompileResponse>();
  @$core.pragma('dart2js:noInline')
  static CompileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompileResponse>(create);
  static CompileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceMap => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceMap($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSourceMap() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceMap() => clearField(2);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(2);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(2);
}

class CompileDDCResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CompileDDCResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'modulesBaseUrl',
        protoName: 'modulesBaseUrl')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  CompileDDCResponse._() : super();
  factory CompileDDCResponse({
    $core.String? result,
    $core.String? modulesBaseUrl,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (modulesBaseUrl != null) {
      _result.modulesBaseUrl = modulesBaseUrl;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CompileDDCResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CompileDDCResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CompileDDCResponse clone() => CompileDDCResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CompileDDCResponse copyWith(void Function(CompileDDCResponse) updates) =>
      super.copyWith((message) => updates(message as CompileDDCResponse))
          as CompileDDCResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CompileDDCResponse create() => CompileDDCResponse._();
  CompileDDCResponse createEmptyInstance() => create();
  static $pb.PbList<CompileDDCResponse> createRepeated() =>
      $pb.PbList<CompileDDCResponse>();
  @$core.pragma('dart2js:noInline')
  static CompileDDCResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompileDDCResponse>(create);
  static CompileDDCResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get modulesBaseUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set modulesBaseUrl($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasModulesBaseUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearModulesBaseUrl() => clearField(2);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(2);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(2);
}

class DocumentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DocumentResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..m<$core.String, $core.String>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'info',
        entryClassName: 'DocumentResponse.InfoEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('dart_services.api'))
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  DocumentResponse._() : super();
  factory DocumentResponse({
    $core.Map<$core.String, $core.String>? info,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (info != null) {
      _result.info.addAll(info);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory DocumentResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DocumentResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DocumentResponse clone() => DocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DocumentResponse copyWith(void Function(DocumentResponse) updates) =>
      super.copyWith((message) => updates(message as DocumentResponse))
          as DocumentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DocumentResponse create() => DocumentResponse._();
  DocumentResponse createEmptyInstance() => create();
  static $pb.PbList<DocumentResponse> createRepeated() =>
      $pb.PbList<DocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static DocumentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DocumentResponse>(create);
  static DocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.String> get info => $_getMap(0);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CompleteResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CompleteResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'replacementOffset',
        $pb.PbFieldType.O3,
        protoName: 'replacementOffset')
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'replacementLength',
        $pb.PbFieldType.O3,
        protoName: 'replacementLength')
    ..pc<Completion>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'completions',
        $pb.PbFieldType.PM,
        subBuilder: Completion.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  CompleteResponse._() : super();
  factory CompleteResponse({
    $core.int? replacementOffset,
    $core.int? replacementLength,
    $core.Iterable<Completion>? completions,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (replacementOffset != null) {
      _result.replacementOffset = replacementOffset;
    }
    if (replacementLength != null) {
      _result.replacementLength = replacementLength;
    }
    if (completions != null) {
      _result.completions.addAll(completions);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CompleteResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CompleteResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CompleteResponse clone() => CompleteResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CompleteResponse copyWith(void Function(CompleteResponse) updates) =>
      super.copyWith((message) => updates(message as CompleteResponse))
          as CompleteResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CompleteResponse create() => CompleteResponse._();
  CompleteResponse createEmptyInstance() => create();
  static $pb.PbList<CompleteResponse> createRepeated() =>
      $pb.PbList<CompleteResponse>();
  @$core.pragma('dart2js:noInline')
  static CompleteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteResponse>(create);
  static CompleteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get replacementOffset => $_getIZ(0);
  @$pb.TagNumber(1)
  set replacementOffset($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReplacementOffset() => $_has(0);
  @$pb.TagNumber(1)
  void clearReplacementOffset() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get replacementLength => $_getIZ(1);
  @$pb.TagNumber(2)
  set replacementLength($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasReplacementLength() => $_has(1);
  @$pb.TagNumber(2)
  void clearReplacementLength() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<Completion> get completions => $_getList(2);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(3);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(3);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(3);
}

class Completion extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Completion',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..m<$core.String, $core.String>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'completion',
        entryClassName: 'Completion.CompletionEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('dart_services.api'))
    ..hasRequiredFields = false;

  Completion._() : super();
  factory Completion({
    $core.Map<$core.String, $core.String>? completion,
  }) {
    final _result = create();
    if (completion != null) {
      _result.completion.addAll(completion);
    }
    return _result;
  }
  factory Completion.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Completion.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Completion clone() => Completion()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Completion copyWith(void Function(Completion) updates) =>
      super.copyWith((message) => updates(message as Completion))
          as Completion; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Completion create() => Completion._();
  Completion createEmptyInstance() => create();
  static $pb.PbList<Completion> createRepeated() => $pb.PbList<Completion>();
  @$core.pragma('dart2js:noInline')
  static Completion getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Completion>(create);
  static Completion? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.String> get completion => $_getMap(0);
}

class FixesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'FixesResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<ProblemAndFixes>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'fixes',
        $pb.PbFieldType.PM,
        subBuilder: ProblemAndFixes.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  FixesResponse._() : super();
  factory FixesResponse({
    $core.Iterable<ProblemAndFixes>? fixes,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (fixes != null) {
      _result.fixes.addAll(fixes);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory FixesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FixesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FixesResponse clone() => FixesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FixesResponse copyWith(void Function(FixesResponse) updates) =>
      super.copyWith((message) => updates(message as FixesResponse))
          as FixesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixesResponse create() => FixesResponse._();
  FixesResponse createEmptyInstance() => create();
  static $pb.PbList<FixesResponse> createRepeated() =>
      $pb.PbList<FixesResponse>();
  @$core.pragma('dart2js:noInline')
  static FixesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FixesResponse>(create);
  static FixesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProblemAndFixes> get fixes => $_getList(0);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class ProblemAndFixes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ProblemAndFixes',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<CandidateFix>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'fixes',
        $pb.PbFieldType.PM,
        subBuilder: CandidateFix.create)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'problemMessage',
        protoName: 'problemMessage')
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'offset',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'length',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  ProblemAndFixes._() : super();
  factory ProblemAndFixes({
    $core.Iterable<CandidateFix>? fixes,
    $core.String? problemMessage,
    $core.int? offset,
    $core.int? length,
  }) {
    final _result = create();
    if (fixes != null) {
      _result.fixes.addAll(fixes);
    }
    if (problemMessage != null) {
      _result.problemMessage = problemMessage;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    if (length != null) {
      _result.length = length;
    }
    return _result;
  }
  factory ProblemAndFixes.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ProblemAndFixes.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ProblemAndFixes clone() => ProblemAndFixes()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ProblemAndFixes copyWith(void Function(ProblemAndFixes) updates) =>
      super.copyWith((message) => updates(message as ProblemAndFixes))
          as ProblemAndFixes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProblemAndFixes create() => ProblemAndFixes._();
  ProblemAndFixes createEmptyInstance() => create();
  static $pb.PbList<ProblemAndFixes> createRepeated() =>
      $pb.PbList<ProblemAndFixes>();
  @$core.pragma('dart2js:noInline')
  static ProblemAndFixes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProblemAndFixes>(create);
  static ProblemAndFixes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CandidateFix> get fixes => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get problemMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set problemMessage($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProblemMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearProblemMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get length => $_getIZ(3);
  @$pb.TagNumber(4)
  set length($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasLength() => $_has(3);
  @$pb.TagNumber(4)
  void clearLength() => clearField(4);
}

class CandidateFix extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CandidateFix',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..pc<SourceEdit>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'edits',
        $pb.PbFieldType.PM,
        subBuilder: SourceEdit.create)
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'selectionOffset',
        $pb.PbFieldType.O3,
        protoName: 'selectionOffset')
    ..pc<LinkedEditGroup>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'linkedEditGroups',
        $pb.PbFieldType.PM,
        protoName: 'linkedEditGroups',
        subBuilder: LinkedEditGroup.create)
    ..hasRequiredFields = false;

  CandidateFix._() : super();
  factory CandidateFix({
    $core.String? message,
    $core.Iterable<SourceEdit>? edits,
    $core.int? selectionOffset,
    $core.Iterable<LinkedEditGroup>? linkedEditGroups,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    if (edits != null) {
      _result.edits.addAll(edits);
    }
    if (selectionOffset != null) {
      _result.selectionOffset = selectionOffset;
    }
    if (linkedEditGroups != null) {
      _result.linkedEditGroups.addAll(linkedEditGroups);
    }
    return _result;
  }
  factory CandidateFix.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CandidateFix.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CandidateFix clone() => CandidateFix()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CandidateFix copyWith(void Function(CandidateFix) updates) =>
      super.copyWith((message) => updates(message as CandidateFix))
          as CandidateFix; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CandidateFix create() => CandidateFix._();
  CandidateFix createEmptyInstance() => create();
  static $pb.PbList<CandidateFix> createRepeated() =>
      $pb.PbList<CandidateFix>();
  @$core.pragma('dart2js:noInline')
  static CandidateFix getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CandidateFix>(create);
  static CandidateFix? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<SourceEdit> get edits => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get selectionOffset => $_getIZ(2);
  @$pb.TagNumber(3)
  set selectionOffset($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSelectionOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearSelectionOffset() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<LinkedEditGroup> get linkedEditGroups => $_getList(3);
}

class SourceEdit extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SourceEdit',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'offset',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'length',
        $pb.PbFieldType.O3)
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'replacement')
    ..hasRequiredFields = false;

  SourceEdit._() : super();
  factory SourceEdit({
    $core.int? offset,
    $core.int? length,
    $core.String? replacement,
  }) {
    final _result = create();
    if (offset != null) {
      _result.offset = offset;
    }
    if (length != null) {
      _result.length = length;
    }
    if (replacement != null) {
      _result.replacement = replacement;
    }
    return _result;
  }
  factory SourceEdit.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourceEdit.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourceEdit clone() => SourceEdit()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourceEdit copyWith(void Function(SourceEdit) updates) =>
      super.copyWith((message) => updates(message as SourceEdit))
          as SourceEdit; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SourceEdit create() => SourceEdit._();
  SourceEdit createEmptyInstance() => create();
  static $pb.PbList<SourceEdit> createRepeated() => $pb.PbList<SourceEdit>();
  @$core.pragma('dart2js:noInline')
  static SourceEdit getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceEdit>(create);
  static SourceEdit? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get offset => $_getIZ(0);
  @$pb.TagNumber(1)
  set offset($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasOffset() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffset() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get length => $_getIZ(1);
  @$pb.TagNumber(2)
  set length($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLength() => $_has(1);
  @$pb.TagNumber(2)
  void clearLength() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get replacement => $_getSZ(2);
  @$pb.TagNumber(3)
  set replacement($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasReplacement() => $_has(2);
  @$pb.TagNumber(3)
  void clearReplacement() => clearField(3);
}

class LinkedEditGroup extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'LinkedEditGroup',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..p<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'positions',
        $pb.PbFieldType.P3)
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'length',
        $pb.PbFieldType.O3)
    ..pc<LinkedEditSuggestion>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'suggestions',
        $pb.PbFieldType.PM,
        subBuilder: LinkedEditSuggestion.create)
    ..hasRequiredFields = false;

  LinkedEditGroup._() : super();
  factory LinkedEditGroup({
    $core.Iterable<$core.int>? positions,
    $core.int? length,
    $core.Iterable<LinkedEditSuggestion>? suggestions,
  }) {
    final _result = create();
    if (positions != null) {
      _result.positions.addAll(positions);
    }
    if (length != null) {
      _result.length = length;
    }
    if (suggestions != null) {
      _result.suggestions.addAll(suggestions);
    }
    return _result;
  }
  factory LinkedEditGroup.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LinkedEditGroup.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LinkedEditGroup clone() => LinkedEditGroup()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LinkedEditGroup copyWith(void Function(LinkedEditGroup) updates) =>
      super.copyWith((message) => updates(message as LinkedEditGroup))
          as LinkedEditGroup; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkedEditGroup create() => LinkedEditGroup._();
  LinkedEditGroup createEmptyInstance() => create();
  static $pb.PbList<LinkedEditGroup> createRepeated() =>
      $pb.PbList<LinkedEditGroup>();
  @$core.pragma('dart2js:noInline')
  static LinkedEditGroup getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LinkedEditGroup>(create);
  static LinkedEditGroup? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get positions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get length => $_getIZ(1);
  @$pb.TagNumber(2)
  set length($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLength() => $_has(1);
  @$pb.TagNumber(2)
  void clearLength() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<LinkedEditSuggestion> get suggestions => $_getList(2);
}

class LinkedEditSuggestion extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'LinkedEditSuggestion',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'value')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'kind')
    ..hasRequiredFields = false;

  LinkedEditSuggestion._() : super();
  factory LinkedEditSuggestion({
    $core.String? value,
    $core.String? kind,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (kind != null) {
      _result.kind = kind;
    }
    return _result;
  }
  factory LinkedEditSuggestion.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LinkedEditSuggestion.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LinkedEditSuggestion clone() =>
      LinkedEditSuggestion()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LinkedEditSuggestion copyWith(void Function(LinkedEditSuggestion) updates) =>
      super.copyWith((message) => updates(message as LinkedEditSuggestion))
          as LinkedEditSuggestion; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkedEditSuggestion create() => LinkedEditSuggestion._();
  LinkedEditSuggestion createEmptyInstance() => create();
  static $pb.PbList<LinkedEditSuggestion> createRepeated() =>
      $pb.PbList<LinkedEditSuggestion>();
  @$core.pragma('dart2js:noInline')
  static LinkedEditSuggestion getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LinkedEditSuggestion>(create);
  static LinkedEditSuggestion? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get kind => $_getSZ(1);
  @$pb.TagNumber(2)
  set kind($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => clearField(2);
}

class FormatResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'FormatResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'newString',
        protoName: 'newString')
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'offset',
        $pb.PbFieldType.O3)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  FormatResponse._() : super();
  factory FormatResponse({
    $core.String? newString,
    $core.int? offset,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (newString != null) {
      _result.newString = newString;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory FormatResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FormatResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FormatResponse clone() => FormatResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FormatResponse copyWith(void Function(FormatResponse) updates) =>
      super.copyWith((message) => updates(message as FormatResponse))
          as FormatResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FormatResponse create() => FormatResponse._();
  FormatResponse createEmptyInstance() => create();
  static $pb.PbList<FormatResponse> createRepeated() =>
      $pb.PbList<FormatResponse>();
  @$core.pragma('dart2js:noInline')
  static FormatResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FormatResponse>(create);
  static FormatResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get newString => $_getSZ(0);
  @$pb.TagNumber(1)
  set newString($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNewString() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewString() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(2);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(2);
}

class AssistsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'AssistsResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<CandidateFix>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'assists',
        $pb.PbFieldType.PM,
        subBuilder: CandidateFix.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  AssistsResponse._() : super();
  factory AssistsResponse({
    $core.Iterable<CandidateFix>? assists,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (assists != null) {
      _result.assists.addAll(assists);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory AssistsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AssistsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AssistsResponse clone() => AssistsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AssistsResponse copyWith(void Function(AssistsResponse) updates) =>
      super.copyWith((message) => updates(message as AssistsResponse))
          as AssistsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AssistsResponse create() => AssistsResponse._();
  AssistsResponse createEmptyInstance() => create();
  static $pb.PbList<AssistsResponse> createRepeated() =>
      $pb.PbList<AssistsResponse>();
  @$core.pragma('dart2js:noInline')
  static AssistsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AssistsResponse>(create);
  static AssistsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CandidateFix> get assists => $_getList(0);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class VersionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'VersionResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'sdkVersion',
        protoName: 'sdkVersion')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'sdkVersionFull',
        protoName: 'sdkVersionFull')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'runtimeVersion',
        protoName: 'runtimeVersion')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'appEngineVersion',
        protoName: 'appEngineVersion')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'servicesVersion',
        protoName: 'servicesVersion')
    ..aOS(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'flutterVersion',
        protoName: 'flutterVersion')
    ..aOS(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'flutterDartVersion',
        protoName: 'flutterDartVersion')
    ..aOS(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'flutterDartVersionFull',
        protoName: 'flutterDartVersionFull')
    ..m<$core.String, $core.String>(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'packageVersions',
        protoName: 'packageVersions',
        entryClassName: 'VersionResponse.PackageVersionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('dart_services.api'))
    ..pc<PackageInfo>(
        10,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'packageInfo',
        $pb.PbFieldType.PM,
        protoName: 'packageInfo',
        subBuilder: PackageInfo.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  VersionResponse._() : super();
  factory VersionResponse({
    $core.String? sdkVersion,
    $core.String? sdkVersionFull,
    $core.String? runtimeVersion,
    $core.String? appEngineVersion,
    $core.String? servicesVersion,
    $core.String? flutterVersion,
    $core.String? flutterDartVersion,
    $core.String? flutterDartVersionFull,
    $core.Map<$core.String, $core.String>? packageVersions,
    $core.Iterable<PackageInfo>? packageInfo,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (sdkVersion != null) {
      _result.sdkVersion = sdkVersion;
    }
    if (sdkVersionFull != null) {
      _result.sdkVersionFull = sdkVersionFull;
    }
    if (runtimeVersion != null) {
      _result.runtimeVersion = runtimeVersion;
    }
    if (appEngineVersion != null) {
      _result.appEngineVersion = appEngineVersion;
    }
    if (servicesVersion != null) {
      _result.servicesVersion = servicesVersion;
    }
    if (flutterVersion != null) {
      _result.flutterVersion = flutterVersion;
    }
    if (flutterDartVersion != null) {
      _result.flutterDartVersion = flutterDartVersion;
    }
    if (flutterDartVersionFull != null) {
      _result.flutterDartVersionFull = flutterDartVersionFull;
    }
    if (packageVersions != null) {
      _result.packageVersions.addAll(packageVersions);
    }
    if (packageInfo != null) {
      _result.packageInfo.addAll(packageInfo);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory VersionResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory VersionResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  VersionResponse clone() => VersionResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  VersionResponse copyWith(void Function(VersionResponse) updates) =>
      super.copyWith((message) => updates(message as VersionResponse))
          as VersionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VersionResponse create() => VersionResponse._();
  VersionResponse createEmptyInstance() => create();
  static $pb.PbList<VersionResponse> createRepeated() =>
      $pb.PbList<VersionResponse>();
  @$core.pragma('dart2js:noInline')
  static VersionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionResponse>(create);
  static VersionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sdkVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set sdkVersion($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSdkVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearSdkVersion() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sdkVersionFull => $_getSZ(1);
  @$pb.TagNumber(2)
  set sdkVersionFull($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSdkVersionFull() => $_has(1);
  @$pb.TagNumber(2)
  void clearSdkVersionFull() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get runtimeVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set runtimeVersion($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRuntimeVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearRuntimeVersion() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get appEngineVersion => $_getSZ(3);
  @$pb.TagNumber(4)
  set appEngineVersion($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasAppEngineVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearAppEngineVersion() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get servicesVersion => $_getSZ(4);
  @$pb.TagNumber(5)
  set servicesVersion($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasServicesVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearServicesVersion() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get flutterVersion => $_getSZ(5);
  @$pb.TagNumber(6)
  set flutterVersion($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasFlutterVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearFlutterVersion() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get flutterDartVersion => $_getSZ(6);
  @$pb.TagNumber(7)
  set flutterDartVersion($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasFlutterDartVersion() => $_has(6);
  @$pb.TagNumber(7)
  void clearFlutterDartVersion() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get flutterDartVersionFull => $_getSZ(7);
  @$pb.TagNumber(8)
  set flutterDartVersionFull($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasFlutterDartVersionFull() => $_has(7);
  @$pb.TagNumber(8)
  void clearFlutterDartVersionFull() => clearField(8);

  @$pb.TagNumber(9)
  $core.Map<$core.String, $core.String> get packageVersions => $_getMap(8);

  @$pb.TagNumber(10)
  $core.List<PackageInfo> get packageInfo => $_getList(9);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(10);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(10);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(10);
}

class PackageInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'PackageInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'version')
    ..aOB(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'supported')
    ..hasRequiredFields = false;

  PackageInfo._() : super();
  factory PackageInfo({
    $core.String? name,
    $core.String? version,
    $core.bool? supported,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (version != null) {
      _result.version = version;
    }
    if (supported != null) {
      _result.supported = supported;
    }
    return _result;
  }
  factory PackageInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PackageInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PackageInfo clone() => PackageInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PackageInfo copyWith(void Function(PackageInfo) updates) =>
      super.copyWith((message) => updates(message as PackageInfo))
          as PackageInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackageInfo create() => PackageInfo._();
  PackageInfo createEmptyInstance() => create();
  static $pb.PbList<PackageInfo> createRepeated() => $pb.PbList<PackageInfo>();
  @$core.pragma('dart2js:noInline')
  static PackageInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PackageInfo>(create);
  static PackageInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get supported => $_getBF(2);
  @$pb.TagNumber(3)
  set supported($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSupported() => $_has(2);
  @$pb.TagNumber(3)
  void clearSupported() => clearField(3);
}

class BadRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'BadRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  BadRequest._() : super();
  factory BadRequest({
    ErrorMessage? error,
  }) {
    final _result = create();
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory BadRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BadRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BadRequest clone() => BadRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BadRequest copyWith(void Function(BadRequest) updates) =>
      super.copyWith((message) => updates(message as BadRequest))
          as BadRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BadRequest create() => BadRequest._();
  BadRequest createEmptyInstance() => create();
  static $pb.PbList<BadRequest> createRepeated() => $pb.PbList<BadRequest>();
  @$core.pragma('dart2js:noInline')
  static BadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BadRequest>(create);
  static BadRequest? _defaultInstance;

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(0);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(0);
}

class ErrorMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ErrorMessage',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..hasRequiredFields = false;

  ErrorMessage._() : super();
  factory ErrorMessage({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ErrorMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ErrorMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ErrorMessage clone() => ErrorMessage()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ErrorMessage copyWith(void Function(ErrorMessage) updates) =>
      super.copyWith((message) => updates(message as ErrorMessage))
          as ErrorMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ErrorMessage create() => ErrorMessage._();
  ErrorMessage createEmptyInstance() => create();
  static $pb.PbList<ErrorMessage> createRepeated() =>
      $pb.PbList<ErrorMessage>();
  @$core.pragma('dart2js:noInline')
  static ErrorMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ErrorMessage>(create);
  static ErrorMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class FairCompileResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'FairCompileResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'json')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'js')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  FairCompileResponse._() : super();
  factory FairCompileResponse({
    $core.String? json,
    $core.String? js,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (json != null) {
      _result.json = json;
    }
    if (js != null) {
      _result.js = js;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory FairCompileResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FairCompileResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FairCompileResponse clone() => FairCompileResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FairCompileResponse copyWith(void Function(FairCompileResponse) updates) =>
      super.copyWith((message) => updates(message as FairCompileResponse))
          as FairCompileResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FairCompileResponse create() => FairCompileResponse._();
  FairCompileResponse createEmptyInstance() => create();
  static $pb.PbList<FairCompileResponse> createRepeated() =>
      $pb.PbList<FairCompileResponse>();
  @$core.pragma('dart2js:noInline')
  static FairCompileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FairCompileResponse>(create);
  static FairCompileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get json => $_getSZ(0);
  @$pb.TagNumber(1)
  set json($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearJson() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get js => $_getSZ(1);
  @$pb.TagNumber(2)
  set js($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasJs() => $_has(1);
  @$pb.TagNumber(2)
  void clearJs() => clearField(2);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(2);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(2);
}

class FairRunResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'FairRunResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  FairRunResponse._() : super();
  factory FairRunResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory FairRunResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FairRunResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FairRunResponse clone() => FairRunResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FairRunResponse copyWith(void Function(FairRunResponse) updates) =>
      super.copyWith((message) => updates(message as FairRunResponse))
          as FairRunResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FairRunResponse create() => FairRunResponse._();
  FairRunResponse createEmptyInstance() => create();
  static $pb.PbList<FairRunResponse> createRepeated() =>
      $pb.PbList<FairRunResponse>();
  @$core.pragma('dart2js:noInline')
  static FairRunResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FairRunResponse>(create);
  static FairRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class GetProjectRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetProjectRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..hasRequiredFields = false;

  GetProjectRequest._() : super();
  factory GetProjectRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetProjectRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetProjectRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetProjectRequest clone() => GetProjectRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetProjectRequest copyWith(void Function(GetProjectRequest) updates) =>
      super.copyWith((message) => updates(message as GetProjectRequest))
          as GetProjectRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetProjectRequest create() => GetProjectRequest._();
  GetProjectRequest createEmptyInstance() => create();
  static $pb.PbList<GetProjectRequest> createRepeated() =>
      $pb.PbList<GetProjectRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProjectRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProjectRequest>(create);
  static GetProjectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetProjectResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetProjectResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<ProjectInfo>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result',
        $pb.PbFieldType.PM,
        subBuilder: ProjectInfo.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetProjectResponse._() : super();
  factory GetProjectResponse({
    $core.Iterable<ProjectInfo>? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result.addAll(result);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetProjectResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetProjectResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetProjectResponse clone() => GetProjectResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetProjectResponse copyWith(void Function(GetProjectResponse) updates) =>
      super.copyWith((message) => updates(message as GetProjectResponse))
          as GetProjectResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetProjectResponse create() => GetProjectResponse._();
  GetProjectResponse createEmptyInstance() => create();
  static $pb.PbList<GetProjectResponse> createRepeated() =>
      $pb.PbList<GetProjectResponse>();
  @$core.pragma('dart2js:noInline')
  static GetProjectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProjectResponse>(create);
  static GetProjectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProjectInfo> get result => $_getList(0);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class ProjectInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ProjectInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'modifiedTime',
        protoName: 'modifiedTime')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'desc')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'screenshot')
    ..hasRequiredFields = false;

  ProjectInfo._() : super();
  factory ProjectInfo({
    $core.String? name,
    $core.String? modifiedTime,
    $core.String? desc,
    $core.String? screenshot,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (modifiedTime != null) {
      _result.modifiedTime = modifiedTime;
    }
    if (desc != null) {
      _result.desc = desc;
    }
    if (screenshot != null) {
      _result.screenshot = screenshot;
    }
    return _result;
  }
  factory ProjectInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ProjectInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ProjectInfo clone() => ProjectInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ProjectInfo copyWith(void Function(ProjectInfo) updates) =>
      super.copyWith((message) => updates(message as ProjectInfo))
          as ProjectInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProjectInfo create() => ProjectInfo._();
  ProjectInfo createEmptyInstance() => create();
  static $pb.PbList<ProjectInfo> createRepeated() => $pb.PbList<ProjectInfo>();
  @$core.pragma('dart2js:noInline')
  static ProjectInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProjectInfo>(create);
  static ProjectInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get modifiedTime => $_getSZ(1);
  @$pb.TagNumber(2)
  set modifiedTime($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasModifiedTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearModifiedTime() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get desc => $_getSZ(2);
  @$pb.TagNumber(3)
  set desc($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDesc() => $_has(2);
  @$pb.TagNumber(3)
  void clearDesc() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get screenshot => $_getSZ(3);
  @$pb.TagNumber(4)
  set screenshot($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasScreenshot() => $_has(3);
  @$pb.TagNumber(4)
  void clearScreenshot() => clearField(4);
}

class CreateProjectRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateProjectRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'templateProject',
        protoName: 'templateProject')
    ..hasRequiredFields = false;

  CreateProjectRequest._() : super();
  factory CreateProjectRequest({
    $core.String? userId,
    $core.String? projectName,
    $core.String? templateProject,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (projectName != null) {
      _result.projectName = projectName;
    }
    if (templateProject != null) {
      _result.templateProject = templateProject;
    }
    return _result;
  }
  factory CreateProjectRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateProjectRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateProjectRequest clone() =>
      CreateProjectRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateProjectRequest copyWith(void Function(CreateProjectRequest) updates) =>
      super.copyWith((message) => updates(message as CreateProjectRequest))
          as CreateProjectRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateProjectRequest create() => CreateProjectRequest._();
  CreateProjectRequest createEmptyInstance() => create();
  static $pb.PbList<CreateProjectRequest> createRepeated() =>
      $pb.PbList<CreateProjectRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateProjectRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateProjectRequest>(create);
  static CreateProjectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get projectName => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProjectName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get templateProject => $_getSZ(2);
  @$pb.TagNumber(3)
  set templateProject($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTemplateProject() => $_has(2);
  @$pb.TagNumber(3)
  void clearTemplateProject() => clearField(3);
}

class CreateProjectResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateProjectResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  CreateProjectResponse._() : super();
  factory CreateProjectResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CreateProjectResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateProjectResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateProjectResponse clone() =>
      CreateProjectResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateProjectResponse copyWith(
          void Function(CreateProjectResponse) updates) =>
      super.copyWith((message) => updates(message as CreateProjectResponse))
          as CreateProjectResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateProjectResponse create() => CreateProjectResponse._();
  CreateProjectResponse createEmptyInstance() => create();
  static $pb.PbList<CreateProjectResponse> createRepeated() =>
      $pb.PbList<CreateProjectResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateProjectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateProjectResponse>(create);
  static CreateProjectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class DeleteProjectRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DeleteProjectRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..hasRequiredFields = false;

  DeleteProjectRequest._() : super();
  factory DeleteProjectRequest({
    $core.String? userId,
    $core.String? projectName,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (projectName != null) {
      _result.projectName = projectName;
    }
    return _result;
  }
  factory DeleteProjectRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteProjectRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteProjectRequest clone() =>
      DeleteProjectRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteProjectRequest copyWith(void Function(DeleteProjectRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteProjectRequest))
          as DeleteProjectRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteProjectRequest create() => DeleteProjectRequest._();
  DeleteProjectRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteProjectRequest> createRepeated() =>
      $pb.PbList<DeleteProjectRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteProjectRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteProjectRequest>(create);
  static DeleteProjectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get projectName => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProjectName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectName() => clearField(2);
}

class DeleteProjectResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DeleteProjectResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  DeleteProjectResponse._() : super();
  factory DeleteProjectResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory DeleteProjectResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteProjectResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteProjectResponse clone() =>
      DeleteProjectResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteProjectResponse copyWith(
          void Function(DeleteProjectResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteProjectResponse))
          as DeleteProjectResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteProjectResponse create() => DeleteProjectResponse._();
  DeleteProjectResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteProjectResponse> createRepeated() =>
      $pb.PbList<DeleteProjectResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteProjectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteProjectResponse>(create);
  static DeleteProjectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CopyPageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CopyPageRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'dir')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'path')
    ..hasRequiredFields = false;

  CopyPageRequest._() : super();
  factory CopyPageRequest({
    $core.String? dir,
    $core.String? path,
  }) {
    final _result = create();
    if (dir != null) {
      _result.dir = dir;
    }
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory CopyPageRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CopyPageRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CopyPageRequest clone() => CopyPageRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CopyPageRequest copyWith(void Function(CopyPageRequest) updates) =>
      super.copyWith((message) => updates(message as CopyPageRequest))
          as CopyPageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CopyPageRequest create() => CopyPageRequest._();
  CopyPageRequest createEmptyInstance() => create();
  static $pb.PbList<CopyPageRequest> createRepeated() =>
      $pb.PbList<CopyPageRequest>();
  @$core.pragma('dart2js:noInline')
  static CopyPageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CopyPageRequest>(create);
  static CopyPageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dir => $_getSZ(0);
  @$pb.TagNumber(1)
  set dir($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDir() => $_has(0);
  @$pb.TagNumber(1)
  void clearDir() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);
}

class CommonResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CommonResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  CommonResponse._() : super();
  factory CommonResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CommonResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CommonResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CommonResponse clone() => CommonResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CommonResponse copyWith(void Function(CommonResponse) updates) =>
      super.copyWith((message) => updates(message as CommonResponse))
          as CommonResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CommonResponse create() => CommonResponse._();
  CommonResponse createEmptyInstance() => create();
  static $pb.PbList<CommonResponse> createRepeated() =>
      $pb.PbList<CommonResponse>();
  @$core.pragma('dart2js:noInline')
  static CommonResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommonResponse>(create);
  static CommonResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class GetProjectPagesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetProjectPagesRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..hasRequiredFields = false;

  GetProjectPagesRequest._() : super();
  factory GetProjectPagesRequest({
    $core.String? userId,
    $core.String? projectName,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (projectName != null) {
      _result.projectName = projectName;
    }
    return _result;
  }
  factory GetProjectPagesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetProjectPagesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetProjectPagesRequest clone() =>
      GetProjectPagesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetProjectPagesRequest copyWith(
          void Function(GetProjectPagesRequest) updates) =>
      super.copyWith((message) => updates(message as GetProjectPagesRequest))
          as GetProjectPagesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetProjectPagesRequest create() => GetProjectPagesRequest._();
  GetProjectPagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetProjectPagesRequest> createRepeated() =>
      $pb.PbList<GetProjectPagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProjectPagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProjectPagesRequest>(create);
  static GetProjectPagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get projectName => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProjectName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectName() => clearField(2);
}

class GetProjectPagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetProjectPagesResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<ProjectPageInfo>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result',
        $pb.PbFieldType.PM,
        subBuilder: ProjectPageInfo.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetProjectPagesResponse._() : super();
  factory GetProjectPagesResponse({
    $core.Iterable<ProjectPageInfo>? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result.addAll(result);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetProjectPagesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetProjectPagesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetProjectPagesResponse clone() =>
      GetProjectPagesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetProjectPagesResponse copyWith(
          void Function(GetProjectPagesResponse) updates) =>
      super.copyWith((message) => updates(message as GetProjectPagesResponse))
          as GetProjectPagesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetProjectPagesResponse create() => GetProjectPagesResponse._();
  GetProjectPagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetProjectPagesResponse> createRepeated() =>
      $pb.PbList<GetProjectPagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetProjectPagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProjectPagesResponse>(create);
  static GetProjectPagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProjectPageInfo> get result => $_getList(0);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class GetTemplatePagesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetTemplatePagesRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..hasRequiredFields = false;

  GetTemplatePagesRequest._() : super();
  factory GetTemplatePagesRequest({
    $core.String? userId,
    $core.String? projectName,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (projectName != null) {
      _result.projectName = projectName;
    }
    return _result;
  }
  factory GetTemplatePagesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetTemplatePagesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetTemplatePagesRequest clone() =>
      GetTemplatePagesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetTemplatePagesRequest copyWith(
          void Function(GetTemplatePagesRequest) updates) =>
      super.copyWith((message) => updates(message as GetTemplatePagesRequest))
          as GetTemplatePagesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTemplatePagesRequest create() => GetTemplatePagesRequest._();
  GetTemplatePagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetTemplatePagesRequest> createRepeated() =>
      $pb.PbList<GetTemplatePagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTemplatePagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTemplatePagesRequest>(create);
  static GetTemplatePagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get projectName => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProjectName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectName() => clearField(2);
}

class GetTemplatePagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetTemplatePagesResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<TemplatePageInfo>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result',
        $pb.PbFieldType.PM,
        subBuilder: TemplatePageInfo.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetTemplatePagesResponse._() : super();
  factory GetTemplatePagesResponse({
    $core.Iterable<TemplatePageInfo>? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result.addAll(result);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetTemplatePagesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetTemplatePagesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetTemplatePagesResponse clone() =>
      GetTemplatePagesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetTemplatePagesResponse copyWith(
          void Function(GetTemplatePagesResponse) updates) =>
      super.copyWith((message) => updates(message as GetTemplatePagesResponse))
          as GetTemplatePagesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTemplatePagesResponse create() => GetTemplatePagesResponse._();
  GetTemplatePagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetTemplatePagesResponse> createRepeated() =>
      $pb.PbList<GetTemplatePagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTemplatePagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTemplatePagesResponse>(create);
  static GetTemplatePagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TemplatePageInfo> get result => $_getList(0);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class ProjectPageInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ProjectPageInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'dir')
    ..pc<FileInfo>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'files',
        $pb.PbFieldType.PM,
        subBuilder: FileInfo.create)
    ..hasRequiredFields = false;

  ProjectPageInfo._() : super();
  factory ProjectPageInfo({
    $core.String? dir,
    $core.Iterable<FileInfo>? files,
  }) {
    final _result = create();
    if (dir != null) {
      _result.dir = dir;
    }
    if (files != null) {
      _result.files.addAll(files);
    }
    return _result;
  }
  factory ProjectPageInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ProjectPageInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ProjectPageInfo clone() => ProjectPageInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ProjectPageInfo copyWith(void Function(ProjectPageInfo) updates) =>
      super.copyWith((message) => updates(message as ProjectPageInfo))
          as ProjectPageInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProjectPageInfo create() => ProjectPageInfo._();
  ProjectPageInfo createEmptyInstance() => create();
  static $pb.PbList<ProjectPageInfo> createRepeated() =>
      $pb.PbList<ProjectPageInfo>();
  @$core.pragma('dart2js:noInline')
  static ProjectPageInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProjectPageInfo>(create);
  static ProjectPageInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dir => $_getSZ(0);
  @$pb.TagNumber(1)
  set dir($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDir() => $_has(0);
  @$pb.TagNumber(1)
  void clearDir() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<FileInfo> get files => $_getList(1);
}

class FileInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'FileInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'path')
    ..hasRequiredFields = false;

  FileInfo._() : super();
  factory FileInfo({
    $core.String? name,
    $core.String? path,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory FileInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FileInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FileInfo clone() => FileInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FileInfo copyWith(void Function(FileInfo) updates) =>
      super.copyWith((message) => updates(message as FileInfo))
          as FileInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileInfo create() => FileInfo._();
  FileInfo createEmptyInstance() => create();
  static $pb.PbList<FileInfo> createRepeated() => $pb.PbList<FileInfo>();
  @$core.pragma('dart2js:noInline')
  static FileInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileInfo>(create);
  static FileInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);
}

class TemplatePageInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'TemplatePageInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageName',
        protoName: 'pageName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pagePath',
        protoName: 'pagePath')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'screenshot')
    ..hasRequiredFields = false;

  TemplatePageInfo._() : super();
  factory TemplatePageInfo({
    $core.String? pageName,
    $core.String? pagePath,
    $core.String? screenshot,
  }) {
    final _result = create();
    if (pageName != null) {
      _result.pageName = pageName;
    }
    if (pagePath != null) {
      _result.pagePath = pagePath;
    }
    if (screenshot != null) {
      _result.screenshot = screenshot;
    }
    return _result;
  }
  factory TemplatePageInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TemplatePageInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TemplatePageInfo clone() => TemplatePageInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TemplatePageInfo copyWith(void Function(TemplatePageInfo) updates) =>
      super.copyWith((message) => updates(message as TemplatePageInfo))
          as TemplatePageInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TemplatePageInfo create() => TemplatePageInfo._();
  TemplatePageInfo createEmptyInstance() => create();
  static $pb.PbList<TemplatePageInfo> createRepeated() =>
      $pb.PbList<TemplatePageInfo>();
  @$core.pragma('dart2js:noInline')
  static TemplatePageInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TemplatePageInfo>(create);
  static TemplatePageInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pageName => $_getSZ(0);
  @$pb.TagNumber(1)
  set pageName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPageName() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pagePath => $_getSZ(1);
  @$pb.TagNumber(2)
  set pagePath($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPagePath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagePath() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get screenshot => $_getSZ(2);
  @$pb.TagNumber(3)
  set screenshot($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasScreenshot() => $_has(2);
  @$pb.TagNumber(3)
  void clearScreenshot() => clearField(3);
}

class DeleteProjectPageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DeleteProjectPageRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageName',
        protoName: 'pageName')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..hasRequiredFields = false;

  DeleteProjectPageRequest._() : super();
  factory DeleteProjectPageRequest({
    $core.String? projectName,
    $core.String? pageName,
    $core.String? userId,
  }) {
    final _result = create();
    if (projectName != null) {
      _result.projectName = projectName;
    }
    if (pageName != null) {
      _result.pageName = pageName;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory DeleteProjectPageRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteProjectPageRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteProjectPageRequest clone() =>
      DeleteProjectPageRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteProjectPageRequest copyWith(
          void Function(DeleteProjectPageRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteProjectPageRequest))
          as DeleteProjectPageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteProjectPageRequest create() => DeleteProjectPageRequest._();
  DeleteProjectPageRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteProjectPageRequest> createRepeated() =>
      $pb.PbList<DeleteProjectPageRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteProjectPageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteProjectPageRequest>(create);
  static DeleteProjectPageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get projectName => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageName => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageName() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);
}

class DeleteProjectPageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DeleteProjectPageResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  DeleteProjectPageResponse._() : super();
  factory DeleteProjectPageResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory DeleteProjectPageResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteProjectPageResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteProjectPageResponse clone() =>
      DeleteProjectPageResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteProjectPageResponse copyWith(
          void Function(DeleteProjectPageResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteProjectPageResponse))
          as DeleteProjectPageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteProjectPageResponse create() => DeleteProjectPageResponse._();
  DeleteProjectPageResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteProjectPageResponse> createRepeated() =>
      $pb.PbList<DeleteProjectPageResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteProjectPageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteProjectPageResponse>(create);
  static DeleteProjectPageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CreateProjectPageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateProjectPageRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pagePath',
        protoName: 'pagePath')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageName',
        protoName: 'pageName')
    ..hasRequiredFields = false;

  CreateProjectPageRequest._() : super();
  factory CreateProjectPageRequest({
    $core.String? pagePath,
    $core.String? pageName,
  }) {
    final _result = create();
    if (pagePath != null) {
      _result.pagePath = pagePath;
    }
    if (pageName != null) {
      _result.pageName = pageName;
    }
    return _result;
  }
  factory CreateProjectPageRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateProjectPageRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateProjectPageRequest clone() =>
      CreateProjectPageRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateProjectPageRequest copyWith(
          void Function(CreateProjectPageRequest) updates) =>
      super.copyWith((message) => updates(message as CreateProjectPageRequest))
          as CreateProjectPageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateProjectPageRequest create() => CreateProjectPageRequest._();
  CreateProjectPageRequest createEmptyInstance() => create();
  static $pb.PbList<CreateProjectPageRequest> createRepeated() =>
      $pb.PbList<CreateProjectPageRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateProjectPageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateProjectPageRequest>(create);
  static CreateProjectPageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pagePath => $_getSZ(0);
  @$pb.TagNumber(1)
  set pagePath($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPagePath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPagePath() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageName => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageName() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageName() => clearField(2);
}

class CreateProjectPageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateProjectPageResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  CreateProjectPageResponse._() : super();
  factory CreateProjectPageResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CreateProjectPageResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateProjectPageResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateProjectPageResponse clone() =>
      CreateProjectPageResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateProjectPageResponse copyWith(
          void Function(CreateProjectPageResponse) updates) =>
      super.copyWith((message) => updates(message as CreateProjectPageResponse))
          as CreateProjectPageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateProjectPageResponse create() => CreateProjectPageResponse._();
  CreateProjectPageResponse createEmptyInstance() => create();
  static $pb.PbList<CreateProjectPageResponse> createRepeated() =>
      $pb.PbList<CreateProjectPageResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateProjectPageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateProjectPageResponse>(create);
  static CreateProjectPageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CreateTemplatePageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateTemplatePageResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  CreateTemplatePageResponse._() : super();
  factory CreateTemplatePageResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CreateTemplatePageResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateTemplatePageResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateTemplatePageResponse clone() =>
      CreateTemplatePageResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateTemplatePageResponse copyWith(
          void Function(CreateTemplatePageResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateTemplatePageResponse))
          as CreateTemplatePageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTemplatePageResponse create() => CreateTemplatePageResponse._();
  CreateTemplatePageResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTemplatePageResponse> createRepeated() =>
      $pb.PbList<CreateTemplatePageResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTemplatePageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTemplatePageResponse>(create);
  static CreateTemplatePageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CreateTemplatePageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateTemplatePageRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pagePath',
        protoName: 'pagePath')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageName',
        protoName: 'pageName')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'templatePage',
        protoName: 'templatePage')
    ..hasRequiredFields = false;

  CreateTemplatePageRequest._() : super();
  factory CreateTemplatePageRequest({
    $core.String? pagePath,
    $core.String? pageName,
    $core.String? templatePage,
  }) {
    final _result = create();
    if (pagePath != null) {
      _result.pagePath = pagePath;
    }
    if (pageName != null) {
      _result.pageName = pageName;
    }
    if (templatePage != null) {
      _result.templatePage = templatePage;
    }
    return _result;
  }
  factory CreateTemplatePageRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateTemplatePageRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateTemplatePageRequest clone() =>
      CreateTemplatePageRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateTemplatePageRequest copyWith(
          void Function(CreateTemplatePageRequest) updates) =>
      super.copyWith((message) => updates(message as CreateTemplatePageRequest))
          as CreateTemplatePageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTemplatePageRequest create() => CreateTemplatePageRequest._();
  CreateTemplatePageRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTemplatePageRequest> createRepeated() =>
      $pb.PbList<CreateTemplatePageRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTemplatePageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTemplatePageRequest>(create);
  static CreateTemplatePageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pagePath => $_getSZ(0);
  @$pb.TagNumber(1)
  set pagePath($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPagePath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPagePath() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageName => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageName() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get templatePage => $_getSZ(2);
  @$pb.TagNumber(3)
  set templatePage($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTemplatePage() => $_has(2);
  @$pb.TagNumber(3)
  void clearTemplatePage() => clearField(3);
}

class GetPageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetPageRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pagePath',
        protoName: 'pagePath')
    ..hasRequiredFields = false;

  GetPageRequest._() : super();
  factory GetPageRequest({
    $core.String? pagePath,
  }) {
    final _result = create();
    if (pagePath != null) {
      _result.pagePath = pagePath;
    }
    return _result;
  }
  factory GetPageRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetPageRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetPageRequest clone() => GetPageRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetPageRequest copyWith(void Function(GetPageRequest) updates) =>
      super.copyWith((message) => updates(message as GetPageRequest))
          as GetPageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPageRequest create() => GetPageRequest._();
  GetPageRequest createEmptyInstance() => create();
  static $pb.PbList<GetPageRequest> createRepeated() =>
      $pb.PbList<GetPageRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPageRequest>(create);
  static GetPageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pagePath => $_getSZ(0);
  @$pb.TagNumber(1)
  set pagePath($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPagePath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPagePath() => clearField(1);
}

class GetPageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetPageResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetPageResponse._() : super();
  factory GetPageResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetPageResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetPageResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetPageResponse clone() => GetPageResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetPageResponse copyWith(void Function(GetPageResponse) updates) =>
      super.copyWith((message) => updates(message as GetPageResponse))
          as GetPageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPageResponse create() => GetPageResponse._();
  GetPageResponse createEmptyInstance() => create();
  static $pb.PbList<GetPageResponse> createRepeated() =>
      $pb.PbList<GetPageResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPageResponse>(create);
  static GetPageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CommonRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CommonRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  CommonRequest._() : super();
  factory CommonRequest() => create();
  factory CommonRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CommonRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CommonRequest clone() => CommonRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CommonRequest copyWith(void Function(CommonRequest) updates) =>
      super.copyWith((message) => updates(message as CommonRequest))
          as CommonRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CommonRequest create() => CommonRequest._();
  CommonRequest createEmptyInstance() => create();
  static $pb.PbList<CommonRequest> createRepeated() =>
      $pb.PbList<CommonRequest>();
  @$core.pragma('dart2js:noInline')
  static CommonRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommonRequest>(create);
  static CommonRequest? _defaultInstance;
}

class GetFairDslListResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetFairDslListResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<FairDslInfo>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result',
        $pb.PbFieldType.PM,
        subBuilder: FairDslInfo.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetFairDslListResponse._() : super();
  factory GetFairDslListResponse({
    $core.Iterable<FairDslInfo>? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result.addAll(result);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetFairDslListResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetFairDslListResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetFairDslListResponse clone() =>
      GetFairDslListResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetFairDslListResponse copyWith(
          void Function(GetFairDslListResponse) updates) =>
      super.copyWith((message) => updates(message as GetFairDslListResponse))
          as GetFairDslListResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFairDslListResponse create() => GetFairDslListResponse._();
  GetFairDslListResponse createEmptyInstance() => create();
  static $pb.PbList<GetFairDslListResponse> createRepeated() =>
      $pb.PbList<GetFairDslListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFairDslListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFairDslListResponse>(create);
  static GetFairDslListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FairDslInfo> get result => $_getList(0);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class FairDslInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'FairDslInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'jsonPath',
        protoName: 'jsonPath')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'jsPath',
        protoName: 'jsPath')
    ..hasRequiredFields = false;

  FairDslInfo._() : super();
  factory FairDslInfo({
    $core.String? jsonPath,
    $core.String? jsPath,
  }) {
    final _result = create();
    if (jsonPath != null) {
      _result.jsonPath = jsonPath;
    }
    if (jsPath != null) {
      _result.jsPath = jsPath;
    }
    return _result;
  }
  factory FairDslInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FairDslInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FairDslInfo clone() => FairDslInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FairDslInfo copyWith(void Function(FairDslInfo) updates) =>
      super.copyWith((message) => updates(message as FairDslInfo))
          as FairDslInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FairDslInfo create() => FairDslInfo._();
  FairDslInfo createEmptyInstance() => create();
  static $pb.PbList<FairDslInfo> createRepeated() => $pb.PbList<FairDslInfo>();
  @$core.pragma('dart2js:noInline')
  static FairDslInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FairDslInfo>(create);
  static FairDslInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get jsonPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set jsonPath($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasJsonPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearJsonPath() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get jsPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set jsPath($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasJsPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearJsPath() => clearField(2);
}

class GetFairDslRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetFairDslRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageName',
        protoName: 'pageName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'jsonPath',
        protoName: 'jsonPath')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'jsPath',
        protoName: 'jsPath')
    ..hasRequiredFields = false;

  GetFairDslRequest._() : super();
  factory GetFairDslRequest({
    $core.String? pageName,
    $core.String? jsonPath,
    $core.String? jsPath,
  }) {
    final _result = create();
    if (pageName != null) {
      _result.pageName = pageName;
    }
    if (jsonPath != null) {
      _result.jsonPath = jsonPath;
    }
    if (jsPath != null) {
      _result.jsPath = jsPath;
    }
    return _result;
  }
  factory GetFairDslRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetFairDslRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetFairDslRequest clone() => GetFairDslRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetFairDslRequest copyWith(void Function(GetFairDslRequest) updates) =>
      super.copyWith((message) => updates(message as GetFairDslRequest))
          as GetFairDslRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFairDslRequest create() => GetFairDslRequest._();
  GetFairDslRequest createEmptyInstance() => create();
  static $pb.PbList<GetFairDslRequest> createRepeated() =>
      $pb.PbList<GetFairDslRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFairDslRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFairDslRequest>(create);
  static GetFairDslRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pageName => $_getSZ(0);
  @$pb.TagNumber(1)
  set pageName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPageName() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get jsonPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set jsonPath($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasJsonPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearJsonPath() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get jsPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set jsPath($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasJsPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearJsPath() => clearField(3);
}

class GetFairDslResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetFairDslResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'json')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'js')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetFairDslResponse._() : super();
  factory GetFairDslResponse({
    $core.String? json,
    $core.String? js,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (json != null) {
      _result.json = json;
    }
    if (js != null) {
      _result.js = js;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetFairDslResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetFairDslResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetFairDslResponse clone() => GetFairDslResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetFairDslResponse copyWith(void Function(GetFairDslResponse) updates) =>
      super.copyWith((message) => updates(message as GetFairDslResponse))
          as GetFairDslResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFairDslResponse create() => GetFairDslResponse._();
  GetFairDslResponse createEmptyInstance() => create();
  static $pb.PbList<GetFairDslResponse> createRepeated() =>
      $pb.PbList<GetFairDslResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFairDslResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFairDslResponse>(create);
  static GetFairDslResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get json => $_getSZ(0);
  @$pb.TagNumber(1)
  set json($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearJson() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get js => $_getSZ(1);
  @$pb.TagNumber(2)
  set js($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasJs() => $_has(1);
  @$pb.TagNumber(2)
  void clearJs() => clearField(2);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(2);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(2);
}

class ApiCallInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ApiCallInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'method')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'url')
    ..pc<ApiCallParamsInfo>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'params',
        $pb.PbFieldType.PM,
        subBuilder: ApiCallParamsInfo.create)
    ..hasRequiredFields = false;

  ApiCallInfo._() : super();
  factory ApiCallInfo({
    $core.String? name,
    $core.String? method,
    $core.String? url,
    $core.Iterable<ApiCallParamsInfo>? params,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (method != null) {
      _result.method = method;
    }
    if (url != null) {
      _result.url = url;
    }
    if (params != null) {
      _result.params.addAll(params);
    }
    return _result;
  }
  factory ApiCallInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ApiCallInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ApiCallInfo clone() => ApiCallInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ApiCallInfo copyWith(void Function(ApiCallInfo) updates) =>
      super.copyWith((message) => updates(message as ApiCallInfo))
          as ApiCallInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ApiCallInfo create() => ApiCallInfo._();
  ApiCallInfo createEmptyInstance() => create();
  static $pb.PbList<ApiCallInfo> createRepeated() => $pb.PbList<ApiCallInfo>();
  @$core.pragma('dart2js:noInline')
  static ApiCallInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApiCallInfo>(create);
  static ApiCallInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get method => $_getSZ(1);
  @$pb.TagNumber(2)
  set method($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethod() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<ApiCallParamsInfo> get params => $_getList(3);
}

class ApiCallParamsInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ApiCallParamsInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'key')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'type')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'value')
    ..hasRequiredFields = false;

  ApiCallParamsInfo._() : super();
  factory ApiCallParamsInfo({
    $core.String? key,
    $core.String? type,
    $core.String? value,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (type != null) {
      _result.type = type;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory ApiCallParamsInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ApiCallParamsInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ApiCallParamsInfo clone() => ApiCallParamsInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ApiCallParamsInfo copyWith(void Function(ApiCallParamsInfo) updates) =>
      super.copyWith((message) => updates(message as ApiCallParamsInfo))
          as ApiCallParamsInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ApiCallParamsInfo create() => ApiCallParamsInfo._();
  ApiCallParamsInfo createEmptyInstance() => create();
  static $pb.PbList<ApiCallParamsInfo> createRepeated() =>
      $pb.PbList<ApiCallParamsInfo>();
  @$core.pragma('dart2js:noInline')
  static ApiCallParamsInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApiCallParamsInfo>(create);
  static ApiCallParamsInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get value => $_getSZ(2);
  @$pb.TagNumber(3)
  set value($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => clearField(3);
}

class GetApiCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetApiCallResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<ApiCallInfo>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'api',
        $pb.PbFieldType.PM,
        subBuilder: ApiCallInfo.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetApiCallResponse._() : super();
  factory GetApiCallResponse({
    $core.Iterable<ApiCallInfo>? api,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (api != null) {
      _result.api.addAll(api);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetApiCallResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetApiCallResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetApiCallResponse clone() => GetApiCallResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetApiCallResponse copyWith(void Function(GetApiCallResponse) updates) =>
      super.copyWith((message) => updates(message as GetApiCallResponse))
          as GetApiCallResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetApiCallResponse create() => GetApiCallResponse._();
  GetApiCallResponse createEmptyInstance() => create();
  static $pb.PbList<GetApiCallResponse> createRepeated() =>
      $pb.PbList<GetApiCallResponse>();
  @$core.pragma('dart2js:noInline')
  static GetApiCallResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetApiCallResponse>(create);
  static GetApiCallResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ApiCallInfo> get api => $_getList(0);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CommonApiCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CommonApiCallRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOM<ApiCallInfo>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'api',
        subBuilder: ApiCallInfo.create)
    ..hasRequiredFields = false;

  CommonApiCallRequest._() : super();
  factory CommonApiCallRequest({
    ApiCallInfo? api,
  }) {
    final _result = create();
    if (api != null) {
      _result.api = api;
    }
    return _result;
  }
  factory CommonApiCallRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CommonApiCallRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CommonApiCallRequest clone() =>
      CommonApiCallRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CommonApiCallRequest copyWith(void Function(CommonApiCallRequest) updates) =>
      super.copyWith((message) => updates(message as CommonApiCallRequest))
          as CommonApiCallRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CommonApiCallRequest create() => CommonApiCallRequest._();
  CommonApiCallRequest createEmptyInstance() => create();
  static $pb.PbList<CommonApiCallRequest> createRepeated() =>
      $pb.PbList<CommonApiCallRequest>();
  @$core.pragma('dart2js:noInline')
  static CommonApiCallRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommonApiCallRequest>(create);
  static CommonApiCallRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ApiCallInfo get api => $_getN(0);
  @$pb.TagNumber(1)
  set api(ApiCallInfo v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasApi() => $_has(0);
  @$pb.TagNumber(1)
  void clearApi() => clearField(1);
  @$pb.TagNumber(1)
  ApiCallInfo ensureApi() => $_ensure(0);
}

class CommonApiCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CommonApiCallResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  CommonApiCallResponse._() : super();
  factory CommonApiCallResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CommonApiCallResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CommonApiCallResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CommonApiCallResponse clone() =>
      CommonApiCallResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CommonApiCallResponse copyWith(
          void Function(CommonApiCallResponse) updates) =>
      super.copyWith((message) => updates(message as CommonApiCallResponse))
          as CommonApiCallResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CommonApiCallResponse create() => CommonApiCallResponse._();
  CommonApiCallResponse createEmptyInstance() => create();
  static $pb.PbList<CommonApiCallResponse> createRepeated() =>
      $pb.PbList<CommonApiCallResponse>();
  @$core.pragma('dart2js:noInline')
  static CommonApiCallResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommonApiCallResponse>(create);
  static CommonApiCallResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CustomComponentInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CustomComponentInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'desc')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'path')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'fairWidgetCode',
        protoName: 'fairWidgetCode')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'screenshot')
    ..hasRequiredFields = false;

  CustomComponentInfo._() : super();
  factory CustomComponentInfo({
    $core.String? name,
    $core.String? desc,
    $core.String? path,
    $core.String? fairWidgetCode,
    $core.String? screenshot,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (desc != null) {
      _result.desc = desc;
    }
    if (path != null) {
      _result.path = path;
    }
    if (fairWidgetCode != null) {
      _result.fairWidgetCode = fairWidgetCode;
    }
    if (screenshot != null) {
      _result.screenshot = screenshot;
    }
    return _result;
  }
  factory CustomComponentInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CustomComponentInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CustomComponentInfo clone() => CustomComponentInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CustomComponentInfo copyWith(void Function(CustomComponentInfo) updates) =>
      super.copyWith((message) => updates(message as CustomComponentInfo))
          as CustomComponentInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CustomComponentInfo create() => CustomComponentInfo._();
  CustomComponentInfo createEmptyInstance() => create();
  static $pb.PbList<CustomComponentInfo> createRepeated() =>
      $pb.PbList<CustomComponentInfo>();
  @$core.pragma('dart2js:noInline')
  static CustomComponentInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CustomComponentInfo>(create);
  static CustomComponentInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get desc => $_getSZ(1);
  @$pb.TagNumber(2)
  set desc($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDesc() => $_has(1);
  @$pb.TagNumber(2)
  void clearDesc() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get path => $_getSZ(2);
  @$pb.TagNumber(3)
  set path($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearPath() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fairWidgetCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set fairWidgetCode($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFairWidgetCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearFairWidgetCode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get screenshot => $_getSZ(4);
  @$pb.TagNumber(5)
  set screenshot($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasScreenshot() => $_has(4);
  @$pb.TagNumber(5)
  void clearScreenshot() => clearField(5);
}

class GetCustomComponentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetCustomComponentsRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..hasRequiredFields = false;

  GetCustomComponentsRequest._() : super();
  factory GetCustomComponentsRequest({
    $core.String? projectName,
    $core.String? userId,
  }) {
    final _result = create();
    if (projectName != null) {
      _result.projectName = projectName;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetCustomComponentsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetCustomComponentsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetCustomComponentsRequest clone() =>
      GetCustomComponentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetCustomComponentsRequest copyWith(
          void Function(GetCustomComponentsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCustomComponentsRequest))
          as GetCustomComponentsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomComponentsRequest create() => GetCustomComponentsRequest._();
  GetCustomComponentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomComponentsRequest> createRepeated() =>
      $pb.PbList<GetCustomComponentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomComponentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomComponentsRequest>(create);
  static GetCustomComponentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get projectName => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class GetCustomComponentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetCustomComponentsResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<CustomComponentInfo>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result',
        $pb.PbFieldType.PM,
        subBuilder: CustomComponentInfo.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetCustomComponentsResponse._() : super();
  factory GetCustomComponentsResponse({
    $core.Iterable<CustomComponentInfo>? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result.addAll(result);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetCustomComponentsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetCustomComponentsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetCustomComponentsResponse clone() =>
      GetCustomComponentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetCustomComponentsResponse copyWith(
          void Function(GetCustomComponentsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCustomComponentsResponse))
          as GetCustomComponentsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomComponentsResponse create() =>
      GetCustomComponentsResponse._();
  GetCustomComponentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomComponentsResponse> createRepeated() =>
      $pb.PbList<GetCustomComponentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomComponentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomComponentsResponse>(create);
  static GetCustomComponentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CustomComponentInfo> get result => $_getList(0);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CustomActionInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CustomActionInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'desc')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'path')
    ..hasRequiredFields = false;

  CustomActionInfo._() : super();
  factory CustomActionInfo({
    $core.String? name,
    $core.String? desc,
    $core.String? path,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (desc != null) {
      _result.desc = desc;
    }
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory CustomActionInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CustomActionInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CustomActionInfo clone() => CustomActionInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CustomActionInfo copyWith(void Function(CustomActionInfo) updates) =>
      super.copyWith((message) => updates(message as CustomActionInfo))
          as CustomActionInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CustomActionInfo create() => CustomActionInfo._();
  CustomActionInfo createEmptyInstance() => create();
  static $pb.PbList<CustomActionInfo> createRepeated() =>
      $pb.PbList<CustomActionInfo>();
  @$core.pragma('dart2js:noInline')
  static CustomActionInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CustomActionInfo>(create);
  static CustomActionInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get desc => $_getSZ(1);
  @$pb.TagNumber(2)
  set desc($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDesc() => $_has(1);
  @$pb.TagNumber(2)
  void clearDesc() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get path => $_getSZ(2);
  @$pb.TagNumber(3)
  set path($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearPath() => clearField(3);
}

class GetCustomActionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetCustomActionsRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..hasRequiredFields = false;

  GetCustomActionsRequest._() : super();
  factory GetCustomActionsRequest({
    $core.String? projectName,
    $core.String? userId,
  }) {
    final _result = create();
    if (projectName != null) {
      _result.projectName = projectName;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetCustomActionsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetCustomActionsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetCustomActionsRequest clone() =>
      GetCustomActionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetCustomActionsRequest copyWith(
          void Function(GetCustomActionsRequest) updates) =>
      super.copyWith((message) => updates(message as GetCustomActionsRequest))
          as GetCustomActionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomActionsRequest create() => GetCustomActionsRequest._();
  GetCustomActionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomActionsRequest> createRepeated() =>
      $pb.PbList<GetCustomActionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomActionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomActionsRequest>(create);
  static GetCustomActionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get projectName => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class GetCustomActionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetCustomActionsResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..pc<CustomActionInfo>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result',
        $pb.PbFieldType.PM,
        subBuilder: CustomActionInfo.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetCustomActionsResponse._() : super();
  factory GetCustomActionsResponse({
    $core.Iterable<CustomActionInfo>? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result.addAll(result);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetCustomActionsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetCustomActionsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetCustomActionsResponse clone() =>
      GetCustomActionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetCustomActionsResponse copyWith(
          void Function(GetCustomActionsResponse) updates) =>
      super.copyWith((message) => updates(message as GetCustomActionsResponse))
          as GetCustomActionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomActionsResponse create() => GetCustomActionsResponse._();
  GetCustomActionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomActionsResponse> createRepeated() =>
      $pb.PbList<GetCustomActionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomActionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomActionsResponse>(create);
  static GetCustomActionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CustomActionInfo> get result => $_getList(0);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class DeleteCustomCodeItemRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DeleteCustomCodeItemRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'path')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'type')
    ..hasRequiredFields = false;

  DeleteCustomCodeItemRequest._() : super();
  factory DeleteCustomCodeItemRequest({
    $core.String? projectName,
    $core.String? userId,
    $core.String? name,
    $core.String? path,
    $core.String? type,
  }) {
    final _result = create();
    if (projectName != null) {
      _result.projectName = projectName;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (path != null) {
      _result.path = path;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory DeleteCustomCodeItemRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteCustomCodeItemRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteCustomCodeItemRequest clone() =>
      DeleteCustomCodeItemRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteCustomCodeItemRequest copyWith(
          void Function(DeleteCustomCodeItemRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteCustomCodeItemRequest))
          as DeleteCustomCodeItemRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteCustomCodeItemRequest create() =>
      DeleteCustomCodeItemRequest._();
  DeleteCustomCodeItemRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteCustomCodeItemRequest> createRepeated() =>
      $pb.PbList<DeleteCustomCodeItemRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteCustomCodeItemRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCustomCodeItemRequest>(create);
  static DeleteCustomCodeItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get projectName => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get path => $_getSZ(3);
  @$pb.TagNumber(4)
  set path($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPath() => $_has(3);
  @$pb.TagNumber(4)
  void clearPath() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get type => $_getSZ(4);
  @$pb.TagNumber(5)
  set type($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => clearField(5);
}

class DeleteCustomCodeItemResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DeleteCustomCodeItemResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  DeleteCustomCodeItemResponse._() : super();
  factory DeleteCustomCodeItemResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory DeleteCustomCodeItemResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteCustomCodeItemResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteCustomCodeItemResponse clone() =>
      DeleteCustomCodeItemResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteCustomCodeItemResponse copyWith(
          void Function(DeleteCustomCodeItemResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteCustomCodeItemResponse))
          as DeleteCustomCodeItemResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteCustomCodeItemResponse create() =>
      DeleteCustomCodeItemResponse._();
  DeleteCustomCodeItemResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteCustomCodeItemResponse> createRepeated() =>
      $pb.PbList<DeleteCustomCodeItemResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteCustomCodeItemResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCustomCodeItemResponse>(create);
  static DeleteCustomCodeItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CreateCustomComponentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateCustomComponentRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'desc')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'content')
    ..p<$core.int>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'screenshots',
        $pb.PbFieldType.P3)
    ..aOS(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'editType',
        protoName: 'editType')
    ..hasRequiredFields = false;

  CreateCustomComponentRequest._() : super();
  factory CreateCustomComponentRequest({
    $core.String? projectName,
    $core.String? userId,
    $core.String? name,
    $core.String? desc,
    $core.String? content,
    $core.Iterable<$core.int>? screenshots,
    $core.String? editType,
  }) {
    final _result = create();
    if (projectName != null) {
      _result.projectName = projectName;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (desc != null) {
      _result.desc = desc;
    }
    if (content != null) {
      _result.content = content;
    }
    if (screenshots != null) {
      _result.screenshots.addAll(screenshots);
    }
    if (editType != null) {
      _result.editType = editType;
    }
    return _result;
  }
  factory CreateCustomComponentRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateCustomComponentRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateCustomComponentRequest clone() =>
      CreateCustomComponentRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateCustomComponentRequest copyWith(
          void Function(CreateCustomComponentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateCustomComponentRequest))
          as CreateCustomComponentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateCustomComponentRequest create() =>
      CreateCustomComponentRequest._();
  CreateCustomComponentRequest createEmptyInstance() => create();
  static $pb.PbList<CreateCustomComponentRequest> createRepeated() =>
      $pb.PbList<CreateCustomComponentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomComponentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCustomComponentRequest>(create);
  static CreateCustomComponentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get projectName => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get desc => $_getSZ(3);
  @$pb.TagNumber(4)
  set desc($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDesc() => $_has(3);
  @$pb.TagNumber(4)
  void clearDesc() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get content => $_getSZ(4);
  @$pb.TagNumber(5)
  set content($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasContent() => $_has(4);
  @$pb.TagNumber(5)
  void clearContent() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get screenshots => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get editType => $_getSZ(6);
  @$pb.TagNumber(7)
  set editType($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasEditType() => $_has(6);
  @$pb.TagNumber(7)
  void clearEditType() => clearField(7);
}

class CreateCustomComponentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateCustomComponentResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'status',
        $pb.PbFieldType.O3)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  CreateCustomComponentResponse._() : super();
  factory CreateCustomComponentResponse({
    $core.int? status,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CreateCustomComponentResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateCustomComponentResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateCustomComponentResponse clone() =>
      CreateCustomComponentResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateCustomComponentResponse copyWith(
          void Function(CreateCustomComponentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateCustomComponentResponse))
          as CreateCustomComponentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateCustomComponentResponse create() =>
      CreateCustomComponentResponse._();
  CreateCustomComponentResponse createEmptyInstance() => create();
  static $pb.PbList<CreateCustomComponentResponse> createRepeated() =>
      $pb.PbList<CreateCustomComponentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomComponentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCustomComponentResponse>(create);
  static CreateCustomComponentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get status => $_getIZ(0);
  @$pb.TagNumber(1)
  set status($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class CreateCustomActionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateCustomActionRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'desc')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'content')
    ..aOS(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'editType',
        protoName: 'editType')
    ..hasRequiredFields = false;

  CreateCustomActionRequest._() : super();
  factory CreateCustomActionRequest({
    $core.String? projectName,
    $core.String? userId,
    $core.String? name,
    $core.String? desc,
    $core.String? content,
    $core.String? editType,
  }) {
    final _result = create();
    if (projectName != null) {
      _result.projectName = projectName;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (desc != null) {
      _result.desc = desc;
    }
    if (content != null) {
      _result.content = content;
    }
    if (editType != null) {
      _result.editType = editType;
    }
    return _result;
  }
  factory CreateCustomActionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateCustomActionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateCustomActionRequest clone() =>
      CreateCustomActionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateCustomActionRequest copyWith(
          void Function(CreateCustomActionRequest) updates) =>
      super.copyWith((message) => updates(message as CreateCustomActionRequest))
          as CreateCustomActionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateCustomActionRequest create() => CreateCustomActionRequest._();
  CreateCustomActionRequest createEmptyInstance() => create();
  static $pb.PbList<CreateCustomActionRequest> createRepeated() =>
      $pb.PbList<CreateCustomActionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomActionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCustomActionRequest>(create);
  static CreateCustomActionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get projectName => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get desc => $_getSZ(3);
  @$pb.TagNumber(4)
  set desc($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDesc() => $_has(3);
  @$pb.TagNumber(4)
  void clearDesc() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get content => $_getSZ(4);
  @$pb.TagNumber(5)
  set content($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasContent() => $_has(4);
  @$pb.TagNumber(5)
  void clearContent() => clearField(5);

  @$pb.TagNumber(7)
  $core.String get editType => $_getSZ(5);
  @$pb.TagNumber(7)
  set editType($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasEditType() => $_has(5);
  @$pb.TagNumber(7)
  void clearEditType() => clearField(7);
}

class CreateCustomActionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateCustomActionResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'status',
        $pb.PbFieldType.O3)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  CreateCustomActionResponse._() : super();
  factory CreateCustomActionResponse({
    $core.int? status,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CreateCustomActionResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateCustomActionResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateCustomActionResponse clone() =>
      CreateCustomActionResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateCustomActionResponse copyWith(
          void Function(CreateCustomActionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateCustomActionResponse))
          as CreateCustomActionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateCustomActionResponse create() => CreateCustomActionResponse._();
  CreateCustomActionResponse createEmptyInstance() => create();
  static $pb.PbList<CreateCustomActionResponse> createRepeated() =>
      $pb.PbList<CreateCustomActionResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomActionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCustomActionResponse>(create);
  static CreateCustomActionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get status => $_getIZ(0);
  @$pb.TagNumber(1)
  set status($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class GetComponentListRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetComponentListRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectId',
        protoName: 'projectId')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'categoryType',
        protoName: 'categoryType')
    ..hasRequiredFields = false;

  GetComponentListRequest._() : super();
  factory GetComponentListRequest({
    $core.String? projectName,
    $core.String? projectId,
    $core.String? categoryType,
  }) {
    final _result = create();
    if (projectName != null) {
      _result.projectName = projectName;
    }
    if (projectId != null) {
      _result.projectId = projectId;
    }
    if (categoryType != null) {
      _result.categoryType = categoryType;
    }
    return _result;
  }
  factory GetComponentListRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetComponentListRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetComponentListRequest clone() =>
      GetComponentListRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetComponentListRequest copyWith(
          void Function(GetComponentListRequest) updates) =>
      super.copyWith((message) => updates(message as GetComponentListRequest))
          as GetComponentListRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetComponentListRequest create() => GetComponentListRequest._();
  GetComponentListRequest createEmptyInstance() => create();
  static $pb.PbList<GetComponentListRequest> createRepeated() =>
      $pb.PbList<GetComponentListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetComponentListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetComponentListRequest>(create);
  static GetComponentListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get projectName => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get projectId => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProjectId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get categoryType => $_getSZ(2);
  @$pb.TagNumber(3)
  set categoryType($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCategoryType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategoryType() => clearField(3);
}

class GetComponentListResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetComponentListResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectId',
        protoName: 'projectId')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'categoryType',
        protoName: 'categoryType')
    ..pc<ComponentItemInfo>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'componentItems',
        $pb.PbFieldType.PM,
        protoName: 'componentItems',
        subBuilder: ComponentItemInfo.create)
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetComponentListResponse._() : super();
  factory GetComponentListResponse({
    $core.String? projectName,
    $core.String? projectId,
    $core.String? categoryType,
    $core.Iterable<ComponentItemInfo>? componentItems,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (projectName != null) {
      _result.projectName = projectName;
    }
    if (projectId != null) {
      _result.projectId = projectId;
    }
    if (categoryType != null) {
      _result.categoryType = categoryType;
    }
    if (componentItems != null) {
      _result.componentItems.addAll(componentItems);
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetComponentListResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetComponentListResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetComponentListResponse clone() =>
      GetComponentListResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetComponentListResponse copyWith(
          void Function(GetComponentListResponse) updates) =>
      super.copyWith((message) => updates(message as GetComponentListResponse))
          as GetComponentListResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetComponentListResponse create() => GetComponentListResponse._();
  GetComponentListResponse createEmptyInstance() => create();
  static $pb.PbList<GetComponentListResponse> createRepeated() =>
      $pb.PbList<GetComponentListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetComponentListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetComponentListResponse>(create);
  static GetComponentListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get projectName => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProjectName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get projectId => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProjectId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get categoryType => $_getSZ(2);
  @$pb.TagNumber(3)
  set categoryType($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCategoryType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategoryType() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<ComponentItemInfo> get componentItems => $_getList(3);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(4);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(4);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(4);
}

class ComponentItemInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComponentItemInfo',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'componentName',
        protoName: 'componentName')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'componentId',
        protoName: 'componentId')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'categoryType',
        protoName: 'categoryType')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'type')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'content')
    ..pPS(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'dependencies')
    ..hasRequiredFields = false;

  ComponentItemInfo._() : super();
  factory ComponentItemInfo({
    $core.String? componentName,
    $core.String? componentId,
    $core.String? categoryType,
    $core.String? type,
    $core.String? content,
    $core.Iterable<$core.String>? dependencies,
  }) {
    final _result = create();
    if (componentName != null) {
      _result.componentName = componentName;
    }
    if (componentId != null) {
      _result.componentId = componentId;
    }
    if (categoryType != null) {
      _result.categoryType = categoryType;
    }
    if (type != null) {
      _result.type = type;
    }
    if (content != null) {
      _result.content = content;
    }
    if (dependencies != null) {
      _result.dependencies.addAll(dependencies);
    }
    return _result;
  }
  factory ComponentItemInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComponentItemInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComponentItemInfo clone() => ComponentItemInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComponentItemInfo copyWith(void Function(ComponentItemInfo) updates) =>
      super.copyWith((message) => updates(message as ComponentItemInfo))
          as ComponentItemInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComponentItemInfo create() => ComponentItemInfo._();
  ComponentItemInfo createEmptyInstance() => create();
  static $pb.PbList<ComponentItemInfo> createRepeated() =>
      $pb.PbList<ComponentItemInfo>();
  @$core.pragma('dart2js:noInline')
  static ComponentItemInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComponentItemInfo>(create);
  static ComponentItemInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get componentName => $_getSZ(0);
  @$pb.TagNumber(1)
  set componentName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasComponentName() => $_has(0);
  @$pb.TagNumber(1)
  void clearComponentName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get componentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set componentId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasComponentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearComponentId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get categoryType => $_getSZ(2);
  @$pb.TagNumber(3)
  set categoryType($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCategoryType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategoryType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get content => $_getSZ(4);
  @$pb.TagNumber(5)
  set content($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasContent() => $_has(4);
  @$pb.TagNumber(5)
  void clearContent() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get dependencies => $_getList(5);
}

class ExportProjectResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ExportProjectResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  ExportProjectResponse._() : super();
  factory ExportProjectResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory ExportProjectResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExportProjectResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExportProjectResponse clone() =>
      ExportProjectResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExportProjectResponse copyWith(
          void Function(ExportProjectResponse) updates) =>
      super.copyWith((message) => updates(message as ExportProjectResponse))
          as ExportProjectResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExportProjectResponse create() => ExportProjectResponse._();
  ExportProjectResponse createEmptyInstance() => create();
  static $pb.PbList<ExportProjectResponse> createRepeated() =>
      $pb.PbList<ExportProjectResponse>();
  @$core.pragma('dart2js:noInline')
  static ExportProjectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportProjectResponse>(create);
  static ExportProjectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class DependencyPathRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DependencyPathRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..hasRequiredFields = false;

  DependencyPathRequest._() : super();
  factory DependencyPathRequest({
    $core.String? userId,
    $core.String? projectName,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (projectName != null) {
      _result.projectName = projectName;
    }
    return _result;
  }
  factory DependencyPathRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DependencyPathRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DependencyPathRequest clone() =>
      DependencyPathRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DependencyPathRequest copyWith(
          void Function(DependencyPathRequest) updates) =>
      super.copyWith((message) => updates(message as DependencyPathRequest))
          as DependencyPathRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DependencyPathRequest create() => DependencyPathRequest._();
  DependencyPathRequest createEmptyInstance() => create();
  static $pb.PbList<DependencyPathRequest> createRepeated() =>
      $pb.PbList<DependencyPathRequest>();
  @$core.pragma('dart2js:noInline')
  static DependencyPathRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DependencyPathRequest>(create);
  static DependencyPathRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get projectName => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProjectName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectName() => clearField(2);
}

class DependencyPathResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DependencyPathResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'filePath',
        protoName: 'filePath')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  DependencyPathResponse._() : super();
  factory DependencyPathResponse({
    $core.String? filePath,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (filePath != null) {
      _result.filePath = filePath;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory DependencyPathResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DependencyPathResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DependencyPathResponse clone() =>
      DependencyPathResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DependencyPathResponse copyWith(
          void Function(DependencyPathResponse) updates) =>
      super.copyWith((message) => updates(message as DependencyPathResponse))
          as DependencyPathResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DependencyPathResponse create() => DependencyPathResponse._();
  DependencyPathResponse createEmptyInstance() => create();
  static $pb.PbList<DependencyPathResponse> createRepeated() =>
      $pb.PbList<DependencyPathResponse>();
  @$core.pragma('dart2js:noInline')
  static DependencyPathResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DependencyPathResponse>(create);
  static DependencyPathResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get filePath => $_getSZ(0);
  @$pb.TagNumber(1)
  set filePath($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFilePath() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilePath() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class ChangeDependencyRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ChangeDependencyRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'type')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'version')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..hasRequiredFields = false;

  ChangeDependencyRequest._() : super();
  factory ChangeDependencyRequest({
    $core.String? type,
    $core.String? name,
    $core.String? version,
    $core.String? userId,
    $core.String? projectName,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (name != null) {
      _result.name = name;
    }
    if (version != null) {
      _result.version = version;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (projectName != null) {
      _result.projectName = projectName;
    }
    return _result;
  }
  factory ChangeDependencyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ChangeDependencyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ChangeDependencyRequest clone() =>
      ChangeDependencyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ChangeDependencyRequest copyWith(
          void Function(ChangeDependencyRequest) updates) =>
      super.copyWith((message) => updates(message as ChangeDependencyRequest))
          as ChangeDependencyRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangeDependencyRequest create() => ChangeDependencyRequest._();
  ChangeDependencyRequest createEmptyInstance() => create();
  static $pb.PbList<ChangeDependencyRequest> createRepeated() =>
      $pb.PbList<ChangeDependencyRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangeDependencyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangeDependencyRequest>(create);
  static ChangeDependencyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get version => $_getSZ(2);
  @$pb.TagNumber(3)
  set version($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get projectName => $_getSZ(4);
  @$pb.TagNumber(5)
  set projectName($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasProjectName() => $_has(4);
  @$pb.TagNumber(5)
  void clearProjectName() => clearField(5);
}

class ChangeDependencyResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ChangeDependencyResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  ChangeDependencyResponse._() : super();
  factory ChangeDependencyResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory ChangeDependencyResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ChangeDependencyResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ChangeDependencyResponse clone() =>
      ChangeDependencyResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ChangeDependencyResponse copyWith(
          void Function(ChangeDependencyResponse) updates) =>
      super.copyWith((message) => updates(message as ChangeDependencyResponse))
          as ChangeDependencyResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangeDependencyResponse create() => ChangeDependencyResponse._();
  ChangeDependencyResponse createEmptyInstance() => create();
  static $pb.PbList<ChangeDependencyResponse> createRepeated() =>
      $pb.PbList<ChangeDependencyResponse>();
  @$core.pragma('dart2js:noInline')
  static ChangeDependencyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangeDependencyResponse>(create);
  static ChangeDependencyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class DoPubGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DoPubGetRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'projectName',
        protoName: 'projectName')
    ..hasRequiredFields = false;

  DoPubGetRequest._() : super();
  factory DoPubGetRequest({
    $core.String? userId,
    $core.String? projectName,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (projectName != null) {
      _result.projectName = projectName;
    }
    return _result;
  }
  factory DoPubGetRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DoPubGetRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DoPubGetRequest clone() => DoPubGetRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DoPubGetRequest copyWith(void Function(DoPubGetRequest) updates) =>
      super.copyWith((message) => updates(message as DoPubGetRequest))
          as DoPubGetRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DoPubGetRequest create() => DoPubGetRequest._();
  DoPubGetRequest createEmptyInstance() => create();
  static $pb.PbList<DoPubGetRequest> createRepeated() =>
      $pb.PbList<DoPubGetRequest>();
  @$core.pragma('dart2js:noInline')
  static DoPubGetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DoPubGetRequest>(create);
  static DoPubGetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get projectName => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProjectName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectName() => clearField(2);
}

class DoPubGetResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DoPubGetResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  DoPubGetResponse._() : super();
  factory DoPubGetResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory DoPubGetResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DoPubGetResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DoPubGetResponse clone() => DoPubGetResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DoPubGetResponse copyWith(void Function(DoPubGetResponse) updates) =>
      super.copyWith((message) => updates(message as DoPubGetResponse))
          as DoPubGetResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DoPubGetResponse create() => DoPubGetResponse._();
  DoPubGetResponse createEmptyInstance() => create();
  static $pb.PbList<DoPubGetResponse> createRepeated() =>
      $pb.PbList<DoPubGetResponse>();
  @$core.pragma('dart2js:noInline')
  static DoPubGetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DoPubGetResponse>(create);
  static DoPubGetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class UploadPluginRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UploadPluginRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'appId',
        protoName: 'appId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'bundleName',
        protoName: 'bundleName')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'patchUrl',
        protoName: 'patchUrl')
    ..hasRequiredFields = false;

  UploadPluginRequest._() : super();
  factory UploadPluginRequest({
    $core.String? appId,
    $core.String? bundleName,
    $core.String? patchUrl,
  }) {
    final _result = create();
    if (appId != null) {
      _result.appId = appId;
    }
    if (bundleName != null) {
      _result.bundleName = bundleName;
    }
    if (patchUrl != null) {
      _result.patchUrl = patchUrl;
    }
    return _result;
  }
  factory UploadPluginRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UploadPluginRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UploadPluginRequest clone() => UploadPluginRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UploadPluginRequest copyWith(void Function(UploadPluginRequest) updates) =>
      super.copyWith((message) => updates(message as UploadPluginRequest))
          as UploadPluginRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadPluginRequest create() => UploadPluginRequest._();
  UploadPluginRequest createEmptyInstance() => create();
  static $pb.PbList<UploadPluginRequest> createRepeated() =>
      $pb.PbList<UploadPluginRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadPluginRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadPluginRequest>(create);
  static UploadPluginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get appId => $_getSZ(0);
  @$pb.TagNumber(1)
  set appId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAppId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAppId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get bundleName => $_getSZ(1);
  @$pb.TagNumber(2)
  set bundleName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasBundleName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBundleName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get patchUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set patchUrl($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPatchUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearPatchUrl() => clearField(3);
}

class UploadPluginResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UploadPluginResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  UploadPluginResponse._() : super();
  factory UploadPluginResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory UploadPluginResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UploadPluginResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UploadPluginResponse clone() =>
      UploadPluginResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UploadPluginResponse copyWith(void Function(UploadPluginResponse) updates) =>
      super.copyWith((message) => updates(message as UploadPluginResponse))
          as UploadPluginResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadPluginResponse create() => UploadPluginResponse._();
  UploadPluginResponse createEmptyInstance() => create();
  static $pb.PbList<UploadPluginResponse> createRepeated() =>
      $pb.PbList<UploadPluginResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadPluginResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadPluginResponse>(create);
  static UploadPluginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}

class GetQrCodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetQrCodeResponse',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'dart_services.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'result')
    ..aOM<ErrorMessage>(
        99,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'error',
        subBuilder: ErrorMessage.create)
    ..hasRequiredFields = false;

  GetQrCodeResponse._() : super();
  factory GetQrCodeResponse({
    $core.String? result,
    ErrorMessage? error,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory GetQrCodeResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetQrCodeResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetQrCodeResponse clone() => GetQrCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetQrCodeResponse copyWith(void Function(GetQrCodeResponse) updates) =>
      super.copyWith((message) => updates(message as GetQrCodeResponse))
          as GetQrCodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetQrCodeResponse create() => GetQrCodeResponse._();
  GetQrCodeResponse createEmptyInstance() => create();
  static $pb.PbList<GetQrCodeResponse> createRepeated() =>
      $pb.PbList<GetQrCodeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetQrCodeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetQrCodeResponse>(create);
  static GetQrCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);

  @$pb.TagNumber(99)
  ErrorMessage get error => $_getN(1);
  @$pb.TagNumber(99)
  set error(ErrorMessage v) {
    setField(99, v);
  }

  @$pb.TagNumber(99)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(99)
  void clearError() => clearField(99);
  @$pb.TagNumber(99)
  ErrorMessage ensureError() => $_ensure(1);
}
