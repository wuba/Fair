/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
require("./date");

function pre() {
  global.int = {
    parse: function (source, { radix } = {}) {
      return parseInt(source, radix || 10);
    },
  };
  global.assert = function (val) {
    if (!val) throw "assert";
  };
  global.print = console.log.bind(console);
}

function run() {
  let obj1 = DateTime.now();
  let obj2 = DateTime.now();
  console.log(obj1.toString());
  console.log(obj1.toIso8601String());
  console.log(obj1.millisecondsSinceEpoch);
  console.log(obj1.microsecondsSinceEpoch);
  // console.log(obj1.timeZoneName);
  console.log(obj1.timeZoneOffset);
  console.log(obj1.year);
  console.log(obj1.month);
  console.log(obj1.day);
  console.log(obj1.hour);
  console.log(obj1.minute);
  console.log(obj1.second);
  console.log(obj1.millisecond);
  // console.log(obj1.microsecond);
  console.log(obj1.weekday);

  obj1 = obj1.add(Duration({ days: 1 }));
  console.log(obj1.toString());
  obj1 = obj1.subtract(Duration({ hours: 1 }));
  console.log(obj1.toString());

  console.log(obj1.isAfter(obj2));
  console.log(obj2.isBefore(obj1));
  console.log(obj1.isBefore(obj2));
  console.log(obj2.isAtSameMomentAs(obj1));
  console.log(obj2.difference(obj1).toString());

  console.log(obj1.toLocal().toString());
  console.log(obj1.toUtc().toString());
  console.log("\r\n");

  [
    "2012-02-27",
    "2012-02-27 13:27:00",
    "2012-02-27 13:27:00.123456789z",
    "2012-02-27 13:27:00,123456789z",
    "20120227 13:27:00",
    "20120227T132700",
    "20120227",
    "+20120227",
    "2012-02-27T14Z",
    "2012-02-27T14+00:00",
    "-123450101 00:00:00 Z",
    "2002-02-27T14:00:00-0500",
  ].forEach((item) => print(DateTime.parse(item).toString()));
}

pre();
run();
