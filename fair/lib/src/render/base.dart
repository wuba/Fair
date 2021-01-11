/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

mixin P<T, K> {
  bool hasComponent(String key);

  T componentOf(String key);
}

class W<T> {
  final T data;
  final bool binding;

  W(this.data, this.binding);
}
