/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:flutter/widgets.dart';

class ShowFairAlertModule extends FairVoidCallbackModule {
  static String tagName = 'onTapSetting';

  ShowFairAlertModule() : super(tagName);

  @override
  VoidCallback onCreateComponent(BuildContext ctx, Map<String, dynamic> props) {
    return () => showFairAboutDialog(ctx);
  }
}
