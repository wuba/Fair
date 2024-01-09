import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fair/fair.dart';

mixin FairHttpPlugin implements FairCommonPluginMixin {
  Future<dynamic> http(dynamic map) => request(map, _run);

  Future<Map?> _run(Map requestMap) async {
    // implements http here.
    final method = requestMap['method'];
    final url = requestMap['url'];
    Response<String>? result;
    switch (method) {
      case 'GET':
        result = await _get(url);
        break;
      case 'POST':
        result = await _post(url);
        break;
      default:
    }
    if (result != null) {
      return {
        'data': result.data == null ? '' : jsonDecode(result.data!),
        'statusCode': result.statusCode,
      };
    }
    return null;
  }

  static Future<Response<String>> _post(String path,
      {Map<String, String>? queryParameters}) async {
    var resp =
        await _getDio().post<String>(path, queryParameters: queryParameters);
    return Future.value(resp);
  }

  static Future<Response<String>> _get(String path,
      {Map<String, String>? queryParameters}) async {
    var resp =
        await _getDio().get<String>(path, queryParameters: queryParameters);
    return Future.value(resp);
  }

  static Dio? _dio;

  static Dio _getDio() {
    _dio ??= Dio();
    return _dio!;
  }
}
