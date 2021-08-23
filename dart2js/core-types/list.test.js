/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

require("./list");

function pre() {
  global.print = console.log.bind(console);
}

function run() {
  let obj = [];
  obj.add(1);
  obj.addAll([2, 3, 4, 5, 6, 7]);
  print(obj.first);
  print(obj.last);
  print(obj.reversed);
  print(obj.indexWhere((elem) => !(elem % 3), 1));
  print(obj.lastIndexWhere((elem) => !(elem % 3)));
  obj.clear();
  print(obj.toString());
  obj.insert(0, 8);
  print(obj);
  obj.insertAll(
    0,
    [9, 10, 11, 12, 9, 10, 11, 12, 9, 10, 11, 12, 9, 10, 11, 12]
  );
  print(obj);
  obj.setAll(1, [13, 14, 13, 15, 14, 15, 16, 17, 18, 17, 18]);
  print(obj);
  obj.remove(13);
  print(obj);
  obj.removeLast();
  print(obj);
  obj.removeWhere((e) => e == 17);
  print(obj);
  obj.addAll([19, 20, 21, 22, 19, 20, 21, 22]);
  print(obj);
  obj.retainWhere((e) => e < 22);
  print(obj);
  print(obj.sublist(2, 4));
  print(obj.getRange(2, 4));
  obj.setRange(2, 4, [1, 2, 3, 4, 5], 2);
  print(obj);
  obj.removeRange(2, 4);
  print(obj);
  obj.fillRange(2, 4, 111);
  print(obj);
  obj.replaceRange(2, 4, [222, 223, 224]);
  print(obj);
  print(obj.asMap());
  print(obj.__op_add__([100, 101, 102]));

  print(Array.filled(10, "a"));
  print(Array.empty());
  print(Array.from([1, 2, 3, 4]));
  print(Array.of([1, 2, 3, 4]));
  print(Array.generate(10, (e) => e));
  print(Array.unmodifiable([1, 2, 3, 4]));
  print(Array.castFrom([1, 2, 3, 4]));

  let target = [1, 3, 4, 5];
  let source = [6, 7, 8, 9, 10];
  Array.copyRange(target, 1, source, 3);
  print(target);
  Array.writeIterable(target, 2, [101, 102]);
  print(target);
}

pre();
run();
