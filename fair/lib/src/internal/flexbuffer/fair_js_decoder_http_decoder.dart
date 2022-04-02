/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

///用户如需自定义接入网络下载模块，实现该类即可
abstract class HttpDecoder {
  Future<dynamic> encode();

  Future<dynamic> decode(String? url);
}

String _toString(Uint8List data) {
  return utf8.decode(data);
}

const BYTES_LIMIT = 10 * 1024;
const STRING_LIMIT = 10 * 1024 / 8;

///默认JS网络下载，只支持GET请求，如果需要切换业务场景，请自定义
class DefaultHttpDecoder implements HttpDecoder {
  Client client;

  DefaultHttpDecoder() {
    client = http.Client();
  }

  @override
  Future<dynamic> decode(String url) async {
    var start = DateTime.now().millisecondsSinceEpoch;
    var response = await client.get(url);
    var end = DateTime.now().millisecondsSinceEpoch;
    print('end1 ${end - start}');
    if (response.statusCode != 200) {
      throw FlutterError(
          '加载JS网络路径Code =${response.statusCode},RemoteUrl: $url');
    }

    var end2 = DateTime.now().millisecondsSinceEpoch;
    print('end ${end2 - start}');
    var data = response.bodyBytes;
    if (data == null) {
      throw FlutterError('bodyBytes=null, RemoteUrl : $url');
    }
    //解析字节流
    return _resolveResult(data);
  }

  Future<String> _resolveResult(dynamic data) async {
    String result;
    if (data is Uint8List) {
      if (data.lengthInBytes < BYTES_LIMIT) {
        result = utf8.decode(data);
      } else {
        result = await compute(_toString, data, debugLabel: 'json decode');
      }
    } else {
      result = data as String;
    }
    return result;
  }

  @override
  Future<dynamic> encode() async {}
}
