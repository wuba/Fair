// ignore_for_file: dead_code

import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:fair_gallery/src/utils/asset_bunldes.dart';
import 'package:fair_gallery/src/widget/share_data_widget.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';

class ExtendedFairWidget extends StatefulWidget {
  const ExtendedFairWidget({
    Key? key,
    required this.builder,
    required this.name,
    this.fairProps,
    this.delegate,
    this.holder,
    this.wantKeepAlive,
    this.index,
  }) : super(key: key);

  /// 页面的名字，由 ff_route 生成
  /// Unique widget name. If this name is registered with [FairApp.widget], the [path] can be omitted.
  /// If the same bundle is reuse with different data the name should appended with suffix, eg: $name-$data.hashcode
  final String name;

  // /// Bundle path asset|url.
  // /// Also see:
  // ///
  // /// * [name], unique name binds to this FairWidget
  // final String? path;

  /// Optional, data source relate to this FairWidget.
  final Map<String, dynamic>? fairProps;

  /// Optional, provide the loading widget before real content is ready.
  /// Will use the placeholder configured with [FairApp] if it's not provided.
  ///
  /// Also see:
  ///
  /// * [FairApp.placeholderBuilder], global placeholder for [FairApp]
  final WidgetBuilder? holder;

  /// Optional delegate for the fair bundle
  /// Also see:
  ///
  /// * delegate of [FairApp]
  final FairDelegate? delegate;

  /// Work with [AutomaticKeepAliveClientMixin], usually for TabBar
  final bool? wantKeepAlive;

  /// Return AOT Widget
  final WidgetBuilder builder;

  final int? index;

  /// enable fair for test
  static bool enable = true;

  ///
  static const tag = 'FairWidget';

  static bool fairEnable(Map<String, dynamic>? input) =>
      asT<bool>(input?[tag]) ?? false;

  @override
  State<ExtendedFairWidget> createState() => _ExtendedFairWidgetState();
}

class _ExtendedFairWidgetState extends State<ExtendedFairWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 根据自身的情况进行判断，ExtendedFairWidget 中可以进行判断，下载等情况处理
    Widget child;
    bool serviceEnableFair = false;
    var fairProps = widget.fairProps;
    fairProps = fairProps?['fairProps'] ?? fairProps;
    if (serviceEnableFair || ExtendedFairWidget.enable) {
      child = FairWidget(
        name: widget.name,
        path: serviceEnableFair ? 'your bin path' : widget.name.fairBundle,
        data: fairProps != null
            ? <String, dynamic>{'fairProps': jsonEncode(fairProps)}
            : null,
        holder: widget.holder,
        wantKeepAlive: widget.wantKeepAlive,
      );
    } else {
      child = widget.builder(context);
    }

    child = ShareDataWidget(
      child: child,
      data: fairProps,
      index: widget.index,
    );

    return child;
  }
}
