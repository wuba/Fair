/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:build/build.dart';
import 'package:path/path.dart' as p;

class FairAssetId extends AssetId {

  FairAssetId(String package, String path) : super(package, path);

  factory FairAssetId.resolve(String uri, {FairAssetId? from}) {
    final parsedUri = Uri.parse(uri);
    if (parsedUri.hasScheme) {
      if (parsedUri.scheme == 'package') {
        return FairAssetId(parsedUri.pathSegments.first,
            p.url.join('lib', p.url.joinAll(parsedUri.pathSegments.skip(1))));
      } else if (parsedUri.scheme == 'asset') {
        return FairAssetId(parsedUri.pathSegments.first,
            p.url.joinAll(parsedUri.pathSegments.skip(1)));
      }
      throw UnsupportedError(
          'Cannot resolve $uri; only "package" and "asset" schemes supported');
    }
    if (from == null) {
      throw ArgumentError.value(from, 'from',
          'An AssetId "from" must be specified to resolve a relative URI');
    }

    // Empty urls resolve to the base
    if (uri.isEmpty) {
      return from;
    }

    return FairAssetId(p.url.normalize(from.package),
        p.url.join(p.url.dirname(from.path), uri));
  }
}

