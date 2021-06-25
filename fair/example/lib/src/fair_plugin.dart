import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fair/fair.dart';

//todo 网络请求
class FairNet extends IFairPlugin {
  FairNet() {
    registerMethod('request', request);
  }

  @override
  dynamic invoke(dynamic par) => Function.apply(c[getMethodName(par)], [par]);

  dynamic request(par) async {
    print('FairNet.request$par');
    var requestPar = jsonDecode(par);
    var args = requestPar['args'];
    var pageName = requestPar['pageName'];
    var method = args['method'];
    var url = args['url'];
    var id = args['id'];

    Response<String> response;
    if ('GET' == method) {
      response = await _getDio().get<String>(url);
    } else if ('POST' == method) {
      response = await _getDio().get<String>(url);
    }

    print('FairNet.request.result:${response?.statusCode}');
    // response?.statusCode
    //请求成功
    // if (response?.statusCode == 200) {
    //
    // }

    var responseMap = {
      'id': id,
      'pageName': pageName,
      'statusCode': response?.statusCode,
      'data': response?.data,
      'statusMessage': response?.statusMessage
    };

    return Future.value(jsonEncode(responseMap));
  }

  Dio _dio;

  Dio _getDio() {
    _dio ??= Dio();
    return _dio;
  }
}
