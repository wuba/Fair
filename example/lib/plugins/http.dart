import 'package:dio/dio.dart';
import 'package:fair/fair.dart';

mixin HttpPlugin implements FairCommonPluginMixin {
  Future<dynamic> http(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          final method = requestMap['method'];
          final url = requestMap['url'];
          // final headers = requestMap['headers'];
          final data = requestMap['data'];
          Response<dynamic>? response;
          switch (method) {
            case 'GET':
              response = await _get(url, queryParameters: data);
              break;
            case 'POST':
              response = await _post(url, queryParameters: data);
              break;
          }
          return response?.data;
        },
      );

  Future<Response<dynamic>> _post(String path,
      {Map<String, dynamic>? queryParameters}) async {
    var resp = await _getDio().post(path, queryParameters: queryParameters);
    return Future.value(resp);
  }

  Future<Response<dynamic>> _get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    var resp = await _getDio().get(path, queryParameters: queryParameters);
    return Future.value(resp);
  }

  Dio? _dio;

  Dio _getDio() {
    _dio ??= Dio();
    return _dio!;
  }
}
