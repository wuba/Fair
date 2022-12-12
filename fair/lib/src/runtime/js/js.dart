/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
class JS {
  final String? name;

  const JS([this.name]);
}

external F allowInterop<F extends Function>(F f);
