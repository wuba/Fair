import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fair/fair.dart';

/// 网络请求示例，可根据自身业务场景定制
class FairNet extends IFairPlugin {
  static final FairNet _fairNet = FairNet._internal();

  FairNet._internal();

  factory FairNet() {
    return _fairNet;
  }

  Future<dynamic> doRequest(dynamic map) async {
    log('===================doRequest');
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
      print('resp ${response?.data.runtimeType.toString()}');
      return Future.value(jsonEncode(resp));
    }
  }

  Future<Response<dynamic>> _post(String path,
      {Map<String, dynamic>? queryParameters}) async {
    var resp = await _getDio().post(path, queryParameters: queryParameters);
    return Future.delayed(Duration(seconds: 0),()=> resp);
  }

  Future<Response<dynamic>> _get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    var resp = await _getDio().get(path, queryParameters: queryParameters);
    return Future.delayed(Duration(seconds: 0),()=> resp);
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('doRequest', () => doRequest);
    return functions;
  }

  Dio? _dio;

  Dio _getDio() {
    _dio ??= Dio();
    return _dio!;
  }
}
