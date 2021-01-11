/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import '../public_type.dart';

class FairModuleRegistry {
  final _modules = <String, FairModuleBuilder>{};

  void addAll(Map<String, FairModuleBuilder> modules) {
    if (modules == null || modules.isEmpty) {
      return;
    }
    _modules.addAll(modules);
  }

  FairModuleBuilder moduleOf(String name) => _modules[name];
}
