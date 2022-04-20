/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

List<T>? as<T>(List? children) {
  if (children == null) {
    return null;
  }

  if (children.isEmpty) {
    return [];
  }
  return children.map((e) => e as T).toList();
}
