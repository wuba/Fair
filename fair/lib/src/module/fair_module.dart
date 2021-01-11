/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:flutter/widgets.dart';

/// Define a custom component as [FairModule]
abstract class FairModule<T> {
  final String name;

  FairModule(this.name);

  bool get isWidget => false;

  T onCreateComponent(BuildContext ctx, Map<String, dynamic> props);

  static dynamic cast(BuildContext context, dynamic module) {
    if (module is FairModule) {
      return (props) => module.onCreateComponent(context, props);
    }
    return module;
  }
}

/// Define a widget as [FairModule]
abstract class FairWidgetModule extends FairModule<Widget> {
  FairWidgetModule(String name) : super(name);

  @override
  bool get isWidget => true;
}

/// Define a callback as [FairModule], such as onPressed event.
/// Override [onCreateComponent] to return a VoidCallback
abstract class FairVoidCallbackModule extends FairModule<VoidCallback> {
  FairVoidCallbackModule(String name) : super(name);

  @override
  bool get isWidget => false;
}
