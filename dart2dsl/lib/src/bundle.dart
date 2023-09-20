/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import '../fairdsl/fair_ast_gen.dart';
import '../fairdsl/fair_dsl_gen.dart';

Future<String> parseFile(String filePath, {String? sourcePath}) async {
  var ast = await generateAstMap(filePath, sourcePath: sourcePath);
  return ast != null ? fairDsl(ast) : 'Failed parse ast';
}
