/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

class FairLogicUnit {

  static final FairLogicUnit _fairASTLogicUnit = FairLogicUnit._internal();

  factory FairLogicUnit() {
    return _fairASTLogicUnit;
  }

  FairLogicUnit._internal();

  // 保存所有的变量
  Map variables = {};

  // 保存所有的方法
  Map functions = {};

  void addVariable(String? name) {
    variables.putIfAbsent(name, () => name);
  }

  void addFunction(String? name) {
    functions.putIfAbsent(name, () => name);
  }
}
