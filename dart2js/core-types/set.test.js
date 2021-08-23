/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

require("./set");
require("./list");

function pre() {
  global.print = console.log.bind(console);
}

function run() {
  var obj = new Set();
  obj.add(1);
  obj.addAll([2, 3, 4, 5, 6, 7, 8, 9, 10, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  print(obj.contains(3));
  print(obj.remove(4));
  print(obj.remove(55));
  print(obj.lookup(3));
  print(obj.lookup(55));

  var obj1 = new Set();
  obj1.addAll([3, 4, 5]);
  obj.removeAll(obj1);
  print(obj);
  obj.retainAll([6, 7, 8, 9]);

  obj.retainWhere((e) => e % 2);
  print(obj);
  obj.removeWhere((e) => e % 2);
  print(obj);
  obj.addAll([1, 2, 3, 4, 5]);
  print(obj.containsAll([1, 2, 3]));
  var obj2 = new Set();
  obj2.addAll([4, 5, 6, 7]);
  print(obj.intersection(obj2));
  print(obj.union(obj2));
  print(obj.difference(obj2));
  print(obj.toSet());
  obj.clear();
  print(obj);
}

pre();
run();
