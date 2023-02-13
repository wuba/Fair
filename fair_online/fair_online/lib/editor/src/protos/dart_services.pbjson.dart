///
//  Generated code. Do not modify.
//  source: protos/dart_services.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use compileRequestDescriptor instead')
const CompileRequest$json = {
  '1': 'CompileRequest',
  '2': [
    {'1': 'source', '3': 1, '4': 1, '5': 9, '10': 'source'},
    {'1': 'returnSourceMap', '3': 2, '4': 1, '5': 8, '10': 'returnSourceMap'},
  ],
};

/// Descriptor for `CompileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List compileRequestDescriptor = $convert.base64Decode(
    'Cg5Db21waWxlUmVxdWVzdBIWCgZzb3VyY2UYASABKAlSBnNvdXJjZRIoCg9yZXR1cm5Tb3VyY2VNYXAYAiABKAhSD3JldHVyblNvdXJjZU1hcA==');
@$core.Deprecated('Use compileDDCRequestDescriptor instead')
const CompileDDCRequest$json = {
  '1': 'CompileDDCRequest',
  '2': [
    {'1': 'source', '3': 1, '4': 1, '5': 9, '10': 'source'},
    {'1': 'pageName', '3': 2, '4': 1, '5': 9, '10': 'pageName'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'runMode', '3': 4, '4': 1, '5': 9, '10': 'runMode'},
  ],
};

/// Descriptor for `CompileDDCRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List compileDDCRequestDescriptor = $convert.base64Decode(
    'ChFDb21waWxlRERDUmVxdWVzdBIWCgZzb3VyY2UYASABKAlSBnNvdXJjZRIaCghwYWdlTmFtZRgCIAEoCVIIcGFnZU5hbWUSEgoEdHlwZRgDIAEoCVIEdHlwZRIYCgdydW5Nb2RlGAQgASgJUgdydW5Nb2Rl');
@$core.Deprecated('Use sourceRequestDescriptor instead')
const SourceRequest$json = {
  '1': 'SourceRequest',
  '2': [
    {'1': 'source', '3': 1, '4': 1, '5': 9, '10': 'source'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'filePath', '3': 3, '4': 1, '5': 9, '10': 'filePath'},
    {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
  ],
};

/// Descriptor for `SourceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sourceRequestDescriptor = $convert.base64Decode(
    'Cg1Tb3VyY2VSZXF1ZXN0EhYKBnNvdXJjZRgBIAEoCVIGc291cmNlEhYKBm9mZnNldBgCIAEoBVIGb2Zmc2V0EhoKCGZpbGVQYXRoGAMgASgJUghmaWxlUGF0aBISCgR0eXBlGAQgASgJUgR0eXBl');
@$core.Deprecated('Use analysisResultsDescriptor instead')
const AnalysisResults$json = {
  '1': 'AnalysisResults',
  '2': [
    {
      '1': 'issues',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.AnalysisIssue',
      '10': 'issues'
    },
    {'1': 'packageImports', '3': 2, '4': 3, '5': 9, '10': 'packageImports'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `AnalysisResults`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List analysisResultsDescriptor = $convert.base64Decode(
    'Cg9BbmFseXNpc1Jlc3VsdHMSOAoGaXNzdWVzGAEgAygLMiAuZGFydF9zZXJ2aWNlcy5hcGkuQW5hbHlzaXNJc3N1ZVIGaXNzdWVzEiYKDnBhY2thZ2VJbXBvcnRzGAIgAygJUg5wYWNrYWdlSW1wb3J0cxI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use analysisIssueDescriptor instead')
const AnalysisIssue$json = {
  '1': 'AnalysisIssue',
  '2': [
    {'1': 'kind', '3': 1, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'line', '3': 2, '4': 1, '5': 5, '10': 'line'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'sourceName', '3': 4, '4': 1, '5': 9, '10': 'sourceName'},
    {'1': 'hasFixes', '3': 5, '4': 1, '5': 8, '10': 'hasFixes'},
    {'1': 'charStart', '3': 6, '4': 1, '5': 5, '10': 'charStart'},
    {'1': 'charLength', '3': 7, '4': 1, '5': 5, '10': 'charLength'},
    {'1': 'url', '3': 8, '4': 1, '5': 9, '10': 'url'},
    {
      '1': 'diagnosticMessages',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.DiagnosticMessage',
      '10': 'diagnosticMessages'
    },
    {'1': 'correction', '3': 10, '4': 1, '5': 9, '10': 'correction'},
  ],
};

/// Descriptor for `AnalysisIssue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List analysisIssueDescriptor = $convert.base64Decode(
    'Cg1BbmFseXNpc0lzc3VlEhIKBGtpbmQYASABKAlSBGtpbmQSEgoEbGluZRgCIAEoBVIEbGluZRIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEh4KCnNvdXJjZU5hbWUYBCABKAlSCnNvdXJjZU5hbWUSGgoIaGFzRml4ZXMYBSABKAhSCGhhc0ZpeGVzEhwKCWNoYXJTdGFydBgGIAEoBVIJY2hhclN0YXJ0Eh4KCmNoYXJMZW5ndGgYByABKAVSCmNoYXJMZW5ndGgSEAoDdXJsGAggASgJUgN1cmwSVAoSZGlhZ25vc3RpY01lc3NhZ2VzGAkgAygLMiQuZGFydF9zZXJ2aWNlcy5hcGkuRGlhZ25vc3RpY01lc3NhZ2VSEmRpYWdub3N0aWNNZXNzYWdlcxIeCgpjb3JyZWN0aW9uGAogASgJUgpjb3JyZWN0aW9u');
@$core.Deprecated('Use diagnosticMessageDescriptor instead')
const DiagnosticMessage$json = {
  '1': 'DiagnosticMessage',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'line', '3': 2, '4': 1, '5': 5, '10': 'line'},
    {'1': 'charStart', '3': 3, '4': 1, '5': 5, '10': 'charStart'},
    {'1': 'charLength', '3': 4, '4': 1, '5': 5, '10': 'charLength'},
  ],
};

/// Descriptor for `DiagnosticMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List diagnosticMessageDescriptor = $convert.base64Decode(
    'ChFEaWFnbm9zdGljTWVzc2FnZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEhIKBGxpbmUYAiABKAVSBGxpbmUSHAoJY2hhclN0YXJ0GAMgASgFUgljaGFyU3RhcnQSHgoKY2hhckxlbmd0aBgEIAEoBVIKY2hhckxlbmd0aA==');
@$core.Deprecated('Use versionRequestDescriptor instead')
const VersionRequest$json = {
  '1': 'VersionRequest',
};

/// Descriptor for `VersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionRequestDescriptor =
    $convert.base64Decode('Cg5WZXJzaW9uUmVxdWVzdA==');
@$core.Deprecated('Use compileResponseDescriptor instead')
const CompileResponse$json = {
  '1': 'CompileResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {'1': 'sourceMap', '3': 2, '4': 1, '5': 9, '10': 'sourceMap'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `CompileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List compileResponseDescriptor = $convert.base64Decode(
    'Cg9Db21waWxlUmVzcG9uc2USFgoGcmVzdWx0GAEgASgJUgZyZXN1bHQSHAoJc291cmNlTWFwGAIgASgJUglzb3VyY2VNYXASNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9y');
