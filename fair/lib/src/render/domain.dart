/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'base_model.dart';

abstract class Domain {
  final Domain? parent;

  Domain({required this.parent});

  bool match(dynamic exp);

  dynamic bindValue(String exp);
}

abstract class IndexDomain extends Domain {
  IndexDomain({required Domain? parent}) : super(parent: parent);
  int index = 0;
}

class MapEachDomain extends IndexDomain {
  MapEachDomain(this.source, {required Domain? parent}) : super(parent: parent);

  final List? source;

  @override
  bool match(dynamic exp) {
    if (parent != null && parent!.match(exp)) {
      return true;
    }
    return (source != null &&
        exp is String &&
        ((RegExp('#\\(.+\\)', multiLine: true).hasMatch(exp) &&
                (exp.contains('\$item') || exp.contains('\$index'))) ||
            exp == 'item' ||
            exp == 'index' ||
            exp.startsWith("\$(item") ||
            exp.startsWith("\$(index") ||
            exp.startsWith("#(\${index") ||
            exp.startsWith("#(\${item") ||
            exp.startsWith('^(index)') ||
            exp.startsWith('^(item)')));
  }

  @override
  dynamic bindValue(String exp) {
    if (parent != null && parent!.match(exp)) {
      return parent!.bindValue(exp);
    }

    if (exp == 'item') {
      return source?[index];
    } else if (exp == 'index') {
      return index;
    }
    // Carrying ”#(“ indicates value conversion to a string
    final bool isStringValue = exp.startsWith('#(');
    dynamic processed = exp.substring(2, exp.length - 1);
    if (processed.startsWith("\${")) {
      processed = processed.substring(2, processed.length - 1);
    }

    // ^(item)
    if (processed == 'item') {
      return source?[index];
    }
    // ^(index)
    else if (processed == 'index') {
      return index;
    }

    if (processed.contains('.')) {
      List<String> expList = processed.split('.');
      if (expList.first == '\$item' || expList.first == 'item') {
        dynamic obj = source?[index];
        dynamic modelValue;
        if (obj is BaseModel) {
          Map<String, dynamic> json = (obj as BaseModel).toJson();
          modelValue = json;
        } else if (obj is Map) {
          modelValue = obj;
        }
        if (modelValue != null) {
          expList.removeAt(0);
          for (String k in expList) {
            modelValue = modelValue[k];
          }
          // If conversion to a string is not explicitly indicated, the original type is returned
          processed = isStringValue ? "${modelValue}" : modelValue;
        }
      }
    } else {
      processed = processed.replaceAll('\$item', '${source?[index]}');
      processed = processed.replaceAll('\$index', '$index');
    }

    return processed;
  }

  List forEach(dynamic Function(Domain $, dynamic element) f) {
    index = 0;
    var result = <dynamic>[];
    for (var i = 0; i < (source?.length ?? 0); i++) {
      result.add(f(this, source![index]));
      index++;
    }
    return result;
  }
}
