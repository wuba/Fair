import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fair/fair.dart';

/// 网络请求
class FairNet extends IFairPlugin {
  static final FairNet _fairNet = FairNet._internal();

  static const GET = 'GET';
  static const POST = 'POST';

  FairNet._internal();

  factory FairNet() {
    return _fairNet;
  }

  static Future<dynamic> requestData(
      {required String method,
      required String url,
      Map? data,
      void Function()? complete,
      void Function(Map resp)? success,
      void Function(String msg)? failure}) async {
    // 空实现，仅用dart端占位（实现见fair_net_plugin.js）
  }

  static Future<dynamic> _request(dynamic map) async {
    if (map == null) {
      return;
    }
    var req;
    bool isDart;
    if (map is Map) {
      isDart = true;
      req = map;
    } else {
      isDart = false;
      req = jsonDecode(map);
    }
    var pageName = req['pageName'];
    var args = req['args'];
    if (isDart) {
      args = req;
    }

    var url = args['url'];
    var callId = args['callId'];
    var successCallback = args['success'];
    var failureCallback = args['failure'];
    var completeCallback = args['complete'];
    Map<String, dynamic> reqData = args['data'];
    var method = args['method'];
    Response<dynamic>? response;

    if (method == null) {
      return Future.value();
    }

    switch (method) {
      case 'GET':
        response = await _get(url, queryParameters: reqData);
        break;
      case 'POST':
        response = await _post(url, queryParameters: reqData);
        break;
    }

    var statusCode = response?.statusCode;
    var data = response?.data;
    var statusMessage = response?.statusMessage;

    /// 需要判断发起方的请求是dart端还是js端
    if (isDart) {
      /// 实际处理结合自身app的业务逻辑场景
      if (200 == statusCode) {
        successCallback?.call(data);
        completeCallback?.call();
      } else {
        failureCallback?.call(statusMessage);
        completeCallback?.call();
      }
      return Future.value();
    } else {
      var resp = {
        'callId': callId,
        'pageName': pageName,
        'statusCode': response?.statusCode,
        'data': response?.data,
        'statusMessage': response?.statusMessage,
      };
      return Future.value(jsonEncode(resp));
    }
  }

  static Future<Response<dynamic>> _post(String path,
      {Map<String, dynamic>? queryParameters}) async {
    var resp = await _getDio().post(path, queryParameters: queryParameters);
    return Future.value(resp);
  }

  static Future<Response<dynamic>> _get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    var resp = await _getDio().get(path, queryParameters: queryParameters);
    return Future.value(resp);
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('requestData', () => _request);
    return functions;
  }

  static Dio? _dio;

  static Dio _getDio() {
    _dio ??= Dio();
    return _dio!;
  }
}
