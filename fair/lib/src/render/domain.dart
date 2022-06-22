/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'base_model.dart';

class Domain<E> {
  final List<E>? source;
  final Domain? parent;
  int index = 0;

  Domain(this.source, {this.parent});

  bool match(dynamic exp) {
    return source != null &&
        exp is String &&
        ((RegExp('#\\(.+\\)', multiLine: true).hasMatch(exp) && (exp.contains('\$item') || exp.contains('\$index'))) ||
            exp == 'item' ||
            exp == 'index' ||
            exp.startsWith("\$(item") ||
            exp.startsWith("\$(index"));
  }

  String bindValue(String exp) {
    // TODO mapEach
    if (exp == 'item') {
      return exp.replaceAll('item', '${source?[index]}');
    }
    if (exp == 'index') {
      return exp.replaceAll('index', '$index');
    }
    var processed = exp.substring(2, exp.length - 1);

    if (processed.contains('.')) {
      List<String> expList = processed.split('.');
      if (expList.first == '\$item' || expList.first == 'item') {
        dynamic obj = source?[index];
        if (obj is BaseModel) {
          Map<String, dynamic> json = (obj as BaseModel).toJson();
          expList.removeAt(0);
          dynamic modelValue = json;
          for(String k in expList){
            modelValue = modelValue[k];
          }

          processed = "${modelValue}";
        }
      }
    } else {
      processed = processed.replaceAll('\$item', '${source?[index]}');
      processed = processed.replaceAll('\$index', '$index');
    }

    return processed;
  }

  List forEach(dynamic Function(Domain $, E element) f) {
    index = 0;
    var result = <dynamic>[];
    for (var i = 0; i < (source?.length ?? 0); i++) {
      result.add(f(this, source![index]));
      index++;
    }
    return result;
  }
}
