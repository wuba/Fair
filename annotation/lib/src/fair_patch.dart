/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

/// Annotation for Fair compiler, this indicate the top Widget need to generate as bundle resource
class FairPatch {
  /// Optional,Set the module for the currently generated bundle.
  /// bundle files in the same module can be downloaded as a set of resources.
  final String module;

  const FairPatch({this.module = 'lib'});
}

/// Annotation to generate a library binding
class FairBinding {
  /// Package resource url , such as `package:convex_bottom_bar/convex_bottom_bar.dart`
  final List<String>? packages;

  /// Utils should not have constructor
  final bool ignoreConstructor;

  /// TODO not supported yet
  /// If [recursive] is true, all the widgets inside the package will be used to generate binding.
  final bool recursive;

  const FairBinding({
    this.packages,
    this.recursive = false,
    this.ignoreConstructor = false,
  });
}
