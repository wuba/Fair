/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

List<T> as<T>(List<T>? children) {
  if (children == null || children.isEmpty) {
    return [];
  }
  return children.map((e) => e).toList();
}
