/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'internal/fair_bundle_generated.dart';
import 'internal/flexbuffer/reference.dart';
import 'internal/global_state.dart';

class FairUtils {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    if (hexString[0] == '#') {
      buffer.write(hexString.replaceFirst('#', ''));
    } else if (hexString.startsWith('0x')) {
      buffer.write(hexString.replaceFirst('0x', ''));
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Map flex2Map(Uint8List bytes) {
    var watch = Stopwatch()..start();
    var widgetData = WidgetData(bytes);
    var end1 = watch.elapsedMilliseconds;
    var map = <String, dynamic>{};
    map['className'] = widgetData.className;

    if (widgetData.data != null) {
      map['data'] =
          serializeReference(Reference.fromBuffer(_b(widgetData.data)));
    }

    if (widgetData.pa != null) {
      map['pa'] = serializeReference(Reference.fromBuffer(_b(widgetData.pa)));
    }
    if (widgetData.na != null) {
      map['na'] = serializeReference(Reference.fromBuffer(_b(widgetData.na)));
    }

    if (widgetData.methodMap != null) {
      map['methodMap'] = serializeReference(Reference.fromBuffer(_b(widgetData.methodMap)));
    }
    var end2 = watch.elapsedMilliseconds;
    log('[Fair] FlatBuffer construct: $end1 ms, serialize: $end2 ms');
    return map;
  }

  ///flatBuffer Reference to json
  static dynamic serializeReference(Reference reference) {
    if (reference.isString) {
      return reference.stringValue;
    } else if (reference.isInt) {
      return reference.intValue;
    } else if (reference.isBool) {
      return reference.boolValue;
    } else if (reference.isDouble) {
      return reference.doubleValue;
    } else if (reference.isMap) {
      var map = <String, dynamic>{};
      reference.mapKeyIterable.forEach((key) {
        map[key] = serializeReference(reference[key]);
      });
      return map;
    } else if (reference.isVector) {
      var list = [];
      reference.vectorIterable.forEach((listElement) {
        list.add(serializeReference(listElement));
      });
      return list;
    }
  }

  // dart:io
  /*ByteData fileToByteData(File file) {
    var bytes = file.readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }*/

  static ByteBuffer _b(List<int> values) {
    var data = Uint8List.fromList(values);
    return data.buffer;
  }
}

T trackExecution<T>(String message, T Function() block) {
  var watch = Stopwatch()..start();
  var result = block.call();
  log('$message(${watch.elapsedMilliseconds} ms)');
  return result;
}
