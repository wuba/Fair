/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:fair/src/internal/bind_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../internal/global_state.dart';
import '../render/property.dart';

class FairComponent extends StatelessWidget {
  final _MergedValuedListenable props;
  final dynamic func;
  final String tag;
  final String id;

  FairComponent(
    this.tag, {
    Key? key,
    this.func,
    required List<dynamic> pa,
    Map<String, dynamic>? na,
  })  : props = _MergedValuedListenable(pa, na),
        id = GlobalState.id(tag),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, dynamic>>(
      builder: (BuildContext context, Map<String, dynamic> data, _) {
        log('[Fair] rebuild child => $id');
        final parameter = Property.extract(data: data);
        if (func is FairModule) {
          return (func as FairModule).onCreateComponent(context, parameter);
        }
        return Function.apply(func, [parameter], null);
      },
      valueListenable: props,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<String>('tag', tag));
    properties.add(DiagnosticsProperty<String>('id', '$id'));
    properties.add(DiagnosticsProperty<String>('func', '$func'));
  }
}

class _MergedValuedListenable extends FairValueNotifier<Map<String, dynamic>> {
  final List<dynamic>? pa;
  final Map<String, dynamic>? na;
  VoidCallback? _listener;

  _MergedValuedListenable(this.pa, this.na) : super(Property.combined(pa, na));

  void forEachListenable(List<dynamic>? pa, Map<String, dynamic>? na,
      void Function(FairValueNotifier element) f) {
    pa?.whereType<FairValueNotifier>().forEach(f);
    na?.values.whereType<FairValueNotifier>().forEach(f);
  }

  @override
  void addListener(void Function() listener) {
    super.addListener(listener);
    final l = _listener ??
        (_listener = () {
          notifyListeners();
        });
    forEachListenable(pa, na, (e) {
      e.addListener(l);
    });
  }

  @override
  void removeListener(void Function() listener) {
    super.removeListener(listener);
    if (_listener == null) return;
    forEachListenable(pa, na, (e) {
      e.removeListener(_listener!);
    });
  }
}
