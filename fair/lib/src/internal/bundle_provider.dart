/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../app.dart';
import '../type.dart';
import 'fair_decoder.dart';
import 'global_state.dart';

class FairBundle {
  BundleLoader? _provider;

  BundleLoader obtain(BuildContext context) {
    _provider ??= FairApp.of(context)?.bundleProvider ?? _DefaultProvider();
    return _provider!;
  }
}

mixin FairBundlePathCheck {

  bool isExternalStoragePath(String? originPath) {
    if (originPath == null) {
      return false;
    }

    var file = File(originPath);
    if (file.existsSync()) {
      return true;
    } else {
      return false;
    }
  }
}

class _DefaultProvider extends BundleLoader with FairBundlePathCheck{
  var client = http.Client();
  static const JSON = '.json';
  static const FLEX = '.bin';

  @override
  Future<Map?> onLoad(String? path, FairDecoder decoder,
      {bool cache = true, Map<String, String>? h}) {
    bool isFlexBuffer;
    if (path?.endsWith(FLEX)==true) {
      isFlexBuffer = true;
    } else if (path?.endsWith(JSON)==true) {
      isFlexBuffer = false;
    } else {
      throw ArgumentError(
          'unknown format, please use either $JSON or $FLEX;\n $path');
    }

    if (path?.startsWith('http') == true) {
      return _http(path, isFlexBuffer, headers: h, decode: decoder);
    }

    /// iOS 平台无论是 assets 资源还是磁盘资源统一使用 _asset 加载
    if (Platform.isIOS) {
      return _asset(path, isFlexBuffer, cache: cache, decode: decoder);
    }

    if (path != null && isExternalStoragePath(path)) {
      return _externalStorageDirectory(path, isFlexBuffer,
          cache: cache, decode: decoder);
    } else {
      return _asset(path, isFlexBuffer, cache: cache, decode: decoder);
    }
  }

  Future<Map?> _externalStorageDirectory(String key, bool isFlexBuffer,
      {bool cache = true, FairDecoder? decode}) async {
    var file = File(key);
    var watch = Stopwatch()..start();
    int? end, end2;
    Map? map;

    if (isFlexBuffer) {
      var data = await file.readAsBytes();
      end = watch.elapsedMilliseconds;
      map = await decode?.decode(data, isFlexBuffer);
      end2 = watch.elapsedMilliseconds;
    } else {
      var data = await file.readAsString();
      end = watch.elapsedMilliseconds;
      map = await decode?.decode(data, isFlexBuffer);
      end2 = watch.elapsedMilliseconds;
    }

    log('[Fair] $key load: $end ms, stream decode: $end2 ms');
    return map;
  }

  Future<Map?> _asset(String? key, bool isFlexBuffer,
      {bool cache = true, FairDecoder? decode}) async {
    var watch = Stopwatch()..start();
    int? end, end2;
    Map? map;
    if (isFlexBuffer) {
      var data = await rootBundle.load(key??'');
      end = watch.elapsedMilliseconds;
      map = await decode?.decode(data.buffer.asUint8List(), isFlexBuffer);
      end2 = watch.elapsedMilliseconds;
    } else {
      var data = await rootBundle.loadString(key??'', cache: cache);
      end = watch.elapsedMilliseconds;
      map = await decode?.decode(data, isFlexBuffer);
      end2 = watch.elapsedMilliseconds;
    }

    log('[Fair] $key load: $end ms, stream decode: $end2 ms');
    return map;
  }

  Future<Map?> _http(String? url, bool isFlexBuffer,
      {Map<String, String>? headers, FairDecoder? decode}) async {
    var start = DateTime.now().millisecondsSinceEpoch;
    var response = await client.get(Uri.parse(url??''), headers: headers);
    var end = DateTime.now().millisecondsSinceEpoch;
    if (response.statusCode != 200) {
      throw FlutterError('code=${response.statusCode}, unable to load : $url');
    }
    var data = response.bodyBytes;
    // if (data == null) {
    //   throw FlutterError('bodyBytes=null, unable to load : $url');
    // }
    var map = await decode?.decode(data, isFlexBuffer);
    var end2 = DateTime.now().millisecondsSinceEpoch;
    log('[Fair] load $url, time: ${end - start} ms, json parsing time: ${end2 - end} ms');
    return map;
  }
}
