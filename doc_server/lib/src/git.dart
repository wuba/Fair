/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:io';

import 'print.dart';

Future<bool> clone(String url, String local) {
  var p = TrackedPrint();
  return Process.run('git', ['clone', '--depth=1', url, local]).then((value) {
    if (value.exitCode != 0) {
      stdout.writeln(value.stdout);
      stderr.writeln(value.stderr);
      return false;
    } else {
      p.log('clone success');
      return true;
    }
  });
}
