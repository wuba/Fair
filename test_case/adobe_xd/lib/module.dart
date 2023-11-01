/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:adobe_xd/page_link.dart';
import 'package:fair/fair.dart';
import 'package:flutter/widgets.dart';

import 'svg_const.dart';

class PageBuilderModule extends FairModule<Function> {
  static String tagName = 'pageBuilder';

  PageBuilderModule() : super(tagName);

  @override
  Function onCreateComponent(BuildContext ctx, Map<String, dynamic>? props) {
    return () => FairWidget(
          name: 'gear',
          path: 'assets/bundle/lib_Gear.fair.bin',
          data: {
            'svg_6z8g0n': svg_6z8g0n,
            'svg_d9sdjy': svg_d9sdjy,
            'svg_munyoe': svg_munyoe
          },
        );
  }
}

class PageLinkModule extends FairModule<PageLinkInfo> {
  static String tagName = 'PageLinkInfo';

  PageLinkModule() : super(tagName);

  @override
  PageLinkInfo onCreateComponent(BuildContext ctx, Map<String, dynamic>? props) {
    return PageLinkInfo(
      pageBuilder: props!['pageBuilder'],
      trigger: props['trigger'] ?? LinkTrigger.Tap,
      transition: props['transition'] ?? LinkTransition.Fade,
      ease: props['ease'],
      duration: props['duration'],
    );
  }
}
