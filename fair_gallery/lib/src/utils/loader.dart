// ignore_for_file: implementation_imports

import 'package:fair/src/internal/fair_decoder.dart';

import 'package:fair/src/internal/bundle_provider.dart';

Map<String?, Map?> _cache = <String?, Map?>{};

class CustomFairBundleLoader extends FairBundleProvider {
  @override
  Future<Map?> onLoad(
    String? path,
    FairDecoder decoder, {
    bool cache = true,
    Map<String, String>? h,
  }) async {
    //
    // var byteData = null;
    // if (byteData != null) {
    //   //
    // }
    // else
    // {
    // 根据自身的情况来，这个也可能从其他地方获取
    // 缓存的是 path 对应的 map
    return _cache[path] ??= await super.onLoad(
      path,
      decoder,
      cache: cache,
      h: h,
    );
  }
  //}
}
