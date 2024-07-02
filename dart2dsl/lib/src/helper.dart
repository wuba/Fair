/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

/// Use Map to save the module value of all bundle files.
class ModuleNameHelper {
  var modules = {};

  static final ModuleNameHelper _singleton = ModuleNameHelper._internal();

  factory ModuleNameHelper() => _singleton;

  ModuleNameHelper._internal();
}
