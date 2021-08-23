/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'convertor.dart';
void main(List<String> args) {
  if (args.isEmpty) {
    print('''
    Usage:
      dart-to-js --compress [inputFile]
    ''');
    return;
  }
  print(convertWidgetStateFile(args[args.length - 1], args.length == 2 && args[0] == '--compress'));
}

// dart compile aot-snapshot entry.dart