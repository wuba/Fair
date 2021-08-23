/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:build/build.dart';

import 'bundle_builder.dart';
import 'formatter.dart';
import 'generator.dart';
import 'post_builder.dart';

Builder build(BuilderOptions options) {
  return BundleBuilder(BundleGenerator(), formatOutput: JsonFormatter().format);
}

Builder bind(BuilderOptions options) {
  return BundleBuilder(BindingGenerator(),
      generatedExtension: '.fair.ignore', formatOutput: (_) => _);
}

Builder package(BuilderOptions options) {
  return PackageBuilder();
}

PostProcessBuilder archive(BuilderOptions options) {
  return ArchiveBuilder();
}
