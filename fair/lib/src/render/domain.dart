/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

class Domain<E> {
  final List<E> source;
  final Domain parent;
  int index = 0;

  Domain(this.source, {this.parent});

  bool match(dynamic exp) {
    return source != null &&
        exp is String &&
        RegExp('#\\(.+\\)', multiLine: true).hasMatch(exp) &&
        (exp.contains('\$item') || exp.contains('\$index'));
  }

  String bindValue(String exp) {
    var processed = exp.substring(2, exp.length - 1);
    processed = processed.replaceAll('\$item', '${source[index]}');
    processed = processed.replaceAll('\$index', '$index');
    return processed;
  }

  List forEach(dynamic Function(Domain $, E element) f) {
    index = 0;
    var result = <dynamic>[];
    for (var i = 0; i < source.length; i++) {
      result.add(f(this, source[index]));
      index++;
    }
    return result;
  }
}
