/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import '../utils.dart';

Map _jsonDecode(String data) {
  return jsonDecode(data);
}

Map _jsonUtf8Decode(Uint8List data) {
  return jsonDecode(utf8.decode(data));
}

Map _flexDecode(Uint8List data) {
  return FairUtils.flex2Map(data);
}

const BYTES_LIMIT = 10 * 1024;
const STRING_LIMIT = 10 * 1024 / 8;

class FairDecoder {
  _FlexDecode _flexDecode;
  _JsonDecode _jsonDecode;

  /// Decode stream/string as bundle map
  ///
  /// [stream] Uint8List or String instance
  /// [bin] if format is binary, [stream] can only be Uint8List
  Future<Map> decode(dynamic stream, bool bin) {
    assert(
        (bin == true && stream is Uint8List) ||
            (bin == false && (stream is Uint8List || stream is String)),
        'stream should be Uint8List or String');
    _DecodeInterface d =
        bin ? (_flexDecode ??= _FlexDecode()) : (_jsonDecode ??= _JsonDecode());
    return d.decode(stream);
  }
}

// https://google.github.io/flatbuffers/flatbuffers_internals.html
abstract class _DecodeInterface<T> {
  Future<Map> decode(T bytesOrString);
}

class _FlexDecode extends _DecodeInterface<Uint8List> {
  @override
  Future<Map> decode(Uint8List bytes) async {
    Map map;
    if (bytes.lengthInBytes < BYTES_LIMIT) {
      map = FairUtils.flex2Map(bytes);
    } else {
      map = await compute(_flexDecode, bytes, debugLabel: 'flex decode');
    }
    return map;
  }
}

class _JsonDecode extends _DecodeInterface<dynamic> {
  @override
  Future<Map> decode(dynamic data) async {
    Map map;
    if (data is Uint8List) {
      if (data.lengthInBytes < BYTES_LIMIT) {
        map = _jsonUtf8Decode(data);
      } else {
        map = await compute(_jsonUtf8Decode, data, debugLabel: 'json decode');
      }
    } else {
      var string = data as String;
      if (string.length < STRING_LIMIT) {
        map = jsonDecode(string);
      } else {
        map = await compute(_jsonDecode, string, debugLabel: 'json decode');
      }
    }
    return map;
  }
}