@$core.Deprecated('Use compileDDCResponseDescriptor instead')
const CompileDDCResponse$json = {
  '1': 'CompileDDCResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {'1': 'modulesBaseUrl', '3': 2, '4': 1, '5': 9, '10': 'modulesBaseUrl'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `CompileDDCResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List compileDDCResponseDescriptor = $convert.base64Decode(
    'ChJDb21waWxlRERDUmVzcG9uc2USFgoGcmVzdWx0GAEgASgJUgZyZXN1bHQSJgoObW9kdWxlc0Jhc2VVcmwYAiABKAlSDm1vZHVsZXNCYXNlVXJsEjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use documentResponseDescriptor instead')
const DocumentResponse$json = {
  '1': 'DocumentResponse',
  '2': [
    {
      '1': 'info',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.DocumentResponse.InfoEntry',
      '10': 'info'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
  '3': [DocumentResponse_InfoEntry$json],
};

@$core.Deprecated('Use documentResponseDescriptor instead')
const DocumentResponse_InfoEntry$json = {
  '1': 'InfoEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `DocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List documentResponseDescriptor = $convert.base64Decode(
    'ChBEb2N1bWVudFJlc3BvbnNlEkEKBGluZm8YASADKAsyLS5kYXJ0X3NlcnZpY2VzLmFwaS5Eb2N1bWVudFJlc3BvbnNlLkluZm9FbnRyeVIEaW5mbxI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3IaNwoJSW5mb0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use completeResponseDescriptor instead')
const CompleteResponse$json = {
  '1': 'CompleteResponse',
  '2': [
    {
      '1': 'replacementOffset',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'replacementOffset'
    },
    {
      '1': 'replacementLength',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'replacementLength'
    },
    {
      '1': 'completions',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.Completion',
      '10': 'completions'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `CompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeResponseDescriptor = $convert.base64Decode(
    'ChBDb21wbGV0ZVJlc3BvbnNlEiwKEXJlcGxhY2VtZW50T2Zmc2V0GAEgASgFUhFyZXBsYWNlbWVudE9mZnNldBIsChFyZXBsYWNlbWVudExlbmd0aBgCIAEoBVIRcmVwbGFjZW1lbnRMZW5ndGgSPwoLY29tcGxldGlvbnMYAyADKAsyHS5kYXJ0X3NlcnZpY2VzLmFwaS5Db21wbGV0aW9uUgtjb21wbGV0aW9ucxI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use completionDescriptor instead')
const Completion$json = {
  '1': 'Completion',
  '2': [
    {
      '1': 'completion',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.Completion.CompletionEntry',
      '10': 'completion'
    },
  ],
  '3': [Completion_CompletionEntry$json],
};

@$core.Deprecated('Use completionDescriptor instead')
const Completion_CompletionEntry$json = {
  '1': 'CompletionEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Completion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completionDescriptor = $convert.base64Decode(
    'CgpDb21wbGV0aW9uEk0KCmNvbXBsZXRpb24YASADKAsyLS5kYXJ0X3NlcnZpY2VzLmFwaS5Db21wbGV0aW9uLkNvbXBsZXRpb25FbnRyeVIKY29tcGxldGlvbho9Cg9Db21wbGV0aW9uRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use fixesResponseDescriptor instead')
const FixesResponse$json = {
  '1': 'FixesResponse',
  '2': [
    {
      '1': 'fixes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.ProblemAndFixes',
      '10': 'fixes'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `FixesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixesResponseDescriptor = $convert.base64Decode(
    'Cg1GaXhlc1Jlc3BvbnNlEjgKBWZpeGVzGAEgAygLMiIuZGFydF9zZXJ2aWNlcy5hcGkuUHJvYmxlbUFuZEZpeGVzUgVmaXhlcxI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use problemAndFixesDescriptor instead')
const ProblemAndFixes$json = {
  '1': 'ProblemAndFixes',
  '2': [
    {
      '1': 'fixes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.CandidateFix',
      '10': 'fixes'
    },
    {'1': 'problemMessage', '3': 2, '4': 1, '5': 9, '10': 'problemMessage'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'length', '3': 4, '4': 1, '5': 5, '10': 'length'},
  ],
};

/// Descriptor for `ProblemAndFixes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List problemAndFixesDescriptor = $convert.base64Decode(
    'Cg9Qcm9ibGVtQW5kRml4ZXMSNQoFZml4ZXMYASADKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5DYW5kaWRhdGVGaXhSBWZpeGVzEiYKDnByb2JsZW1NZXNzYWdlGAIgASgJUg5wcm9ibGVtTWVzc2FnZRIWCgZvZmZzZXQYAyABKAVSBm9mZnNldBIWCgZsZW5ndGgYBCABKAVSBmxlbmd0aA==');
@$core.Deprecated('Use candidateFixDescriptor instead')
const CandidateFix$json = {
  '1': 'CandidateFix',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'edits',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.SourceEdit',
      '10': 'edits'
    },
    {'1': 'selectionOffset', '3': 3, '4': 1, '5': 5, '10': 'selectionOffset'},
    {
      '1': 'linkedEditGroups',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.LinkedEditGroup',
      '10': 'linkedEditGroups'
    },
  ],
};

/// Descriptor for `CandidateFix`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List candidateFixDescriptor = $convert.base64Decode(
    'CgxDYW5kaWRhdGVGaXgSGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZRIzCgVlZGl0cxgCIAMoCzIdLmRhcnRfc2VydmljZXMuYXBpLlNvdXJjZUVkaXRSBWVkaXRzEigKD3NlbGVjdGlvbk9mZnNldBgDIAEoBVIPc2VsZWN0aW9uT2Zmc2V0Ek4KEGxpbmtlZEVkaXRHcm91cHMYBCADKAsyIi5kYXJ0X3NlcnZpY2VzLmFwaS5MaW5rZWRFZGl0R3JvdXBSEGxpbmtlZEVkaXRHcm91cHM=');
@$core.Deprecated('Use sourceEditDescriptor instead')
const SourceEdit$json = {
  '1': 'SourceEdit',
  '2': [
    {'1': 'offset', '3': 1, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'length', '3': 2, '4': 1, '5': 5, '10': 'length'},
    {'1': 'replacement', '3': 3, '4': 1, '5': 9, '10': 'replacement'},
  ],
};

/// Descriptor for `SourceEdit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sourceEditDescriptor = $convert.base64Decode(
    'CgpTb3VyY2VFZGl0EhYKBm9mZnNldBgBIAEoBVIGb2Zmc2V0EhYKBmxlbmd0aBgCIAEoBVIGbGVuZ3RoEiAKC3JlcGxhY2VtZW50GAMgASgJUgtyZXBsYWNlbWVudA==');
@$core.Deprecated('Use linkedEditGroupDescriptor instead')
const LinkedEditGroup$json = {
  '1': 'LinkedEditGroup',
  '2': [
    {'1': 'positions', '3': 1, '4': 3, '5': 5, '10': 'positions'},
    {'1': 'length', '3': 2, '4': 1, '5': 5, '10': 'length'},
    {
      '1': 'suggestions',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.LinkedEditSuggestion',
      '10': 'suggestions'
    },
  ],
};

/// Descriptor for `LinkedEditGroup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedEditGroupDescriptor = $convert.base64Decode(
    'Cg9MaW5rZWRFZGl0R3JvdXASHAoJcG9zaXRpb25zGAEgAygFUglwb3NpdGlvbnMSFgoGbGVuZ3RoGAIgASgFUgZsZW5ndGgSSQoLc3VnZ2VzdGlvbnMYAyADKAsyJy5kYXJ0X3NlcnZpY2VzLmFwaS5MaW5rZWRFZGl0U3VnZ2VzdGlvblILc3VnZ2VzdGlvbnM=');
