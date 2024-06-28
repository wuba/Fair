// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:fair/src/internal/bundle_provider.dart';
import 'package:flutter/services.dart';

Map<String?, String> _cache = <String?, String>{};

/// 自定义 js 获取方式
class CustomFairJSDecoder with FairBundlePathCheck {
  factory CustomFairJSDecoder() => _customFairJSDecoder;
  CustomFairJSDecoder._();
  static final CustomFairJSDecoder _customFairJSDecoder =
      CustomFairJSDecoder._();

  /// 自定义 js 获取方式
  Future<String> decode(String? jsPath) async {
    //
    // var byteData = null;
    // 根据自身的情况来，这个也可能从其他地方获取
    //
    // if (byteData != null) {
    //  return _cache[jsPath] ??= utf8.decode(byteData);
    // }

    return _cache[jsPath] ??= await _resolveAssert(jsPath);
  }

  Future<String> _resolveAssert(String? assertPath) async {
    if (isExternalStoragePath(assertPath)) {
      final file = File(assertPath ?? '');
      return await file.readAsString();
    }
    return rootBundle.loadString(assertPath ?? '');
  }
}
