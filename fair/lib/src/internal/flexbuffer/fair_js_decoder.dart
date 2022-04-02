/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'package:fair/src/internal/flexbuffer/fair_js_decoder_http_decoder.dart';
import 'package:flutter/services.dart';

class FairJSFairJSDecoderHelper {
  ///提取JS加载地址，assert or http
  static String? transformPath(String? beforePath) {
    if (beforePath == null) {
      // throw FlutterError('');
      return beforePath;
    }
    if (beforePath.startsWith('http')) {
      return beforePath;
    } else {
      //加载其它路径判断待定
      return beforePath.substring(0, beforePath.lastIndexOf('.')) + '.js';
    }
  }
}

///JS资源解析器
class FairJSDecoder {
  FairJSDecoder._internal();

  static final FairJSDecoder _fairJSDecoder = FairJSDecoder._internal();

  factory FairJSDecoder({HttpDecoder? decoder}) {
    _httpDecoder = decoder ?? DefaultHttpDecoder();
    return _fairJSDecoder;
  }

  static HttpDecoder? _httpDecoder;

  Future<String> _resolve(String? path) async {
    if (path?.startsWith('http')==true) {
      return await _resolveHttp(path);
    } else {
      //10kb以上资源，会通过isolate的方式去实现，无需额外去操作
      //10KB takes about 3ms to parse on a Pixel 2 XL.
      return _resolveAssert(path);
    }
  }

  /*
   *解析assert
   */
  Future<String> _resolveAssert(String? assertPath) async =>
      rootBundle.loadString(assertPath??'');

  /*
   * 解析Http资源,需要用户自定义自己的解析器
   */
  Future<String> _resolveHttp(String? url) async =>
      await _httpDecoder?.decode(url);

  Future<String> decode(String? jsPath) => _resolve(jsPath);
}
