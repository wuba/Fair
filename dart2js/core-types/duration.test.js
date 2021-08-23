/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

require("./duration");

function run() {
  console.log(Duration.millisecondsPerSecond);
  console.log(Duration.microsecondsPerSecond);
  console.log(Duration.microsecondsPerHour);

  let obj1 = Duration({ days: 1 });
  let obj2 = new Duration({ hours: 1 });
  function printVal(obj) {
    console.log(obj.toString());
    console.log(obj.inDays);
    console.log(obj.inHours);
    console.log(obj.inMinutes);
    console.log(obj.inSeconds);
    console.log(obj.inMilliseconds);
    console.log(obj.inMicroseconds);
    console.log("\r\n");
  }

  printVal(obj1);
  printVal(obj2);
  printVal(obj1.__op_add__(obj2));
  printVal(obj1.__op_minus__(obj2));
  printVal(obj1.__op_multi__(1.5));
  printVal(obj1.__op_idivide__(1.5));
  printVal(obj1.__op_lt__(obj2));
}

run();
