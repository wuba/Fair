library services.common_server_impl;

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:fair_online_service/src/apicall/api_call.dart';
import 'package:fair_online_service/src/customcode/custom_code.dart';
import 'package:fair_online_service/src/project/fair_project.dart';
import 'package:logging/logging.dart';

import '../version.dart';
import 'common.dart';
import 'compiler.dart';
import 'component/component.dart';
import 'fair_compiler.dart';
import 'protos/dart_services.pb.dart' as proto;
import 'sdk.dart';
import 'server_cache.dart';

const Duration _standardExpiration = Duration(hours: 1);
final Logger log = Logger('common_server');

class BadRequest implements Exception {
  String cause;

  BadRequest(this.cause);
}

abstract class ServerContainer {
  String get version;
}

///SourceRequest的type类型
class SourceType {
  static String filePath = 'filePath'; //有文件路径的类型
  static String temp = 'temp'; //无文件路径，使用临时文件
}

///运行模式
class RunMode {
  static String project = 'project'; //运行整个工程
  static String singlePage = 'singlePage'; //单页面编译运行
}

class CommonServerImpl {
  final ServerContainer _container;
  final ServerCache _cache;
  final Sdk _sdk;

  late Compiler _compiler;
  late FairCompiler _fairCompiler;

  late FairProject _fairProject;

  late ApiCall _apiCall;

  late Component _compoent;

  late CustomCode _customCode;

  CommonServerImpl(
    this._container,
    this._cache,
    this._sdk,
  ) {
    hierarchicalLoggingEnabled = true;
    log.level = Level.ALL;
  }

  Future<void> init() async {
    log.info(
        'Beginning CommonServer init(). dart sdk path:${_sdk.dartSdkPath}');
    _compiler = Compiler(_sdk);
    _fairCompiler = FairCompiler(_sdk);
    _fairProject = FairProject(_sdk);
    _apiCall = ApiCall();
    _compoent = Component();
    _customCode = CustomCode();
  }

  Future<dynamic> shutdown() {
    return Future.wait(<Future<dynamic>>[
      // _analysisServers.shutdown(),
      _compiler.dispose(),
      Future<dynamic>.sync(_cache.shutdown)
    ]).timeout(const Duration(minutes: 1));
  }

  Future<proto.AnalysisResults> analyze(
    proto.SourceRequest request,
    Map<String, String> header,
  ) {
    if (!request.hasSource()) {
      throw BadRequest('Missing parameter: \'source\'');
    }

    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }

    final analysisServer = gFlutterAnalysisWrapper[userId + projectName];

    if (analysisServer == null) {
      throw BadRequest('Analysis Server not initialized');
    }

