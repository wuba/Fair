/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
extension ListExtension<E> on List {
  List<T> mapEach<T>(T Function(int index, E item) f) {
    var result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(f(i, this[i]));
    }
    return result;
  }

  /// Null is return if any element is not type of [T]
  List<T>? asListOf<T>() {
    return every((e) => e is T) ? map((e) => e as T).toList() : null;
  }
}

extension IterateExtension<E> on Iterable {
  /// Null is return if any element is not type of [T]
  Iterable<T>? asIteratorOf<T>() {
    return every((e) => e is T) ? map((e) => e as T) : null;
  }
}
