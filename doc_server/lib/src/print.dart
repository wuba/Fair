/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

class TrackedPrint {
  final _startTime = DateTime.now();
  final _watch = Stopwatch()..start();

  void log(String m) {
    print(_message(_startTime, _watch.elapsed, m));
  }

  String _message(DateTime requestTime, Duration elapsedTime, String extra) {
    return '${requestTime.toIso8601String()} '
        '${elapsedTime.toString().padLeft(15)} '
        '$extra';
  }
}
