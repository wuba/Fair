import 'dart:convert';

///api call dio 请求模版
String dioTemplate(
        {required String name,
        required String method,
        required String url,
        required Map params}) =>
    '''
import 'package:dio/dio.dart';

//$name#$method#$url#${json.encode(params)}#
Future<String> $name() async {
  var dio = Dio();
  final response = await dio.${method.toLowerCase()}<String>('$url',${method.toLowerCase() == 'get' ? 'queryParameters:${json.encode(params)}' : 'data:${json.encode(params)}'});
  return response.data ?? '';
}
''';
