/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

/// An annotation used to specify a class to generate code for.
class FairWell {
  /// Unique tag name for FairWidget
  final String? tag;

  /// Asset path or http url
  final String? path;

  const FairWell(this.tag, {this.path});
}
