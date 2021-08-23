/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'dart:io';
import 'dart:async';

Future<String> convertFile(String input, [bool compress = false]) async {
  var result = await Process.run('which', ['dart']);
  var bin = StringBuffer();
  bin.write(result.stdout);
  var strBin = bin.toString();
  var dirEndIndex = strBin.lastIndexOf(Platform.pathSeparator);
  var binDir = strBin.substring(0, dirEndIndex);
  var args = ['./entry.aot'];
  if (compress) args.add('--compress');
  args.add(input);
  result = await Process.run('$binDir/cache/dart-sdk/bin/dartaotruntime', args);

  return result.stdout.toString();
}

// void main(List<String> args) async {
//   var res = await convertFile('/Users/luozhenglong/Documents/source/fair-new/fair/example/lib/src/model/part/part_of_sample_page_with_logic.dart');
//   print(res);
// }