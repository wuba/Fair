import 'dart:convert';

import 'package:http/browser_client.dart';
import 'package:protobuf/protobuf.dart';
import '../src/protos/dart_services.pb.dart';
export '../src/protos/dart_services.pb.dart';

const _apiPath = 'api/dartservices/v2';

class DartservicesApi {
  DartservicesApi(this._client, {required this.rootUrl});

  final BrowserClient _client;
  String rootUrl;

  Future<AnalysisResults> analyze(SourceRequest request) => _request(
        'analyze',
        request,
        AnalysisResults(),
      );

  Future<AnalysisResults> fairAnalyze(SourceRequest request) => _request(
    'fairAnalyze',
    request,
    AnalysisResults(),
  );

  Future<AssistsResponse> assists(SourceRequest request) => _request(
        'assists',
        request,
        AssistsResponse(),
      );

  Future<CompileResponse> compile(CompileRequest request) => _request(
        'compile',
        request,
        CompileResponse(),
      );

  Future<CompileDDCResponse> compileDDC(CompileDDCRequest request) => _request(
        'compileDDC',
        request,
        CompileDDCResponse(),
      );

  Future<CompleteResponse> complete(SourceRequest request) => _request(
        'complete',
        request,
        CompleteResponse(),
      );

  Future<DocumentResponse> document(SourceRequest request) => _request(
        'document',
        request,
        DocumentResponse(),
      );

  Future<FixesResponse> fixes(SourceRequest request) => _request(
        'fixes',
        request,
        FixesResponse(),
      );

  Future<FormatResponse> format(SourceRequest request) => _request(
        'format',
        request,
        FormatResponse(),
      );

  Future<VersionResponse> version() => _request(
        'version',
        VersionRequest(),
        VersionResponse(),
      );

  Future<FairCompileResponse> fairCompile(CompileRequest request) => _request(
    'fairCompile',
    request,
    FairCompileResponse(),
  );

  Future<FairRunResponse> fairRun(CompileRequest request) => _request(
    'fairRun',
    request,
    FairRunResponse(),
  );

  Future<GetProjectResponse> getProjects(GetProjectRequest request) => _request(
    'getProjects',
    request,
    GetProjectResponse(),
  );

  Future<GetProjectPagesResponse> getProjectPages(GetProjectPagesRequest request) => _request(
    'getProjectPages',
    request,
    GetProjectPagesResponse(),
  );

  Future<ChangeDependencyResponse> changeDependency(ChangeDependencyRequest request) => _request(
    'changeDependency',
    request,
    ChangeDependencyResponse(),
  );

  Future<DoPubGetResponse> doPubGet(DoPubGetRequest request) => _request(
    'doPubGet',
    request,
    DoPubGetResponse(),
  );

  Future<GetCustomComponentsResponse> getCustomComponents(GetCustomComponentsRequest request) => _request(
    'getCustomComponents',
    request,
    GetCustomComponentsResponse(),
  );

  Future<GetCustomActionsResponse> getCustomActions(GetCustomActionsRequest request) => _request(
    'getCustomActions',
    request,
    GetCustomActionsResponse(),
  );

  Future<DependencyPathResponse> getDependencyFilePath(DependencyPathRequest request) => _request(
    'getDependencyFilePath',
    request,
    DependencyPathResponse(),
  );

  Future<CreateCustomComponentResponse> createCustomComponent(CreateCustomComponentRequest request) => _request(
    'createCustomComponent',
    request,
    CreateCustomComponentResponse(),
  );

  Future<CreateCustomActionResponse> createCustomAction(CreateCustomActionRequest request) => _request(
    'createCustomAction',
    request,
    CreateCustomActionResponse(),
  );

  Future<DeleteCustomCodeItemResponse> deleteCustomCodeItem(DeleteCustomCodeItemRequest request) => _request(
    'deleteCustomCodeItem',
    request,
    DeleteCustomCodeItemResponse(),
  );

