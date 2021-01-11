/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/src/utils.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../internal/bind_data.dart';
import '../internal/bundle_provider.dart';
import '../internal/error_tips.dart';
import '../internal/fair_decoder.dart';
import '../internal/global_state.dart';
import '../widgets/version.dart';
import 'builder.dart';

class _DataSource {
  final Map layout;
  final Map data;

  _DataSource({this.layout, this.data});
}

class Decoder {
  final FairBundle _loader = FairBundle();
  final FairDecoder _decoder = FairDecoder();
  final String page;
  final Map<String, dynamic> dataSource;
  final String url;
  _DataSource _source;

  Decoder(this.page, {this.dataSource, this.url});

  Future<void> resolve(BuildContext context) async {
    var jsonBean = await _loader.obtain(context).onLoad(url, _decoder,
        cache: true, h: const {'fairVersion': '$fairVersion#$flutterVersion'});
    var data = <dynamic, dynamic>{};
    var d = jsonBean.remove('data');
    if (d != null) {
      data.addAll(d);
    }
    if (dataSource != null) {
      data.addAll(dataSource);
    }
    var s = _DataSource(layout: jsonBean, data: data);
    _source = s;
    return Future.value();
  }

  Widget toWidget(BuildContext context) {
    return trackExecution('[Fair] parse as widget: $page', () {
      var source = _source;
      var layout = source.layout;
      var data = source.data;
      var widget = _convert(context, layout, data: data);
      return widget;
    });
  }

  Widget _convert(BuildContext context, Map map, {Map data}) {
    var app = FairApp.of(context);
    var bound = app.bindData[page];
    if (data != null && data.isNotEmpty) {
      log('[Fair] binding data => $data');
      bound ??= BindingData(app.modules);
      bound.data = data;
    }
    var proxy = app.proxy;
    Widget w = DynamicWidgetBuilder(proxy, page, bound, bundle: url)
            .convert(context, map) ??
        WarningWidget(
            name: page, url: url, error: 'tag name not supported yet');
    return w;
  }
}
