/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

class JsonFormatter {
  var encoder = JsonEncoder.withIndent('  ');

  String format(String source) {
    return encoder.convert(jsonDecode(source));
  }
}