  Future<GetTemplatePagesResponse> getTemplatePages(GetTemplatePagesRequest request) => _request(
    'getTemplatePages',
    request,
    GetTemplatePagesResponse(),
  );

  Future<CreateTemplatePageResponse> createTemplatePage(CreateTemplatePageRequest request) => _request(
    'createTemplatePage',
    request,
    CreateTemplatePageResponse(),
  );

  Future<CreateProjectPageResponse> createProjectPage(CreateProjectPageRequest request) => _request(
    'createProjectPage',
    request,
    CreateProjectPageResponse(),
  );

  Future<CommonResponse> copyProjectPage(CopyPageRequest request) => _request(
    'copyProjectPage',
    request,
    CommonResponse(),
  );

  Future<DeleteProjectPageResponse> deleteProjectPage(DeleteProjectPageRequest request) => _request(
    'deleteProjectPage',
    request,
    DeleteProjectPageResponse(),
  );

  Future<GetProjectResponse> getTemplateProjects(GetProjectRequest request) => _request(
    'getTemplateProjects',
    request,
    GetProjectResponse(),
  );

  Future<CreateProjectResponse> createProject(CreateProjectRequest request) => _request(
    'createProject',
    request,
    CreateProjectResponse(),
  );

  Future<DeleteProjectResponse> deleteProject(DeleteProjectRequest request) => _request(
    'deleteProject',
    request,
    DeleteProjectResponse(),
  );

  Future<GetPageResponse> getPage(GetPageRequest request) => _request(
    'getPage',
    request,
    GetPageResponse(),
  );

  Future<GetFairDslListResponse> getFairDslList(CommonRequest request) =>
      _request(
        'getFairDslList',
        request,
        GetFairDslListResponse(),
      );

  Future<GetFairDslResponse> getFairDsl(GetFairDslRequest request) => _request(
        'getFairDsl',
        request,
        GetFairDslResponse(),
      );

  Future<GetApiCallResponse> getApiCall(CommonApiCallRequest request) => _request(
    'getApiCall',
    request,
    GetApiCallResponse(),
  );

  Future<GetApiCallResponse> getSingleApiCall(CommonApiCallRequest request) => _request(
    'getSingleApiCall',
    request,
    GetApiCallResponse(),
  );

  Future<CommonApiCallResponse> addApiCall(CommonApiCallRequest request) => _request(
    'addApiCall',
    request,
    CommonApiCallResponse(),
  );

  Future<CommonApiCallResponse> deleteApiCall(CommonApiCallRequest request) => _request(
    'deleteApiCall',
    request,
    CommonApiCallResponse(),
  );

  Future<ExportProjectResponse> exportProject(CommonRequest request) => _request(
    'exportProject',
    request,
    ExportProjectResponse(),
  );

  Future<UploadPluginResponse> uploadPlugin(UploadPluginRequest request) =>
      _request(
        'uploadPlugin',
        request,
        UploadPluginResponse(),
      );

  Future<GetQrCodeResponse> getQrCode(CommonRequest request) => _request(
    'getQrCode',
    request,
    GetQrCodeResponse(),
  );

  Future<O> _request<I extends GeneratedMessage, O extends GeneratedMessage>(
    String action,
    I request,
    O result,
  ) async {
    Uri uri = Uri.parse('$rootUrl$_apiPath/$action');
    final response = await _client.post(
      uri,
      encoding: utf8,
      body: json.encode(request.toProto3Json()),
    );
    final jsonBody = json.decode(response.body);
    result
      ..mergeFromProto3Json(jsonBody)
      ..freeze();

    // 99 is the tag number for error message.
    if (result.getFieldOrNull(99) != null) {
      final br = BadRequest()
        ..mergeFromProto3Json(jsonBody)
        ..freeze();
      throw ApiRequestError(br.error.message);
    }

    return result;
  }
}

class ApiRequestError implements Exception {
  ApiRequestError(this.message);
  final String message;
}
