/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/src/render/proxy.dart';
import 'package:fair/src/utils.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../internal/bind_data.dart';
import '../internal/bundle_provider.dart';
import '../internal/error_tips.dart';
import '../internal/fair_decoder.dart';
import '../internal/global_state.dart';
import 'package:fair_version/fair_version.dart';
import 'builder.dart';

class _DataSource {
  final Map? layout;
  final Map? data;
  final Map? methodMap;

  _DataSource({this.layout, this.data, this.methodMap});
}

class Decoder {
  final FairBundle _loader = FairBundle();
  final FairDecoder _decoder = FairDecoder();
  final String? page;
  final Map<String, dynamic>? dataSource;
  final String? url;
  _DataSource? _source;

  Decoder(this.page, {this.dataSource, this.url});

  bool get hasResolved => _source != null;

  Future<void> resolve(BuildContext context) async {
    var jsonBean = await _loader.obtain(context).onLoad(url, _decoder,
        cache: true, h: const {'fairVersion': '$fairVersion#$flutterVersion'});
    Map? data = <dynamic, dynamic>{};
    Map? methodMap = <String, dynamic>{};

    var d = jsonBean?.remove('data');
    try {
      methodMap = jsonBean?['methodMap'];
    } catch (e) {
      print(e);
    }
    jsonBean?.remove('methodMap');

    if (d != null) {
      data.addAll(d);
    }
    if (dataSource != null) {
      data.addAll(dataSource!);
    }
    var s = _DataSource(layout: jsonBean, data: data, methodMap: methodMap);
    _source = s;
    return Future.value();
  }

  Widget toWidget(BuildContext context) {
    return trackExecution('[Fair] parse as widget: $page', () {
      var source = _source;
      var layout = source?.layout;
      var data = source?.data;
      var methodMap = source?.methodMap;
      var widget = _convert(context, layout!, methodMap, data: data);
      return widget;
    });
  }

  Widget _convert(BuildContext context, Map map, Map? methodMap, {Map? data}) {
    var app = FairApp.of(context);
    var bound = app?.bindData[page];
    if (data != null && data.isNotEmpty) {
      log('[Fair] binding data => $data');
      bound ??= BindingData(app?.modules);
      bound.data = data;
    }
    var proxy = app?.proxy;
    Widget w = DynamicWidgetBuilder(proxy as ProxyMirror?, page, bound, bundle: url)
            .convert(context, map, methodMap) ??
        WarningWidget(
            parentContext:context,name: page, url: url, error: 'tag name not supported yet');
    return w;
  }
}