@$core.Deprecated('Use linkedEditSuggestionDescriptor instead')
const LinkedEditSuggestion$json = {
  '1': 'LinkedEditSuggestion',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
  ],
};

/// Descriptor for `LinkedEditSuggestion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedEditSuggestionDescriptor = $convert.base64Decode(
    'ChRMaW5rZWRFZGl0U3VnZ2VzdGlvbhIUCgV2YWx1ZRgBIAEoCVIFdmFsdWUSEgoEa2luZBgCIAEoCVIEa2luZA==');
@$core.Deprecated('Use formatResponseDescriptor instead')
const FormatResponse$json = {
  '1': 'FormatResponse',
  '2': [
    {'1': 'newString', '3': 1, '4': 1, '5': 9, '10': 'newString'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `FormatResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List formatResponseDescriptor = $convert.base64Decode(
    'Cg5Gb3JtYXRSZXNwb25zZRIcCgluZXdTdHJpbmcYASABKAlSCW5ld1N0cmluZxIWCgZvZmZzZXQYAiABKAVSBm9mZnNldBI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use assistsResponseDescriptor instead')
const AssistsResponse$json = {
  '1': 'AssistsResponse',
  '2': [
    {
      '1': 'assists',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.CandidateFix',
      '10': 'assists'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `AssistsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assistsResponseDescriptor = $convert.base64Decode(
    'Cg9Bc3Npc3RzUmVzcG9uc2USOQoHYXNzaXN0cxgBIAMoCzIfLmRhcnRfc2VydmljZXMuYXBpLkNhbmRpZGF0ZUZpeFIHYXNzaXN0cxI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use versionResponseDescriptor instead')
const VersionResponse$json = {
  '1': 'VersionResponse',
  '2': [
    {'1': 'sdkVersion', '3': 1, '4': 1, '5': 9, '10': 'sdkVersion'},
    {'1': 'sdkVersionFull', '3': 2, '4': 1, '5': 9, '10': 'sdkVersionFull'},
    {'1': 'runtimeVersion', '3': 3, '4': 1, '5': 9, '10': 'runtimeVersion'},
    {'1': 'appEngineVersion', '3': 4, '4': 1, '5': 9, '10': 'appEngineVersion'},
    {'1': 'servicesVersion', '3': 5, '4': 1, '5': 9, '10': 'servicesVersion'},
    {'1': 'flutterVersion', '3': 6, '4': 1, '5': 9, '10': 'flutterVersion'},
    {
      '1': 'flutterDartVersion',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'flutterDartVersion'
    },
    {
      '1': 'flutterDartVersionFull',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'flutterDartVersionFull'
    },
    {
      '1': 'packageVersions',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.VersionResponse.PackageVersionsEntry',
      '10': 'packageVersions'
    },
    {
      '1': 'packageInfo',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.PackageInfo',
      '10': 'packageInfo'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
  '3': [VersionResponse_PackageVersionsEntry$json],
};

@$core.Deprecated('Use versionResponseDescriptor instead')
const VersionResponse_PackageVersionsEntry$json = {
  '1': 'PackageVersionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `VersionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionResponseDescriptor = $convert.base64Decode(
    'Cg9WZXJzaW9uUmVzcG9uc2USHgoKc2RrVmVyc2lvbhgBIAEoCVIKc2RrVmVyc2lvbhImCg5zZGtWZXJzaW9uRnVsbBgCIAEoCVIOc2RrVmVyc2lvbkZ1bGwSJgoOcnVudGltZVZlcnNpb24YAyABKAlSDnJ1bnRpbWVWZXJzaW9uEioKEGFwcEVuZ2luZVZlcnNpb24YBCABKAlSEGFwcEVuZ2luZVZlcnNpb24SKAoPc2VydmljZXNWZXJzaW9uGAUgASgJUg9zZXJ2aWNlc1ZlcnNpb24SJgoOZmx1dHRlclZlcnNpb24YBiABKAlSDmZsdXR0ZXJWZXJzaW9uEi4KEmZsdXR0ZXJEYXJ0VmVyc2lvbhgHIAEoCVISZmx1dHRlckRhcnRWZXJzaW9uEjYKFmZsdXR0ZXJEYXJ0VmVyc2lvbkZ1bGwYCCABKAlSFmZsdXR0ZXJEYXJ0VmVyc2lvbkZ1bGwSYQoPcGFja2FnZVZlcnNpb25zGAkgAygLMjcuZGFydF9zZXJ2aWNlcy5hcGkuVmVyc2lvblJlc3BvbnNlLlBhY2thZ2VWZXJzaW9uc0VudHJ5Ug9wYWNrYWdlVmVyc2lvbnMSQAoLcGFja2FnZUluZm8YCiADKAsyHi5kYXJ0X3NlcnZpY2VzLmFwaS5QYWNrYWdlSW5mb1ILcGFja2FnZUluZm8SNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9yGkIKFFBhY2thZ2VWZXJzaW9uc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use packageInfoDescriptor instead')
const PackageInfo$json = {
  '1': 'PackageInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
    {'1': 'supported', '3': 3, '4': 1, '5': 8, '10': 'supported'},
  ],
};

/// Descriptor for `PackageInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packageInfoDescriptor = $convert.base64Decode(
    'CgtQYWNrYWdlSW5mbxISCgRuYW1lGAEgASgJUgRuYW1lEhgKB3ZlcnNpb24YAiABKAlSB3ZlcnNpb24SHAoJc3VwcG9ydGVkGAMgASgIUglzdXBwb3J0ZWQ=');
@$core.Deprecated('Use badRequestDescriptor instead')
const BadRequest$json = {
  '1': 'BadRequest',
  '2': [
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `BadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List badRequestDescriptor = $convert.base64Decode(
    'CgpCYWRSZXF1ZXN0EjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use errorMessageDescriptor instead')
const ErrorMessage$json = {
  '1': 'ErrorMessage',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ErrorMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorMessageDescriptor = $convert
    .base64Decode('CgxFcnJvck1lc3NhZ2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use fairCompileResponseDescriptor instead')
const FairCompileResponse$json = {
  '1': 'FairCompileResponse',
  '2': [
    {'1': 'json', '3': 1, '4': 1, '5': 9, '10': 'json'},
    {'1': 'js', '3': 2, '4': 1, '5': 9, '10': 'js'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `FairCompileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fairCompileResponseDescriptor = $convert.base64Decode(
    'ChNGYWlyQ29tcGlsZVJlc3BvbnNlEhIKBGpzb24YASABKAlSBGpzb24SDgoCanMYAiABKAlSAmpzEjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use fairRunResponseDescriptor instead')
const FairRunResponse$json = {
  '1': 'FairRunResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `FairRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fairRunResponseDescriptor = $convert.base64Decode(
    'Cg9GYWlyUnVuUmVzcG9uc2USFgoGcmVzdWx0GAEgASgJUgZyZXN1bHQSNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9y');
@$core.Deprecated('Use getProjectRequestDescriptor instead')
const GetProjectRequest$json = {
  '1': 'GetProjectRequest',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetProjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProjectRequestDescriptor = $convert.base64Decode(
    'ChFHZXRQcm9qZWN0UmVxdWVzdBIWCgZ1c2VySWQYASABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use getProjectResponseDescriptor instead')
const GetProjectResponse$json = {
  '1': 'GetProjectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.ProjectInfo',
      '10': 'result'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetProjectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProjectResponseDescriptor = $convert.base64Decode(
    'ChJHZXRQcm9qZWN0UmVzcG9uc2USNgoGcmVzdWx0GAEgAygLMh4uZGFydF9zZXJ2aWNlcy5hcGkuUHJvamVjdEluZm9SBnJlc3VsdBI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use projectInfoDescriptor instead')
const ProjectInfo$json = {
  '1': 'ProjectInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'modifiedTime', '3': 2, '4': 1, '5': 9, '10': 'modifiedTime'},
    {'1': 'desc', '3': 3, '4': 1, '5': 9, '10': 'desc'},
    {'1': 'screenshot', '3': 4, '4': 1, '5': 9, '10': 'screenshot'},
  ],
};

/// Descriptor for `ProjectInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectInfoDescriptor = $convert.base64Decode(
    'CgtQcm9qZWN0SW5mbxISCgRuYW1lGAEgASgJUgRuYW1lEiIKDG1vZGlmaWVkVGltZRgCIAEoCVIMbW9kaWZpZWRUaW1lEhIKBGRlc2MYAyABKAlSBGRlc2MSHgoKc2NyZWVuc2hvdBgEIAEoCVIKc2NyZWVuc2hvdA==');
@$core.Deprecated('Use createProjectRequestDescriptor instead')
const CreateProjectRequest$json = {
  '1': 'CreateProjectRequest',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'projectName', '3': 2, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'templateProject', '3': 3, '4': 1, '5': 9, '10': 'templateProject'},
  ],
};

/// Descriptor for `CreateProjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createProjectRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVQcm9qZWN0UmVxdWVzdBIWCgZ1c2VySWQYASABKAlSBnVzZXJJZBIgCgtwcm9qZWN0TmFtZRgCIAEoCVILcHJvamVjdE5hbWUSKAoPdGVtcGxhdGVQcm9qZWN0GAMgASgJUg90ZW1wbGF0ZVByb2plY3Q=');
@$core.Deprecated('Use createProjectResponseDescriptor instead')
const CreateProjectResponse$json = {
  '1': 'CreateProjectResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `CreateProjectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createProjectResponseDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVQcm9qZWN0UmVzcG9uc2USFgoGcmVzdWx0GAEgASgJUgZyZXN1bHQSNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9y');
@$core.Deprecated('Use deleteProjectRequestDescriptor instead')
const DeleteProjectRequest$json = {
  '1': 'DeleteProjectRequest',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'projectName', '3': 2, '4': 1, '5': 9, '10': 'projectName'},
  ],
};

/// Descriptor for `DeleteProjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteProjectRequestDescriptor = $convert.base64Decode(
    'ChREZWxldGVQcm9qZWN0UmVxdWVzdBIWCgZ1c2VySWQYASABKAlSBnVzZXJJZBIgCgtwcm9qZWN0TmFtZRgCIAEoCVILcHJvamVjdE5hbWU=');