    return _perfLogAndRestart(
        request.source,
        () => analysisServer.analyze(
            request.source, request.filePath, request.type),
        'analysis',
        'server:${userId + projectName} Error during analyze on "${request.source}"');
  }

  Future<proto.CompileDDCResponse> compileDDC(
    proto.CompileDDCRequest request,
    Map<String, String> header,
  ) {
    if (!request.hasSource()) {
      throw BadRequest('Missing parameter: \'source\'');
    }
    if (!request.hasPageName()) {
      throw BadRequest('Missing parameter: \'pageName\'');
    }
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }

    return _compileDDC(request.source, request.pageName, userId, projectName,
        request.type, request.runMode);
  }

  Future<proto.CompleteResponse> complete(
    proto.SourceRequest request,
    Map<String, String> header,
  ) {
    if (!request.hasSource()) {
      throw BadRequest('Missing parameter: \'source\'');
    }
    if (!request.hasOffset()) {
      throw BadRequest('Missing parameter: \'offset\'');
    }

    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    final analysisServer = gFlutterAnalysisWrapper[userId + projectName];

    if (analysisServer == null) {
      throw BadRequest('Analysis Server not initialized');
    }

    return _perfLogAndRestart(
        request.source,
        () => analysisServer.complete(
              request.source,
              request.offset,
              request.filePath,
              request.type,
            ),
        'completions',
        'server:${userId + projectName} Error during complete on "${request.source}" at ${request.offset}');
  }

  Future<proto.FixesResponse> fixes(
    proto.SourceRequest request,
    Map<String, String> header,
  ) {
    if (!request.hasSource()) {
      throw BadRequest('Missing parameter: \'source\'');
    }
    if (!request.hasOffset()) {
      throw BadRequest('Missing parameter: \'offset\'');
    }

    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    final analysisServer = gFlutterAnalysisWrapper[userId + projectName];

    if (analysisServer == null) {
      throw BadRequest('Analysis Server not initialized');
    }

    return _perfLogAndRestart(
        request.source,
        () => analysisServer.getFixes(
              request.source,
              request.offset,
              request.filePath,
              request.type,
            ),
        'fixes',
        'server:${userId + projectName} Error during fixes on "${request.source}" at ${request.offset}');
  }

  Future<proto.AssistsResponse> assists(
    proto.SourceRequest request,
    Map<String, String> header,
  ) {
    if (!request.hasSource()) {
      throw BadRequest('Missing parameter: \'source\'');
    }
    if (!request.hasOffset()) {
      throw BadRequest('Missing parameter: \'offset\'');
    }

    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    final analysisServer = gFlutterAnalysisWrapper[userId + projectName];

    if (analysisServer == null) {
      throw BadRequest('Analysis Server not initialized');
    }

    return _perfLogAndRestart(
        request.source,
        () => analysisServer.getAssists(
              request.source,
              request.offset,
              request.filePath,
              request.type,
            ),
        'assists',
        'server:${userId + projectName} Error during assists on "${request.source}" at ${request.offset}');
  }

  Future<proto.FormatResponse> format(
    proto.SourceRequest request,
    Map<String, String> header,
  ) {
    if (!request.hasSource()) {
      throw BadRequest('Missing parameter: \'source\'');
    }

    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    final analysisServer = gFlutterAnalysisWrapper[userId + projectName];

    if (analysisServer == null) {
      throw BadRequest('Analysis Server not initialized');
    }

    return _perfLogAndRestart(
        request.source,
        () => analysisServer.format(
              request.source,
              request.offset,
              request.filePath,
              request.type,
            ),
        'format',
        'server:${userId + projectName} Error during format on "${request.source}" at ${request.offset}');
  }

  Future<proto.DocumentResponse> document(
    proto.SourceRequest request,
    Map<String, String> header,
  ) async {
    if (!request.hasSource()) {
      throw BadRequest('Missing parameter: \'source\'');
    }
    if (!request.hasOffset()) {
      throw BadRequest('Missing parameter: \'offset\'');
    }

    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    final analysisServer = gFlutterAnalysisWrapper[userId + projectName];

    if (analysisServer == null) {
      throw BadRequest('Analysis Server not initialized');
    }

    return proto.DocumentResponse()
      ..info.addAll(await _perfLogAndRestart(
          request.source,
          () => analysisServer.dartdoc(
                request.source,
                request.offset,
                request.filePath,
                request.type,
              ),
          'dartdoc',
          'server:${userId + projectName} Error during dartdoc on "${request.source}" at ${request.offset}'));
  }

  Future<proto.VersionResponse> version(
    proto.VersionRequest _,
    Map<String, String> header,
  ) {
    final packageVersions = <String, String>{};
    final packageInfos = [
      for (var packageName in packageVersions.keys)
        proto.PackageInfo()
          ..name = packageName
          ..version = packageVersions[packageName]!
          ..supported = true,
    ];

    return Future.value(
      proto.VersionResponse()
        ..sdkVersion = _sdk.version
        ..sdkVersionFull = _sdk.versionFull
        ..runtimeVersion = vmVersion
        ..servicesVersion = servicesVersion
        ..appEngineVersion = _container.version
        ..flutterDartVersion = _sdk.version
        ..flutterDartVersionFull = _sdk.versionFull
        ..flutterVersion = _sdk.flutterVersion
        ..packageVersions.addAll(packageVersions)
        ..packageInfo.addAll(packageInfos),
    );
  }

  Future<proto.CompileDDCResponse> _compileDDC(String source, String pageName,
      String userId, String projectName, String type, String runMode) async {
    try {
      final sourceHash = _hashSource(source);
      final memCacheKey = '%%COMPILE_DDC:v0:source:$sourceHash';

      final result = await _checkCache(memCacheKey);
      if (result != null) {
        log.info('CACHE: Cache hit for compileDDC');
        final resultObj = json.decode(result) as Map<String, dynamic>;
        return proto.CompileDDCResponse()
          ..result = resultObj['compiledJS'] as String
          ..modulesBaseUrl = resultObj['modulesBaseUrl'] as String;
      }

      log.info('CACHE: MISS for compileDDC');
      final watch = Stopwatch()..start();

      final results = await _compiler.compileDDC(
          source, pageName, userId, projectName, type, runMode);

      if (results.hasOutput) {
        final lineCount = source.split('\n').length;
        final outputSize = (results.compiledJS?.length ?? 0 / 1024).ceil();
        final ms = watch.elapsedMilliseconds;
        log.info('PERF: Compiled $lineCount lines of Dart into '
            '${outputSize}kb of JavaScript in ${ms}ms using DDC.');

        final cachedResult = const JsonEncoder().convert(<String, String>{
          'compiledJS': results.compiledJS ?? '',
          'modulesBaseUrl': results.modulesBaseUrl ?? '',
        });
        // Don't block on cache set.
        unawaited(_setCache(memCacheKey, cachedResult));
        return proto.CompileDDCResponse()
          ..result = results.compiledJS ?? ''
          ..modulesBaseUrl = results.modulesBaseUrl ?? '';
      } else {
        final problems = results.problems;
        final errors = problems.map(_printCompileProblem).join('\n');
        log.info('compileDDC failed, error : $errors');
        throw BadRequest(errors);
      }
    } catch (e, st) {
      if (e is! BadRequest) {
        log.severe('Error during compile (DDC) on "$source"', e, st);
      }
      rethrow;
    }
  }

  Future<String?> _checkCache(String query) => _cache.get(query);

  Future<void> _setCache(String query, String result) =>
      _cache.set(query, result, expiration: _standardExpiration);

  Future<proto.FairCompileResponse> fairCompile(
    proto.CompileRequest request,
    Map<String, String> header,
  ) {
    if (!request.hasSource()) {
      throw BadRequest('Missing parameter: \'source\'');
    }

    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }

    return _compileDart2FairDsl(request.source, userId, projectName);
  }

  Future<proto.FairCompileResponse> _compileDart2FairDsl(
      String source, String userId, String projectName) async {
    try {
      final watch = Stopwatch()..start();
      final results = await _fairCompiler.compile(source, userId, projectName);
      if (results.hasOutput) {
        final lineCount = source.split('\n').length;
        final outputSize = (results.compiledJS?.length ?? 0 / 1024).ceil();
        final ms = watch.elapsedMilliseconds;
        log.info('PERF: Compiled $lineCount lines of Dart into '
            '${outputSize}kb of JavaScript in ${ms}ms using Dart2FairDsl.');
        return proto.FairCompileResponse()
          ..js = results.compiledJS ?? ''
          ..json = results.compiledJson ?? '';
      } else {
        final problems = results.problems;
        final errors = problems.map(_printCompileProblem).join('\n');
        throw BadRequest(errors);
      }
    } catch (e, st) {
      if (e is! BadRequest) {
        log.severe('Error during compileDart2FairDsl on "$source"', e, st);
      }
      rethrow;
    }
  }

  Future<proto.FairRunResponse> fairRun(
    proto.CompileRequest request,
    Map<String, String> header,
  ) {
    if (!request.hasSource()) {
      throw BadRequest('Missing parameter: \'source\'');
    }
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairRun(request.source, userId, projectName);
  }

  Future<proto.FairRunResponse> _fairRun(
      String source, String userId, String projectName) async {
    try {
      final watch = Stopwatch()..start();
      final results = await _fairCompiler.run(source, userId, projectName);
      if (results.hasOutput) {
        final ms = watch.elapsedMilliseconds;
        log.info('PERF: fairRun cost ${ms}ms.');
        return proto.FairRunResponse()..result = results.url ?? '';
      } else {
        final problems = results.problems;
        final errors = problems.map(_printCompileProblem).join('\n');
        throw BadRequest(errors);
      }
    } catch (e, st) {
      if (e is! BadRequest) {
        log.severe('Error during compileDart2FairDsl on "$source"', e, st);
      }
      rethrow;
    }
  }

  Future<proto.GetProjectResponse> getProjects(
    proto.GetProjectRequest request,
    Map<String, String> header,
  ) {
    if (request.userId.isEmpty) {
      throw BadRequest('Missing parameter: \'userId\'');
    }
    return _fairProject.getProjects(request.userId);
  }

  Future<proto.GetProjectPagesResponse> getProjectPages(
    proto.GetProjectPagesRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairProject.getProjectsPages(userId, projectName);
  }

  Future<proto.CreateProjectPageResponse> createProjectPage(
      proto.CreateProjectPageRequest request, Map<String, String> header) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairProject.createProjectPage(
        projectName, request.pagePath, request.pageName, userId);
  }

  Future<proto.DeleteProjectPageResponse> deleteProjectPage(
      proto.DeleteProjectPageRequest request, Map<String, String> header) {
    return _fairProject.deleteProjectPage(
        request.projectName, request.pageName, request.userId);
  }

  Future<proto.CommonResponse> copyProjectPage(
      proto.CopyPageRequest request, Map<String, String> header) {
    final user = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (user.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairProject.copyProjectPage(
        user, projectName, request.dir, request.path);
  }

  Future<proto.CreateTemplatePageResponse> createTemplatePage(
      proto.CreateTemplatePageRequest request, Map<String, String> header) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairProject.createTemplatePage(
        projectName, request.pagePath, request.pageName, userId, request.templatePage);
  }

  //获取全部模板页面
  Future<proto.GetTemplatePagesResponse> getTemplatePages(
      proto.GetTemplatePagesRequest request, Map<String, String> header) {
    return _fairProject.getTemplatePages(request.projectName, request.userId);
  }

  //获取自定义组件
  Future<proto.GetCustomComponentsResponse> getCustomComponents(
      proto.GetCustomComponentsRequest request, Map<String, String> header) {
    return _customCode.getCustomComponents(
        request.projectName, request.userId);
  }

  //获取自定义Action
  Future<proto.GetCustomActionsResponse> getCustomActions(
      proto.GetCustomActionsRequest request, Map<String, String> header) {
    return _customCode.getCustomActions(
        request.projectName, request.userId);
  }

  //删除自定义代码
  Future<proto.DeleteCustomCodeItemResponse> deleteCustomCodeItem(
      proto.DeleteCustomCodeItemRequest request, Map<String, String> header) {
    return _customCode.deleteCustomCodeItem(request.projectName,
        request.userId, request.name, request.path, request.type);
  }

  //获取依赖文件路径
  Future<proto.DependencyPathResponse> getDependencyFilePath(
      proto.DependencyPathRequest request, Map<String, String> header) {
    return _fairProject.getDependencyFilePath(
        request.userId, request.projectName);
  }

  //更改依赖文件路径
  Future<proto.ChangeDependencyResponse> changeDependency(
      proto.ChangeDependencyRequest request, Map<String, String> header) {
    return _fairProject.changeDependency(request.type, request.name,
        request.version, request.userId, request.projectName);
  }

  //更改依赖文件路径
  Future<proto.DoPubGetResponse> doPubGet(
      proto.DoPubGetRequest request, Map<String, String> header) {
    return _fairProject.doPubGet(request.userId, request.projectName);
  }

  //创建自定义组件
  Future<proto.CreateCustomComponentResponse> createCustomComponent(
      proto.CreateCustomComponentRequest request, Map<String, String> header) {
    return _customCode.createCustomComponent(
        request.projectName,
        request.userId,
        request.name,
        request.desc,
        request.content,
        request.screenshots,
        request.editType);
  }

  //创建自定义Action
  Future<proto.CreateCustomActionResponse> createCustomAction(
      proto.CreateCustomActionRequest request, Map<String, String> header) {
    return _customCode.createCustomAction(request.projectName, request.userId,
        request.name, request.desc, request.content, request.editType);
  }

  Future<proto.GetProjectResponse> getTemplateProjects(
    proto.GetProjectRequest request,
    Map<String, String> header,
  ) {
    if (request.userId.isEmpty) {
      throw BadRequest('Missing parameter: \'userId\'');
    }
    return _fairProject.getTemplateProjects(request.userId);
  }

  Future<proto.CreateProjectResponse> createProject(
    proto.CreateProjectRequest request,
    Map<String, String> header,
  ) {
    if (request.userId.isEmpty) {
      throw BadRequest('Missing parameter: \'userId\'');
    }
    if (request.projectName.isEmpty) {
      throw BadRequest('Missing parameter: \'projectName\'');
    }
    return _fairProject.createProject(
        request.userId, request.projectName, request.templateProject);
  }

  Future<proto.DeleteProjectResponse> deleteProject(
    proto.DeleteProjectRequest request,
    Map<String, String> header,
  ) {
    if (request.userId.isEmpty) {
      throw BadRequest('Missing parameter: \'userId\'');
    }
    if (request.projectName.isEmpty) {
      throw BadRequest('Missing parameter: \'projectName\'');
    }
    return _fairProject.deleteProject(request.userId, request.projectName);
  }

  Future<proto.ExportProjectResponse> exportProject(
    proto.CommonRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairProject.exportProject(userId, projectName);
  }

  ///上传补丁
  Future<proto.UploadPluginResponse> uploadPlugin(
    proto.UploadPluginRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';
    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairProject.uploadPlugin(userId, projectName, request.appId,
        request.bundleName, request.patchUrl);
  }

  Future<proto.GetQrCodeResponse> getQrCode(
    proto.CommonRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairProject.getQrCode(userId, projectName);
  }

  ///包一层，统计接口耗时 & 检查导包
  Future<T> _perfLogAndRestart<T>(String source, Future<T> Function() body,
      String action, String errorDescription) async {
    try {
      final watch = Stopwatch()..start();
      final response = await body();
      log.info('PERF: Computed $action in ${watch.elapsedMilliseconds}ms.');
      return response;
    } catch (e, st) {
      log.severe(errorDescription, e, st);
      //todo shutdown & warmup
      // await _restart();
      rethrow;
    }
  }

  Future<proto.GetPageResponse> getPage(
    proto.GetPageRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairProject.getPage(userId, projectName, request.pagePath);
  }

  Future<proto.GetFairDslListResponse> getFairDslList(
    proto.CommonRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairProject.getFairDslList(userId, projectName);
  }

  Future<proto.GetFairDslResponse> getFairDsl(
    proto.GetFairDslRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';
    final pageName = request.pageName;
    final jsonPath = request.jsonPath;
    final jsPath = request.jsPath;

    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _fairProject.getFairDsl(
        userId, projectName, pageName, jsonPath, jsPath);
  }

  Future<proto.GetApiCallResponse> getApiCall(
    proto.CommonApiCallRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';
    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _apiCall.getAllApiCall(
      userId,
      projectName,
    );
  }

  Future<proto.CommonApiCallResponse> addApiCall(
    proto.CommonApiCallRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';
    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _apiCall.addApiCall(
      userId,
      projectName,
      apiInfo: request.api,
    );
  }

  Future<proto.CommonApiCallResponse> deleteApiCall(
    proto.CommonApiCallRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';
    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _apiCall.deleteApiCall(userId, projectName, apiInfo: request.api);
  }

//
  Future<proto.GetComponentListResponse> getComponentList(
    proto.GetComponentListRequest request,
    Map<String, String> header,
  ) {
    final userId = header['deviceId'] ?? '';
    final projectName = header['projectName'] ?? '';
    if (userId.isEmpty) {
      throw BadRequest('Empty header parameter: \'deviceId\'');
    }
    if (projectName.isEmpty) {
      throw BadRequest('Empty header parameter: \'projectName\'');
    }
    return _compoent.getComponentList(request);
  }
}

String _printCompileProblem(CompilationProblem problem) => problem.message;

String _hashSource(String str) {
  return sha1.convert(str.codeUnits).toString();
}
