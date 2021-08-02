/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fair/fair.dart';

/// 网络请求自定义插件,是否考虑通过注解标识出来
class FairNet extends IFairPlugin {
  static final FairNet _fairNet = FairNet._internal();

  FairNet._internal();

  factory FairNet() {
    return _fairNet;
  }

  Dio _dio;

  Dio _getDio() {
    _dio ??= Dio();
    return _dio;
  }

  //处理来自js的网络请求
  dynamic _jsRequest(par) async {
    print('FairNet.request$par');
    var requestPar = jsonDecode(par);
    var args = requestPar['args'];
    var pageName = requestPar['pageName'];
    var method = args['method'];
    var url = args['url'];
    var id = requestPar['id'];

    Response<String> response;

    if ('GET' == method) {
      response = await _getDio().get<String>(url);
    } else if ('POST' == method) {
      response = await _getDio().post<String>(url);
    }

    print('FairNet.request.result:${response?.statusCode}');

    var responseMap = {
      'id': id,
      'pageName': pageName,
      'statusCode': response?.statusCode,
      'data': response?.data,
      'statusMessage': response?.statusMessage
    };

    return Future.value(jsonEncode(responseMap));
  }

  /// dart 端的网络请求
  /// par 请求参数，map对象
  void request(par) {
    if (par == null) {
      return;
    }

    var completeCallback = par['complete'];
    var errorCallback = par['error'];
    var successCallback = par['success'];
    var method = par['method'];
    String url = par['url'];
    var header = par['header'];
    Map<String, dynamic> req = par['data'];

    if (url == null || url.isEmpty) {
      return;
    }

    if ('GET' == method) {
      _get(url, queryParameters: req).then((value) {
        //获取结果成功
        if (200 == value?.statusCode) {
          if (successCallback != null) {
            Function.apply(successCallback, [value?.data]);
          }

          if (completeCallback != null) {
            Function.apply(completeCallback, null);
          }
        } else {
          //返回值根据实际需要返回相关的数据
          if (errorCallback != null)
            Function.apply(errorCallback, [value?.data]);

          if (completeCallback != null) Function.apply(completeCallback, null);
        }
      });
    } else if ('POST' == method) {
      //根据实际需要修改
      _post(url, queryParameters: req).then((value) {
        //获取结果成功
        if (200 == value?.statusCode) {
          if (completeCallback != null) {
            if (successCallback != null) {
              Function.apply(successCallback, [value?.data]);
            }

            if (completeCallback != null) {
              Function.apply(completeCallback, null);
            }
          }
        } else {
          //返回值根据实际需要返回相关的数据
          if (errorCallback != null)
            Function.apply(errorCallback, [value?.data]);

          if (completeCallback != null) Function.apply(completeCallback, null);
        }
      });
    } else {
      //no-op
    }
  }

  Future<Response<dynamic>> _post(String path,
      {Map<String, dynamic> queryParameters}) async {
    var resp = await _getDio().post(path, queryParameters: queryParameters);
    return Future.value(resp);
  }

  Future<Response<dynamic>> _get(String path,
      {Map<String, dynamic> queryParameters}) async {
    var resp = await _getDio().get(path, queryParameters: queryParameters);
    return Future.value(resp);
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('request', () => _jsRequest);
    return functions;
  }
}