@$core.Deprecated('Use deleteProjectResponseDescriptor instead')
const DeleteProjectResponse$json = {
  '1': 'DeleteProjectResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `DeleteProjectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteProjectResponseDescriptor = $convert.base64Decode(
    'ChVEZWxldGVQcm9qZWN0UmVzcG9uc2USFgoGcmVzdWx0GAEgASgJUgZyZXN1bHQSNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9y');
@$core.Deprecated('Use copyPageRequestDescriptor instead')
const CopyPageRequest$json = {
  '1': 'CopyPageRequest',
  '2': [
    {'1': 'dir', '3': 1, '4': 1, '5': 9, '10': 'dir'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `CopyPageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List copyPageRequestDescriptor = $convert.base64Decode(
    'Cg9Db3B5UGFnZVJlcXVlc3QSEAoDZGlyGAEgASgJUgNkaXISEgoEcGF0aBgCIAEoCVIEcGF0aA==');
@$core.Deprecated('Use commonResponseDescriptor instead')
const CommonResponse$json = {
  '1': 'CommonResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `CommonResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commonResponseDescriptor = $convert.base64Decode(
    'Cg5Db21tb25SZXNwb25zZRIWCgZyZXN1bHQYASABKAlSBnJlc3VsdBI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use getProjectPagesRequestDescriptor instead')
const GetProjectPagesRequest$json = {
  '1': 'GetProjectPagesRequest',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'projectName', '3': 2, '4': 1, '5': 9, '10': 'projectName'},
  ],
};

/// Descriptor for `GetProjectPagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProjectPagesRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRQcm9qZWN0UGFnZXNSZXF1ZXN0EhYKBnVzZXJJZBgBIAEoCVIGdXNlcklkEiAKC3Byb2plY3ROYW1lGAIgASgJUgtwcm9qZWN0TmFtZQ==');
@$core.Deprecated('Use getProjectPagesResponseDescriptor instead')
const GetProjectPagesResponse$json = {
  '1': 'GetProjectPagesResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.ProjectPageInfo',
      '10': 'result'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetProjectPagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProjectPagesResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRQcm9qZWN0UGFnZXNSZXNwb25zZRI6CgZyZXN1bHQYASADKAsyIi5kYXJ0X3NlcnZpY2VzLmFwaS5Qcm9qZWN0UGFnZUluZm9SBnJlc3VsdBI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use getTemplatePagesRequestDescriptor instead')
const GetTemplatePagesRequest$json = {
  '1': 'GetTemplatePagesRequest',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'projectName', '3': 2, '4': 1, '5': 9, '10': 'projectName'},
  ],
};

/// Descriptor for `GetTemplatePagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTemplatePagesRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRUZW1wbGF0ZVBhZ2VzUmVxdWVzdBIWCgZ1c2VySWQYASABKAlSBnVzZXJJZBIgCgtwcm9qZWN0TmFtZRgCIAEoCVILcHJvamVjdE5hbWU=');
@$core.Deprecated('Use getTemplatePagesResponseDescriptor instead')
const GetTemplatePagesResponse$json = {
  '1': 'GetTemplatePagesResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.TemplatePageInfo',
      '10': 'result'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetTemplatePagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTemplatePagesResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRUZW1wbGF0ZVBhZ2VzUmVzcG9uc2USOwoGcmVzdWx0GAEgAygLMiMuZGFydF9zZXJ2aWNlcy5hcGkuVGVtcGxhdGVQYWdlSW5mb1IGcmVzdWx0EjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use projectPageInfoDescriptor instead')
const ProjectPageInfo$json = {
  '1': 'ProjectPageInfo',
  '2': [
    {'1': 'dir', '3': 1, '4': 1, '5': 9, '10': 'dir'},
    {
      '1': 'files',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.FileInfo',
      '10': 'files'
    },
  ],
};

/// Descriptor for `ProjectPageInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectPageInfoDescriptor = $convert.base64Decode(
    'Cg9Qcm9qZWN0UGFnZUluZm8SEAoDZGlyGAEgASgJUgNkaXISMQoFZmlsZXMYAiADKAsyGy5kYXJ0X3NlcnZpY2VzLmFwaS5GaWxlSW5mb1IFZmlsZXM=');
@$core.Deprecated('Use fileInfoDescriptor instead')
const FileInfo$json = {
  '1': 'FileInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `FileInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileInfoDescriptor = $convert.base64Decode(
    'CghGaWxlSW5mbxISCgRuYW1lGAEgASgJUgRuYW1lEhIKBHBhdGgYAiABKAlSBHBhdGg=');
