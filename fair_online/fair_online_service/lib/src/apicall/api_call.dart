import 'dart:convert';
import 'dart:io';
import 'package:fair_online_service/src/apicall/dio_sample.dart';
import 'package:path/path.dart' as path;
import 'package:logging/logging.dart';
import 'package:fair_online_service/src/protos/dart_services.pb.dart';
import 'package:tuple/tuple.dart';

final Logger log = Logger('api_call');

class ApiCall {
  String get _userProjectPath =>
      path.join(Directory.current.path, 'fairDir', 'userProject');

  ///获取所有api
  Future<GetApiCallResponse> getAllApiCall(
    String user,
    String projectName,
  ) async {
    try {
      final apiDir = _validateApiDir(user, projectName);
      //过滤一下目录
      final apis = apiDir.item2
          .listSync()
          .where((api) => api.statSync().type == FileSystemEntityType.file);
      return GetApiCallResponse(
          api: apis.map((api) {
        final apiFile = File(api.path);
        //这里读出来的应该是json
        final apiContent = apiFile.readAsStringSync();
        if (apiContent.isNotEmpty) {
          return ApiCallInfo.fromJson(apiContent);
        }
        return ApiCallInfo(params: {})
          ..name = ''
          ..method = ''
          ..url = '';
      }).toList());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  ///添加api call
  Future<CommonApiCallResponse> addApiCall(
    String user,
    String projectName, {
    required ApiCallInfo apiInfo,
  }) async {
    try {
      final result = CommonApiCallResponse();
      final apiDir = _validateApiDir(user, projectName);
      final apiTarget = path.join(apiDir.item1.path, apiInfo.name + '.dart');
      final apiJsonTarget =
          path.join(apiDir.item2.path, apiInfo.name + '.json');
      final apiTargetFile = File(apiTarget);
      final apiJsonTargetFile = File(apiJsonTarget);
      if (apiTargetFile.existsSync() || apiJsonTargetFile.existsSync()) {
        return result..error = ErrorMessage(message: "Api已存在，添加失败");
      }

      //写.dart文件
      apiTargetFile
        ..createSync(recursive: true)
        ..writeAsStringSync(dioTemplate(
          name: apiInfo.name,
          url: apiInfo.url,
          method: apiInfo.method,
          params: {
            for (var tuple in _convert2Tuple3(apiInfo.params))
              tuple.item1: _getValueByDartType(tuple.item2, tuple.item3)
          },
        ));

      //apiInfo.toProto3Json()是正常的json，writeToJson是protobuf解析需要的json
      //写.json文件
      apiJsonTargetFile
        ..createSync(recursive: true)
        ..writeAsStringSync(apiInfo.writeToJson());

      return result;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  ///添加api call
  Future<CommonApiCallResponse> deleteApiCall(
    String user,
    String projectName, {
    required ApiCallInfo apiInfo,
  }) async {
    try {
      final apiDir = _validateApiDir(user, projectName);
      final apiTarget = path.join(apiDir.item1.path, apiInfo.name + '.dart');
      final apiJsonTarget =
          path.join(apiDir.item2.path, apiInfo.name + '.json');
      final apiTargetFile = File(apiTarget);
      final apiJsonTargetFile = File(apiJsonTarget);
      final result = CommonApiCallResponse();
      if (apiTargetFile.existsSync()) {
        apiTargetFile.deleteSync(recursive: true);
        if (apiJsonTargetFile.existsSync()) {
          apiJsonTargetFile.deleteSync(recursive: true);
        }
        return result;
      } else {
        return result..error = ErrorMessage(message: "Api不存在，删除失败");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  ///校验目录
  Tuple2<Directory, Directory> _validateApiDir(
      String user, String projectName) {
    final apiDirPath =
        path.join(_userProjectPath, user, projectName, 'lib', 'api');
    final apiDir = Directory(apiDirPath);
    final jsonDirPath = path.join(apiDirPath, 'json');
    final jsonDir = Directory(jsonDirPath);
    if (!jsonDir.existsSync()) {
      jsonDir.createSync(recursive: true);
    }
    return Tuple2(apiDir, jsonDir);
  }

  ///将list转换成tuple好处理
  ///[[key,type,value],[key,type,value]....] => [Tuple3,Tuple3....]
  List<Tuple3<String, String, String>> _convert2Tuple3(
          List<ApiCallParamsInfo> rawList) =>
      rawList
          .map((param) => Tuple3<String, String, String>(
              param.key, param.type, param.value))
          .toList();

  ///类型转换
  dynamic _getValueByDartType(String type, String value) {
    switch (type) {
      case 'String':
        return value;
      case 'double':
        return double.parse(value);
      case 'int':
        return int.parse(value);
      case 'bool':
        return value == 'true';
      default:
        return null;
    }
  }
}
