library services.common_server_api;

import 'dart:async';
import 'dart:convert';

import 'package:protobuf/protobuf.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'common_server_impl.dart' show CommonServerImpl, BadRequest;
import 'protos/dart_services.pb.dart' as proto;

export 'common_server_impl.dart' show log, ServerContainer;

part 'common_server_api.g.dart'; // generated with 'pub run build_runner build'

const protobufContentType = 'application/x-protobuf';
const jsonContentType = 'application/json; charset=utf-8';
const protoApiUrlPrefix = '/service/api/dartservices/<apiVersion>';

class CommonServerApi {
  final CommonServerImpl _impl;

  CommonServerApi(this._impl);

  @Route.post('$protoApiUrlPrefix/analyze')
  Future<Response> analyze(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.SourceRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.SourceRequest.fromBuffer(bytes),
          transform: _impl.analyze);

  @Route.post('$protoApiUrlPrefix/compileDDC')
  Future<Response> compileDDC(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CompileDDCRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.CompileDDCRequest.fromBuffer(bytes),
          transform: _impl.compileDDC);

  @Route.post('$protoApiUrlPrefix/complete')
  Future<Response> complete(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.SourceRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.SourceRequest.fromBuffer(bytes),
          transform: _impl.complete);

  @Route.post('$protoApiUrlPrefix/fixes')
  Future<Response> fixes(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.SourceRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.SourceRequest.fromBuffer(bytes),
          transform: _impl.fixes);

  @Route.post('$protoApiUrlPrefix/assists')
  Future<Response> assists(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.SourceRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.SourceRequest.fromBuffer(bytes),
          transform: _impl.assists);

  @Route.post('$protoApiUrlPrefix/format')
  Future<Response> format(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.SourceRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.SourceRequest.fromBuffer(bytes),
          transform: _impl.format);

  @Route.post('$protoApiUrlPrefix/document')
  Future<Response> document(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.SourceRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.SourceRequest.fromBuffer(bytes),
          transform: _impl.document);

  @Route.post('$protoApiUrlPrefix/version')
  Future<Response> versionPost(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.VersionRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.VersionRequest.fromBuffer(bytes),
          transform: _impl.version);

  @Route.get('$protoApiUrlPrefix/version')
  Future<Response> versionGet(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.VersionRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.VersionRequest.fromBuffer(bytes),
          transform: _impl.version);

  @Route.post('$protoApiUrlPrefix/fairCompile')
  Future<Response> fairCompile(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CompileRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.CompileRequest.fromBuffer(bytes),
          transform: _impl.fairCompile);

  @Route.post('$protoApiUrlPrefix/fairRun')
  Future<Response> fairRun(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CompileRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.CompileRequest.fromBuffer(bytes),
          transform: _impl.fairRun);

  @Route.post('$protoApiUrlPrefix/getProjects')
  Future<Response> getProjects(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.GetProjectRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.GetProjectRequest.fromBuffer(bytes),
          transform: _impl.getProjects);

  @Route.post('$protoApiUrlPrefix/getProjectPages')
  Future<Response> getProjectPages(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.GetProjectPagesRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.GetProjectPagesRequest.fromBuffer(bytes),
          transform: _impl.getProjectPages);

