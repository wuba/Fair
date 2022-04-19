/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'dart:async';
import './src/convertor.dart' show convertWidgetStateFile;

Future<String> convertFile(String input, [bool compress = false]) async {
  return convertWidgetStateFile(input, compress);
}

void main(List<String> arguments) async {
  var s = await convertFile('/Users/a58/Desktop/work/flutter_commercial/lib/test/fair_widget/LoupanDetailPage.dart');
  print(s);
}