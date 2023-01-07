import 'dart:io';
import 'package:dio/dio.dart';

enum HttpMethod {
  GET,
  PUT,
  POST,
  PATCH,
  DELETE,
  UPLOAD,
}

class HttpUtil {
  static Dio? _dioInstance;
  static Dio getDioInstance() {
    if (_dioInstance == null) {
      _dioInstance = Dio();
    }
    return _dioInstance!;
  }

  static Future get(String url,
      {Map<String, dynamic>? queryParams, CancelToken? cancelToken}) async {
    return await sendRequest(HttpMethod.GET, url,
        queryParams: queryParams, cancelToken: cancelToken);
  }

  static Future put(String url,
      {Map<String, dynamic>? queryParams, dynamic data}) async {
    return await sendRequest(HttpMethod.PUT, url,
        queryParams: queryParams, data: data);
  }

  static Future post(String url,
      {Map<String, dynamic>? queryParams,
        dynamic data,
        CancelToken? cancelToken}) async {
    return await sendRequest(HttpMethod.POST, url,
        queryParams: queryParams, data: data, cancelToken: cancelToken);
  }

  static Future patch(String url,
      {Map<String, dynamic>? queryParams, dynamic data}) async {
    return await sendRequest(HttpMethod.PATCH, url,
        queryParams: queryParams, data: data);
  }

  static Future delete(String url,
      {Map<String, dynamic>? queryParams, dynamic data}) async {
    return await sendRequest(HttpMethod.DELETE, url,
        queryParams: queryParams, data: data);
  }

  static Future uploadSingle(String url, String fileKey, File file,
      {Map<String, dynamic>? queryParams}) async {
    FormData formData = FormData.fromMap({
      fileKey: await MultipartFile.fromFile(file.path),
    });
    return await sendRequest(HttpMethod.POST, url,
        queryParams: queryParams, data: formData);
  }

  static Future download(
      String url,
      String savePath, {
        Map<String, dynamic>? queryParams,
        CancelToken? cancelToken,
        dynamic data,
        Options? options,
        void Function(int, int)? onReceiveProgress,
      }) async {
    try {
      return await _dioInstance?.download(
        url,
        savePath,
        queryParameters: queryParams,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        //取消下载
      } else {
        if (e.response != null) {
          //处理异常
        } else {
          //TODO
        }
      }
    } on Exception catch (e) {
      //TODO
    }
  }

  static Future sendRequest(HttpMethod method, String url,
      {Map<String, dynamic>? queryParams,
        dynamic data,
        CancelToken? cancelToken}) async {
    try {
      switch (method) {
        case HttpMethod.GET:
          return await HttpUtil.getDioInstance()
              .get(url, queryParameters: queryParams, cancelToken: cancelToken);
        case HttpMethod.PUT:
          return await HttpUtil.getDioInstance().put(url,
              queryParameters: queryParams,
              data: data,
              cancelToken: cancelToken);
        case HttpMethod.POST:
          return await HttpUtil.getDioInstance().post(url,
              queryParameters: queryParams,
              data: data,
              cancelToken: cancelToken);
        case HttpMethod.PATCH:
          return await HttpUtil.getDioInstance().patch(url,
              queryParameters: queryParams,
              data: data,
              cancelToken: cancelToken);
        case HttpMethod.DELETE:
          return await HttpUtil.getDioInstance().delete(url,
              queryParameters: queryParams,
              data: data,
              cancelToken: cancelToken);
        default:

      }
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {

      } else {
        if (e.response != null) {

        } else {

        }
      }
    } on Exception catch (e) {

    }

    return null;
  }
}