  @Route.post('$protoApiUrlPrefix/createProjectPage')
  Future<Response> createProjectPage(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) => proto.CreateProjectPageRequest.create()
            ..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.CreateProjectPageRequest.fromBuffer(bytes),
          transform: _impl.createProjectPage);

  @Route.post('$protoApiUrlPrefix/deleteProjectPage')
  Future<Response> deleteProjectPage(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) => proto.DeleteProjectPageRequest.create()
            ..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.DeleteProjectPageRequest.fromBuffer(bytes),
          transform: _impl.deleteProjectPage);

  @Route.post('$protoApiUrlPrefix/copyProjectPage')
  Future<Response> copyProjectPage(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CopyPageRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.CopyPageRequest.fromBuffer(bytes),
          transform: _impl.copyProjectPage);

  //创建模板页面
  @Route.post('$protoApiUrlPrefix/createTemplatePage')
  Future<Response> createTemplatePage(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) => proto.CreateTemplatePageRequest.create()
            ..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.CreateTemplatePageRequest.fromBuffer(bytes),
          transform: _impl.createTemplatePage);

  //获取全部模板页面
  @Route.post('$protoApiUrlPrefix/getTemplatePages')
  Future<Response> getTemplatePages(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.GetTemplatePagesRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.GetTemplatePagesRequest.fromBuffer(bytes),
          transform: _impl.getTemplatePages);

  //获取自定义组件
  @Route.post('$protoApiUrlPrefix/getCustomComponents')
  Future<Response> getCustomComponents(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) => proto.GetCustomComponentsRequest.create()
            ..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.GetCustomComponentsRequest.fromBuffer(bytes),
          transform: _impl.getCustomComponents);

  //获取自定义组件
  @Route.post('$protoApiUrlPrefix/getCustomActions')
  Future<Response> getCustomActions(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.GetCustomActionsRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.GetCustomActionsRequest.fromBuffer(bytes),
          transform: _impl.getCustomActions);

  //获取依赖路径
  @Route.post('$protoApiUrlPrefix/getDependencyFilePath')
  Future<Response> getDependencyFilePath(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.DependencyPathRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.DependencyPathRequest.fromBuffer(bytes),
          transform: _impl.getDependencyFilePath);

  //更改依赖
  @Route.post('$protoApiUrlPrefix/changeDependency')
  Future<Response> changeDependency(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.ChangeDependencyRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.ChangeDependencyRequest.fromBuffer(bytes),
          transform: _impl.changeDependency);

  //更新pub get
  @Route.post('$protoApiUrlPrefix/doPubGet')
  Future<Response> doPubGet(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.DoPubGetRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.DoPubGetRequest.fromBuffer(bytes),
          transform: _impl.doPubGet);

  //删除自定义代码item
  @Route.post('$protoApiUrlPrefix/deleteCustomCodeItem')
  Future<Response> deleteCustomCodeItem(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) => proto.DeleteCustomCodeItemRequest.create()
            ..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.DeleteCustomCodeItemRequest.fromBuffer(bytes),
          transform: _impl.deleteCustomCodeItem);

  //创建自定义组件
  @Route.post('$protoApiUrlPrefix/createCustomComponent')
  Future<Response> createCustomComponent(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) => proto.CreateCustomComponentRequest.create()
            ..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.CreateCustomComponentRequest.fromBuffer(bytes),
          transform: _impl.createCustomComponent);

  //创建自定义Action
  @Route.post('$protoApiUrlPrefix/createCustomAction')
  Future<Response> createCustomAction(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) => proto.CreateCustomActionRequest.create()
            ..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.CreateCustomActionRequest.fromBuffer(bytes),
          transform: _impl.createCustomAction);

  @Route.post('$protoApiUrlPrefix/getTemplateProjects')
  Future<Response> getTemplateProjects(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.GetProjectRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.GetProjectRequest.fromBuffer(bytes),
          transform: _impl.getTemplateProjects);

  @Route.post('$protoApiUrlPrefix/createProject')
  Future<Response> createProject(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CreateProjectRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.CreateProjectRequest.fromBuffer(bytes),
          transform: _impl.createProject);

  @Route.post('$protoApiUrlPrefix/deleteProject')
  Future<Response> deleteProject(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.DeleteProjectRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.DeleteProjectRequest.fromBuffer(bytes),
          transform: _impl.deleteProject);

  @Route.post('$protoApiUrlPrefix/getPage')
  Future<Response> getPage(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.GetPageRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.GetPageRequest.fromBuffer(bytes),
          transform: _impl.getPage);

  @Route.post('$protoApiUrlPrefix/getFairDslList')
  Future<Response> getFairDslList(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CommonRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.CommonRequest.fromBuffer(bytes),
          transform: _impl.getFairDslList);

  @Route.post('$protoApiUrlPrefix/getFairDsl')
  Future<Response> getFairDsl(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.GetFairDslRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.GetFairDslRequest.fromBuffer(bytes),
          transform: _impl.getFairDsl);

  @Route.post('$protoApiUrlPrefix/getApiCall')
  Future<Response> getApiCall(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CommonApiCallRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.CommonApiCallRequest.fromBuffer(bytes),
          transform: _impl.getApiCall);

  @Route.post('$protoApiUrlPrefix/addApiCall')
  Future<Response> addApiCall(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CommonApiCallRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.CommonApiCallRequest.fromBuffer(bytes),
          transform: _impl.addApiCall);

  @Route.post('$protoApiUrlPrefix/deleteApiCall')
  Future<Response> deleteApiCall(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CommonApiCallRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.CommonApiCallRequest.fromBuffer(bytes),
          transform: _impl.deleteApiCall);

  @Route.post('$protoApiUrlPrefix/getComponentList')
  Future<Response> getComponentList(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.GetComponentListRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.GetComponentListRequest.fromBuffer(bytes),
          transform: _impl.getComponentList);

  @Route.post('$protoApiUrlPrefix/exportProject')
  Future<Response> exportProject(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CommonRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.CommonRequest.fromBuffer(bytes),
          transform: _impl.exportProject);

  @Route.post('$protoApiUrlPrefix/getQrCode')
  Future<Response> getQrCode(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.CommonRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) => proto.CommonRequest.fromBuffer(bytes),
          transform: _impl.getQrCode);

  @Route.post('$protoApiUrlPrefix/uploadPlugin')
  Future<Response> uploadPlugin(Request request, String apiVersion) =>
      _processRequest(request,
          decodeFromJSON: (json) =>
              proto.UploadPluginRequest.create()..mergeFromProto3Json(json),
          decodeFromProto: (bytes) =>
              proto.UploadPluginRequest.fromBuffer(bytes),
          transform: _impl.uploadPlugin);

  Router get router => _$CommonServerApiRouter(this);

  // We are serving requests that are arriving in both Protobuf binary encoding,
  // and Protobuf JSON encoding. To handle this we need the ability to decode
  // the requests and encode the responses. We also need to know how to do the
  // work the request is requesting.

  Future<Response> _processRequest<I, O extends GeneratedMessage>(
    Request request, {
    required I Function(List<int> bytes) decodeFromProto,
    required I Function(Object json) decodeFromJSON,
    required Future<O> Function(I input, Map<String, String> header) transform,
  }) async {
    if (request.mimeType == protobufContentType) {
      // Dealing with binary Protobufs
      final body = <int>[];
      await for (final chunk in request.read()) {
        body.addAll(chunk);
      }
      try {
        final response =
            await transform(decodeFromProto(body), request.headers);
        return Response.ok(
          response.writeToBuffer(),
          headers: _protobufHeaders,
        );
      } on BadRequest catch (e) {
        return Response(400,
            headers: _protobufHeaders,
            body: (proto.BadRequest.create()
                  ..error = (proto.ErrorMessage.create()..message = e.cause))
                .writeToBuffer());
      }
    } else {
      // Dealing with JSON encoded Protobufs
      final body = await request.readAsString();
      try {
        final response = await transform(
            decodeFromJSON(body.isNotEmpty ? json.decode(body) as Object : {}),
            request.headers);
        return Response.ok(
          _jsonEncoder.convert(response.toProto3Json()),
          encoding: utf8,
          headers: _jsonHeaders,
        );
      } on BadRequest catch (e) {
        return Response(400,
            headers: _jsonHeaders,
            encoding: utf8,
            body: _jsonEncoder.convert((proto.BadRequest.create()
                  ..error = (proto.ErrorMessage.create()..message = e.cause))
                .toProto3Json()));
      }
    }
  }

  final JsonEncoder _jsonEncoder = const JsonEncoder.withIndent(' ');

  static const _jsonHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Content-Type': jsonContentType
  };

  static const _protobufHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Content-Type': protobufContentType
  };
}