@$core.Deprecated('Use templatePageInfoDescriptor instead')
const TemplatePageInfo$json = {
  '1': 'TemplatePageInfo',
  '2': [
    {'1': 'pageName', '3': 1, '4': 1, '5': 9, '10': 'pageName'},
    {'1': 'pagePath', '3': 2, '4': 1, '5': 9, '10': 'pagePath'},
    {'1': 'screenshot', '3': 3, '4': 1, '5': 9, '10': 'screenshot'},
  ],
};

/// Descriptor for `TemplatePageInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List templatePageInfoDescriptor = $convert.base64Decode(
    'ChBUZW1wbGF0ZVBhZ2VJbmZvEhoKCHBhZ2VOYW1lGAEgASgJUghwYWdlTmFtZRIaCghwYWdlUGF0aBgCIAEoCVIIcGFnZVBhdGgSHgoKc2NyZWVuc2hvdBgDIAEoCVIKc2NyZWVuc2hvdA==');
@$core.Deprecated('Use deleteProjectPageRequestDescriptor instead')
const DeleteProjectPageRequest$json = {
  '1': 'DeleteProjectPageRequest',
  '2': [
    {'1': 'projectName', '3': 1, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'pageName', '3': 2, '4': 1, '5': 9, '10': 'pageName'},
    {'1': 'userId', '3': 3, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `DeleteProjectPageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteProjectPageRequestDescriptor =
    $convert.base64Decode(
        'ChhEZWxldGVQcm9qZWN0UGFnZVJlcXVlc3QSIAoLcHJvamVjdE5hbWUYASABKAlSC3Byb2plY3ROYW1lEhoKCHBhZ2VOYW1lGAIgASgJUghwYWdlTmFtZRIWCgZ1c2VySWQYAyABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use deleteProjectPageResponseDescriptor instead')
const DeleteProjectPageResponse$json = {
  '1': 'DeleteProjectPageResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `DeleteProjectPageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteProjectPageResponseDescriptor =
    $convert.base64Decode(
        'ChlEZWxldGVQcm9qZWN0UGFnZVJlc3BvbnNlEhYKBnJlc3VsdBgBIAEoCVIGcmVzdWx0EjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use createProjectPageRequestDescriptor instead')
const CreateProjectPageRequest$json = {
  '1': 'CreateProjectPageRequest',
  '2': [
    {'1': 'pagePath', '3': 1, '4': 1, '5': 9, '10': 'pagePath'},
    {'1': 'pageName', '3': 2, '4': 1, '5': 9, '10': 'pageName'},
  ],
};

/// Descriptor for `CreateProjectPageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createProjectPageRequestDescriptor =
    $convert.base64Decode(
        'ChhDcmVhdGVQcm9qZWN0UGFnZVJlcXVlc3QSGgoIcGFnZVBhdGgYASABKAlSCHBhZ2VQYXRoEhoKCHBhZ2VOYW1lGAIgASgJUghwYWdlTmFtZQ==');
@$core.Deprecated('Use createProjectPageResponseDescriptor instead')
const CreateProjectPageResponse$json = {
  '1': 'CreateProjectPageResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `CreateProjectPageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createProjectPageResponseDescriptor =
    $convert.base64Decode(
        'ChlDcmVhdGVQcm9qZWN0UGFnZVJlc3BvbnNlEhYKBnJlc3VsdBgBIAEoCVIGcmVzdWx0EjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use createTemplatePageResponseDescriptor instead')
const CreateTemplatePageResponse$json = {
  '1': 'CreateTemplatePageResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `CreateTemplatePageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTemplatePageResponseDescriptor =
    $convert.base64Decode(
        'ChpDcmVhdGVUZW1wbGF0ZVBhZ2VSZXNwb25zZRIWCgZyZXN1bHQYASABKAlSBnJlc3VsdBI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use createTemplatePageRequestDescriptor instead')
const CreateTemplatePageRequest$json = {
  '1': 'CreateTemplatePageRequest',
  '2': [
    {'1': 'pagePath', '3': 1, '4': 1, '5': 9, '10': 'pagePath'},
    {'1': 'pageName', '3': 2, '4': 1, '5': 9, '10': 'pageName'},
    {'1': 'templatePage', '3': 3, '4': 1, '5': 9, '10': 'templatePage'},
  ],
};

/// Descriptor for `CreateTemplatePageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTemplatePageRequestDescriptor =
    $convert.base64Decode(
        'ChlDcmVhdGVUZW1wbGF0ZVBhZ2VSZXF1ZXN0EhoKCHBhZ2VQYXRoGAEgASgJUghwYWdlUGF0aBIaCghwYWdlTmFtZRgCIAEoCVIIcGFnZU5hbWUSIgoMdGVtcGxhdGVQYWdlGAMgASgJUgx0ZW1wbGF0ZVBhZ2U=');
@$core.Deprecated('Use getPageRequestDescriptor instead')
const GetPageRequest$json = {
  '1': 'GetPageRequest',
  '2': [
    {'1': 'pagePath', '3': 1, '4': 1, '5': 9, '10': 'pagePath'},
  ],
};

/// Descriptor for `GetPageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPageRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRQYWdlUmVxdWVzdBIaCghwYWdlUGF0aBgBIAEoCVIIcGFnZVBhdGg=');
@$core.Deprecated('Use getPageResponseDescriptor instead')
const GetPageResponse$json = {
  '1': 'GetPageResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetPageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPageResponseDescriptor = $convert.base64Decode(
    'Cg9HZXRQYWdlUmVzcG9uc2USFgoGcmVzdWx0GAEgASgJUgZyZXN1bHQSNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9y');
@$core.Deprecated('Use commonRequestDescriptor instead')
const CommonRequest$json = {
  '1': 'CommonRequest',
};

/// Descriptor for `CommonRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commonRequestDescriptor =
    $convert.base64Decode('Cg1Db21tb25SZXF1ZXN0');
@$core.Deprecated('Use getFairDslListResponseDescriptor instead')
const GetFairDslListResponse$json = {
  '1': 'GetFairDslListResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.FairDslInfo',
      '10': 'result'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetFairDslListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFairDslListResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRGYWlyRHNsTGlzdFJlc3BvbnNlEjYKBnJlc3VsdBgBIAMoCzIeLmRhcnRfc2VydmljZXMuYXBpLkZhaXJEc2xJbmZvUgZyZXN1bHQSNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9y');
@$core.Deprecated('Use fairDslInfoDescriptor instead')
const FairDslInfo$json = {
  '1': 'FairDslInfo',
  '2': [
    {'1': 'jsonPath', '3': 1, '4': 1, '5': 9, '10': 'jsonPath'},
    {'1': 'jsPath', '3': 2, '4': 1, '5': 9, '10': 'jsPath'},
  ],
};

/// Descriptor for `FairDslInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fairDslInfoDescriptor = $convert.base64Decode(
    'CgtGYWlyRHNsSW5mbxIaCghqc29uUGF0aBgBIAEoCVIIanNvblBhdGgSFgoGanNQYXRoGAIgASgJUgZqc1BhdGg=');
@$core.Deprecated('Use getFairDslRequestDescriptor instead')
const GetFairDslRequest$json = {
  '1': 'GetFairDslRequest',
  '2': [
    {'1': 'pageName', '3': 1, '4': 1, '5': 9, '10': 'pageName'},
    {'1': 'jsonPath', '3': 2, '4': 1, '5': 9, '10': 'jsonPath'},
    {'1': 'jsPath', '3': 3, '4': 1, '5': 9, '10': 'jsPath'},
  ],
};

/// Descriptor for `GetFairDslRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFairDslRequestDescriptor = $convert.base64Decode(
    'ChFHZXRGYWlyRHNsUmVxdWVzdBIaCghwYWdlTmFtZRgBIAEoCVIIcGFnZU5hbWUSGgoIanNvblBhdGgYAiABKAlSCGpzb25QYXRoEhYKBmpzUGF0aBgDIAEoCVIGanNQYXRo');
@$core.Deprecated('Use getFairDslResponseDescriptor instead')
const GetFairDslResponse$json = {
  '1': 'GetFairDslResponse',
  '2': [
    {'1': 'json', '3': 1, '4': 1, '5': 9, '10': 'json'},
    {'1': 'js', '3': 2, '4': 1, '5': 9, '10': 'js'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetFairDslResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFairDslResponseDescriptor = $convert.base64Decode(
    'ChJHZXRGYWlyRHNsUmVzcG9uc2USEgoEanNvbhgBIAEoCVIEanNvbhIOCgJqcxgCIAEoCVICanMSNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9y');
@$core.Deprecated('Use apiCallInfoDescriptor instead')
const ApiCallInfo$json = {
  '1': 'ApiCallInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    {
      '1': 'params',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.ApiCallParamsInfo',
      '10': 'params'
    },
  ],
};

/// Descriptor for `ApiCallInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List apiCallInfoDescriptor = $convert.base64Decode(
    'CgtBcGlDYWxsSW5mbxISCgRuYW1lGAEgASgJUgRuYW1lEhYKBm1ldGhvZBgCIAEoCVIGbWV0aG9kEhAKA3VybBgDIAEoCVIDdXJsEjwKBnBhcmFtcxgEIAMoCzIkLmRhcnRfc2VydmljZXMuYXBpLkFwaUNhbGxQYXJhbXNJbmZvUgZwYXJhbXM=');
@$core.Deprecated('Use apiCallParamsInfoDescriptor instead')
const ApiCallParamsInfo$json = {
  '1': 'ApiCallParamsInfo',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'value', '3': 3, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `ApiCallParamsInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List apiCallParamsInfoDescriptor = $convert.base64Decode(
    'ChFBcGlDYWxsUGFyYW1zSW5mbxIQCgNrZXkYASABKAlSA2tleRISCgR0eXBlGAIgASgJUgR0eXBlEhQKBXZhbHVlGAMgASgJUgV2YWx1ZQ==');
@$core.Deprecated('Use getApiCallResponseDescriptor instead')
const GetApiCallResponse$json = {
  '1': 'GetApiCallResponse',
  '2': [
    {
      '1': 'api',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.ApiCallInfo',
      '10': 'api'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetApiCallResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getApiCallResponseDescriptor = $convert.base64Decode(
    'ChJHZXRBcGlDYWxsUmVzcG9uc2USMAoDYXBpGAEgAygLMh4uZGFydF9zZXJ2aWNlcy5hcGkuQXBpQ2FsbEluZm9SA2FwaRI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use commonApiCallRequestDescriptor instead')
const CommonApiCallRequest$json = {
  '1': 'CommonApiCallRequest',
  '2': [
    {
      '1': 'api',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ApiCallInfo',
      '10': 'api'
    },
  ],
};

/// Descriptor for `CommonApiCallRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commonApiCallRequestDescriptor = $convert.base64Decode(
    'ChRDb21tb25BcGlDYWxsUmVxdWVzdBIwCgNhcGkYASABKAsyHi5kYXJ0X3NlcnZpY2VzLmFwaS5BcGlDYWxsSW5mb1IDYXBp');
@$core.Deprecated('Use commonApiCallResponseDescriptor instead')
const CommonApiCallResponse$json = {
  '1': 'CommonApiCallResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `CommonApiCallResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commonApiCallResponseDescriptor = $convert.base64Decode(
    'ChVDb21tb25BcGlDYWxsUmVzcG9uc2USFgoGcmVzdWx0GAEgASgJUgZyZXN1bHQSNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9y');
@$core.Deprecated('Use customComponentInfoDescriptor instead')
const CustomComponentInfo$json = {
  '1': 'CustomComponentInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'desc', '3': 2, '4': 1, '5': 9, '10': 'desc'},
    {'1': 'path', '3': 3, '4': 1, '5': 9, '10': 'path'},
    {'1': 'fairWidgetCode', '3': 4, '4': 1, '5': 9, '10': 'fairWidgetCode'},
    {'1': 'screenshot', '3': 5, '4': 1, '5': 9, '10': 'screenshot'},
  ],
};

/// Descriptor for `CustomComponentInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customComponentInfoDescriptor = $convert.base64Decode(
    'ChNDdXN0b21Db21wb25lbnRJbmZvEhIKBG5hbWUYASABKAlSBG5hbWUSEgoEZGVzYxgCIAEoCVIEZGVzYxISCgRwYXRoGAMgASgJUgRwYXRoEiYKDmZhaXJXaWRnZXRDb2RlGAQgASgJUg5mYWlyV2lkZ2V0Q29kZRIeCgpzY3JlZW5zaG90GAUgASgJUgpzY3JlZW5zaG90');
@$core.Deprecated('Use getCustomComponentsRequestDescriptor instead')
const GetCustomComponentsRequest$json = {
  '1': 'GetCustomComponentsRequest',
  '2': [
    {'1': 'projectName', '3': 1, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'userId', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetCustomComponentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomComponentsRequestDescriptor =
    $convert.base64Decode(
        'ChpHZXRDdXN0b21Db21wb25lbnRzUmVxdWVzdBIgCgtwcm9qZWN0TmFtZRgBIAEoCVILcHJvamVjdE5hbWUSFgoGdXNlcklkGAIgASgJUgZ1c2VySWQ=');
@$core.Deprecated('Use getCustomComponentsResponseDescriptor instead')
const GetCustomComponentsResponse$json = {
  '1': 'GetCustomComponentsResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.CustomComponentInfo',
      '10': 'result'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetCustomComponentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomComponentsResponseDescriptor =
    $convert.base64Decode(
        'ChtHZXRDdXN0b21Db21wb25lbnRzUmVzcG9uc2USPgoGcmVzdWx0GAEgAygLMiYuZGFydF9zZXJ2aWNlcy5hcGkuQ3VzdG9tQ29tcG9uZW50SW5mb1IGcmVzdWx0EjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use customActionInfoDescriptor instead')
const CustomActionInfo$json = {
  '1': 'CustomActionInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'desc', '3': 2, '4': 1, '5': 9, '10': 'desc'},
    {'1': 'path', '3': 3, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `CustomActionInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customActionInfoDescriptor = $convert.base64Decode(
    'ChBDdXN0b21BY3Rpb25JbmZvEhIKBG5hbWUYASABKAlSBG5hbWUSEgoEZGVzYxgCIAEoCVIEZGVzYxISCgRwYXRoGAMgASgJUgRwYXRo');
@$core.Deprecated('Use getCustomActionsRequestDescriptor instead')
const GetCustomActionsRequest$json = {
  '1': 'GetCustomActionsRequest',
  '2': [
    {'1': 'projectName', '3': 1, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'userId', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetCustomActionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomActionsRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRDdXN0b21BY3Rpb25zUmVxdWVzdBIgCgtwcm9qZWN0TmFtZRgBIAEoCVILcHJvamVjdE5hbWUSFgoGdXNlcklkGAIgASgJUgZ1c2VySWQ=');
@$core.Deprecated('Use getCustomActionsResponseDescriptor instead')
const GetCustomActionsResponse$json = {
  '1': 'GetCustomActionsResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.CustomActionInfo',
      '10': 'result'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetCustomActionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomActionsResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRDdXN0b21BY3Rpb25zUmVzcG9uc2USOwoGcmVzdWx0GAEgAygLMiMuZGFydF9zZXJ2aWNlcy5hcGkuQ3VzdG9tQWN0aW9uSW5mb1IGcmVzdWx0EjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use deleteCustomCodeItemRequestDescriptor instead')
const DeleteCustomCodeItemRequest$json = {
  '1': 'DeleteCustomCodeItemRequest',
  '2': [
    {'1': 'projectName', '3': 1, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'userId', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'path', '3': 4, '4': 1, '5': 9, '10': 'path'},
    {'1': 'type', '3': 5, '4': 1, '5': 9, '10': 'type'},
  ],
};

/// Descriptor for `DeleteCustomCodeItemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCustomCodeItemRequestDescriptor =
    $convert.base64Decode(
        'ChtEZWxldGVDdXN0b21Db2RlSXRlbVJlcXVlc3QSIAoLcHJvamVjdE5hbWUYASABKAlSC3Byb2plY3ROYW1lEhYKBnVzZXJJZBgCIAEoCVIGdXNlcklkEhIKBG5hbWUYAyABKAlSBG5hbWUSEgoEcGF0aBgEIAEoCVIEcGF0aBISCgR0eXBlGAUgASgJUgR0eXBl');
@$core.Deprecated('Use deleteCustomCodeItemResponseDescriptor instead')
const DeleteCustomCodeItemResponse$json = {
  '1': 'DeleteCustomCodeItemResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `DeleteCustomCodeItemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCustomCodeItemResponseDescriptor =
    $convert.base64Decode(
        'ChxEZWxldGVDdXN0b21Db2RlSXRlbVJlc3BvbnNlEhYKBnJlc3VsdBgBIAEoCVIGcmVzdWx0EjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use createCustomComponentRequestDescriptor instead')
const CreateCustomComponentRequest$json = {
  '1': 'CreateCustomComponentRequest',
  '2': [
    {'1': 'projectName', '3': 1, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'userId', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'desc', '3': 4, '4': 1, '5': 9, '10': 'desc'},
    {'1': 'content', '3': 5, '4': 1, '5': 9, '10': 'content'},
    {'1': 'screenshots', '3': 6, '4': 3, '5': 5, '10': 'screenshots'},
    {'1': 'editType', '3': 7, '4': 1, '5': 9, '10': 'editType'},
  ],
};

/// Descriptor for `CreateCustomComponentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCustomComponentRequestDescriptor =
    $convert.base64Decode(
        'ChxDcmVhdGVDdXN0b21Db21wb25lbnRSZXF1ZXN0EiAKC3Byb2plY3ROYW1lGAEgASgJUgtwcm9qZWN0TmFtZRIWCgZ1c2VySWQYAiABKAlSBnVzZXJJZBISCgRuYW1lGAMgASgJUgRuYW1lEhIKBGRlc2MYBCABKAlSBGRlc2MSGAoHY29udGVudBgFIAEoCVIHY29udGVudBIgCgtzY3JlZW5zaG90cxgGIAMoBVILc2NyZWVuc2hvdHMSGgoIZWRpdFR5cGUYByABKAlSCGVkaXRUeXBl');
@$core.Deprecated('Use createCustomComponentResponseDescriptor instead')
const CreateCustomComponentResponse$json = {
  '1': 'CreateCustomComponentResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 5, '10': 'status'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `CreateCustomComponentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCustomComponentResponseDescriptor =
    $convert.base64Decode(
        'Ch1DcmVhdGVDdXN0b21Db21wb25lbnRSZXNwb25zZRIWCgZzdGF0dXMYASABKAVSBnN0YXR1cxI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use createCustomActionRequestDescriptor instead')
const CreateCustomActionRequest$json = {
  '1': 'CreateCustomActionRequest',
  '2': [
    {'1': 'projectName', '3': 1, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'userId', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'desc', '3': 4, '4': 1, '5': 9, '10': 'desc'},
    {'1': 'content', '3': 5, '4': 1, '5': 9, '10': 'content'},
    {'1': 'editType', '3': 7, '4': 1, '5': 9, '10': 'editType'},
  ],
};

/// Descriptor for `CreateCustomActionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCustomActionRequestDescriptor =
    $convert.base64Decode(
        'ChlDcmVhdGVDdXN0b21BY3Rpb25SZXF1ZXN0EiAKC3Byb2plY3ROYW1lGAEgASgJUgtwcm9qZWN0TmFtZRIWCgZ1c2VySWQYAiABKAlSBnVzZXJJZBISCgRuYW1lGAMgASgJUgRuYW1lEhIKBGRlc2MYBCABKAlSBGRlc2MSGAoHY29udGVudBgFIAEoCVIHY29udGVudBIaCghlZGl0VHlwZRgHIAEoCVIIZWRpdFR5cGU=');
@$core.Deprecated('Use createCustomActionResponseDescriptor instead')
const CreateCustomActionResponse$json = {
  '1': 'CreateCustomActionResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 5, '10': 'status'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `CreateCustomActionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCustomActionResponseDescriptor =
    $convert.base64Decode(
        'ChpDcmVhdGVDdXN0b21BY3Rpb25SZXNwb25zZRIWCgZzdGF0dXMYASABKAVSBnN0YXR1cxI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use getComponentListRequestDescriptor instead')
const GetComponentListRequest$json = {
  '1': 'GetComponentListRequest',
  '2': [
    {'1': 'projectName', '3': 1, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'projectId', '3': 2, '4': 1, '5': 9, '10': 'projectId'},
    {'1': 'categoryType', '3': 3, '4': 1, '5': 9, '10': 'categoryType'},
  ],
};

/// Descriptor for `GetComponentListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getComponentListRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRDb21wb25lbnRMaXN0UmVxdWVzdBIgCgtwcm9qZWN0TmFtZRgBIAEoCVILcHJvamVjdE5hbWUSHAoJcHJvamVjdElkGAIgASgJUglwcm9qZWN0SWQSIgoMY2F0ZWdvcnlUeXBlGAMgASgJUgxjYXRlZ29yeVR5cGU=');
@$core.Deprecated('Use getComponentListResponseDescriptor instead')
const GetComponentListResponse$json = {
  '1': 'GetComponentListResponse',
  '2': [
    {'1': 'projectName', '3': 1, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'projectId', '3': 2, '4': 1, '5': 9, '10': 'projectId'},
    {'1': 'categoryType', '3': 3, '4': 1, '5': 9, '10': 'categoryType'},
    {
      '1': 'componentItems',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.dart_services.api.ComponentItemInfo',
      '10': 'componentItems'
    },
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetComponentListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getComponentListResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRDb21wb25lbnRMaXN0UmVzcG9uc2USIAoLcHJvamVjdE5hbWUYASABKAlSC3Byb2plY3ROYW1lEhwKCXByb2plY3RJZBgCIAEoCVIJcHJvamVjdElkEiIKDGNhdGVnb3J5VHlwZRgDIAEoCVIMY2F0ZWdvcnlUeXBlEkwKDmNvbXBvbmVudEl0ZW1zGAQgAygLMiQuZGFydF9zZXJ2aWNlcy5hcGkuQ29tcG9uZW50SXRlbUluZm9SDmNvbXBvbmVudEl0ZW1zEjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use componentItemInfoDescriptor instead')
const ComponentItemInfo$json = {
  '1': 'ComponentItemInfo',
  '2': [
    {'1': 'componentName', '3': 1, '4': 1, '5': 9, '10': 'componentName'},
    {'1': 'componentId', '3': 2, '4': 1, '5': 9, '10': 'componentId'},
    {'1': 'categoryType', '3': 3, '4': 1, '5': 9, '10': 'categoryType'},
    {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    {'1': 'content', '3': 5, '4': 1, '5': 9, '10': 'content'},
    {'1': 'dependencies', '3': 6, '4': 3, '5': 9, '10': 'dependencies'},
  ],
};

/// Descriptor for `ComponentItemInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List componentItemInfoDescriptor = $convert.base64Decode(
    'ChFDb21wb25lbnRJdGVtSW5mbxIkCg1jb21wb25lbnROYW1lGAEgASgJUg1jb21wb25lbnROYW1lEiAKC2NvbXBvbmVudElkGAIgASgJUgtjb21wb25lbnRJZBIiCgxjYXRlZ29yeVR5cGUYAyABKAlSDGNhdGVnb3J5VHlwZRISCgR0eXBlGAQgASgJUgR0eXBlEhgKB2NvbnRlbnQYBSABKAlSB2NvbnRlbnQSIgoMZGVwZW5kZW5jaWVzGAYgAygJUgxkZXBlbmRlbmNpZXM=');
@$core.Deprecated('Use exportProjectResponseDescriptor instead')
const ExportProjectResponse$json = {
  '1': 'ExportProjectResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `ExportProjectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportProjectResponseDescriptor = $convert.base64Decode(
    'ChVFeHBvcnRQcm9qZWN0UmVzcG9uc2USFgoGcmVzdWx0GAEgASgJUgZyZXN1bHQSNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9y');
@$core.Deprecated('Use dependencyPathRequestDescriptor instead')
const DependencyPathRequest$json = {
  '1': 'DependencyPathRequest',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'projectName', '3': 2, '4': 1, '5': 9, '10': 'projectName'},
  ],
};

/// Descriptor for `DependencyPathRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dependencyPathRequestDescriptor = $convert.base64Decode(
    'ChVEZXBlbmRlbmN5UGF0aFJlcXVlc3QSFgoGdXNlcklkGAEgASgJUgZ1c2VySWQSIAoLcHJvamVjdE5hbWUYAiABKAlSC3Byb2plY3ROYW1l');
@$core.Deprecated('Use dependencyPathResponseDescriptor instead')
const DependencyPathResponse$json = {
  '1': 'DependencyPathResponse',
  '2': [
    {'1': 'filePath', '3': 1, '4': 1, '5': 9, '10': 'filePath'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `DependencyPathResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dependencyPathResponseDescriptor =
    $convert.base64Decode(
        'ChZEZXBlbmRlbmN5UGF0aFJlc3BvbnNlEhoKCGZpbGVQYXRoGAEgASgJUghmaWxlUGF0aBI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use changeDependencyRequestDescriptor instead')
const ChangeDependencyRequest$json = {
  '1': 'ChangeDependencyRequest',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'version', '3': 3, '4': 1, '5': 9, '10': 'version'},
    {'1': 'userId', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'projectName', '3': 5, '4': 1, '5': 9, '10': 'projectName'},
  ],
};

/// Descriptor for `ChangeDependencyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeDependencyRequestDescriptor =
    $convert.base64Decode(
        'ChdDaGFuZ2VEZXBlbmRlbmN5UmVxdWVzdBISCgR0eXBlGAEgASgJUgR0eXBlEhIKBG5hbWUYAiABKAlSBG5hbWUSGAoHdmVyc2lvbhgDIAEoCVIHdmVyc2lvbhIWCgZ1c2VySWQYBCABKAlSBnVzZXJJZBIgCgtwcm9qZWN0TmFtZRgFIAEoCVILcHJvamVjdE5hbWU=');
@$core.Deprecated('Use changeDependencyResponseDescriptor instead')
const ChangeDependencyResponse$json = {
  '1': 'ChangeDependencyResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `ChangeDependencyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeDependencyResponseDescriptor =
    $convert.base64Decode(
        'ChhDaGFuZ2VEZXBlbmRlbmN5UmVzcG9uc2USFgoGcmVzdWx0GAEgASgJUgZyZXN1bHQSNQoFZXJyb3IYYyABKAsyHy5kYXJ0X3NlcnZpY2VzLmFwaS5FcnJvck1lc3NhZ2VSBWVycm9y');
@$core.Deprecated('Use doPubGetRequestDescriptor instead')
const DoPubGetRequest$json = {
  '1': 'DoPubGetRequest',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'projectName', '3': 2, '4': 1, '5': 9, '10': 'projectName'},
  ],
};

/// Descriptor for `DoPubGetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List doPubGetRequestDescriptor = $convert.base64Decode(
    'Cg9Eb1B1YkdldFJlcXVlc3QSFgoGdXNlcklkGAEgASgJUgZ1c2VySWQSIAoLcHJvamVjdE5hbWUYAiABKAlSC3Byb2plY3ROYW1l');
@$core.Deprecated('Use doPubGetResponseDescriptor instead')
const DoPubGetResponse$json = {
  '1': 'DoPubGetResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `DoPubGetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List doPubGetResponseDescriptor = $convert.base64Decode(
    'ChBEb1B1YkdldFJlc3BvbnNlEhYKBnJlc3VsdBgBIAEoCVIGcmVzdWx0EjUKBWVycm9yGGMgASgLMh8uZGFydF9zZXJ2aWNlcy5hcGkuRXJyb3JNZXNzYWdlUgVlcnJvcg==');
@$core.Deprecated('Use uploadPluginRequestDescriptor instead')
const UploadPluginRequest$json = {
  '1': 'UploadPluginRequest',
  '2': [
    {'1': 'appId', '3': 1, '4': 1, '5': 9, '10': 'appId'},
    {'1': 'bundleName', '3': 2, '4': 1, '5': 9, '10': 'bundleName'},
    {'1': 'patchUrl', '3': 3, '4': 1, '5': 9, '10': 'patchUrl'},
  ],
};

/// Descriptor for `UploadPluginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadPluginRequestDescriptor = $convert.base64Decode(
    'ChNVcGxvYWRQbHVnaW5SZXF1ZXN0EhQKBWFwcElkGAEgASgJUgVhcHBJZBIeCgpidW5kbGVOYW1lGAIgASgJUgpidW5kbGVOYW1lEhoKCHBhdGNoVXJsGAMgASgJUghwYXRjaFVybA==');
@$core.Deprecated('Use uploadPluginResponseDescriptor instead')
const UploadPluginResponse$json = {
  '1': 'UploadPluginResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `UploadPluginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadPluginResponseDescriptor = $convert.base64Decode(
    'ChRVcGxvYWRQbHVnaW5SZXNwb25zZRIWCgZyZXN1bHQYASABKAlSBnJlc3VsdBI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
@$core.Deprecated('Use getQrCodeResponseDescriptor instead')
const GetQrCodeResponse$json = {
  '1': 'GetQrCodeResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
    {
      '1': 'error',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.dart_services.api.ErrorMessage',
      '10': 'error'
    },
  ],
};

/// Descriptor for `GetQrCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQrCodeResponseDescriptor = $convert.base64Decode(
    'ChFHZXRRckNvZGVSZXNwb25zZRIWCgZyZXN1bHQYASABKAlSBnJlc3VsdBI1CgVlcnJvchhjIAEoCzIfLmRhcnRfc2VydmljZXMuYXBpLkVycm9yTWVzc2FnZVIFZXJyb3I=');
