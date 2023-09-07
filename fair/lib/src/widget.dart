/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:convert';

import 'package:fair/src/internal/error_tips.dart';
import 'package:fair/src/runtime/fair_message_dispatcher.dart';
import 'package:fair/src/runtime/runtime_fair_delegate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'experiment/sugar.dart';
import 'internal/flexbuffer/fair_js_decoder.dart';
import 'internal/global_state.dart';
import 'loader.dart';
import 'runtime/fair_runtime_impl.dart';
import 'type.dart';

/// [FairWidget] renders a dynamic DSL as [Widget]. Must be descendant of [FairApp].
///
/// ```dart
/// FairWidget(
///   name: 'a_unique_name',
///   path: 'assets/bundle/undefined.json',
/// )
/// ```
/// Also see:
/// * [FairApp], an application for FairWidget.
class FairWidget extends StatefulWidget {
  /// Unique widget name. If this name is registered with [FairApp.widget], the [path] can be omitted.
  /// If the same bundle is reuse with different data the name should appended with suffix, eg: $name-$data.hashcode
  final String? name;

  /// Bundle path asset|url.
  /// Also see:
  ///
  /// * [name], unique name binds to this FairWidget
  final String? path;

  /// Optional, data source relate to this FairWidget.
  final Map<String, dynamic>? data;

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

  FairWidget({
    Key? key,
    this.name,
    this.path,
    this.data,
    this.holder,
    this.delegate,
    this.wantKeepAlive = false,
  })  : assert(!(name == null && path == null), 'FairWidget require a global registered `name` or bundle `path`'),
        assert(() {
          if (data == null) return true;
          if (!(data is Map && data.values.every((e) => e is int || e is double || e is String))) {
            log('data must be a map of primary value such as int, double or String. Object reference can be broken!');
          }
          return true;
        }(), ''),
        super(key: key);

  @override
  State<StatefulWidget> createState() => FairState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(StringProperty('path', path));
    properties.add(DiagnosticsProperty<Map>('data', data));
    properties.add(ObjectFlagProperty<WidgetBuilder>.has('holder', holder));
    properties.add(DiagnosticsProperty<bool>('wantKeepAlive', wantKeepAlive));
  }
}

class FairState extends State<FairWidget> with Loader, AutomaticKeepAliveClientMixin<FairWidget> implements FairMessageCallback<String> {
  Widget? _child;
  FairApp? _fairApp;
  String? bundleType;
  late String state2key;
  bool isLoadJsError = false;
  String? loadJsErrorInfo;
  String? jsSource;
  String? rawJsPath;
  int? loadJsErrorLineNumber;

  // None nullable
  late FairDelegate delegate;

  @override
  void initState() {
    super.initState();
    state2key = GlobalState.id(widget.name);
    delegate = widget.delegate ?? GlobalState.of(widget.name).call(context, widget.data);
    delegate._bindState(this);
    delegate.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fairApp ??= FairApp.of(context);
    //加载js的文件地址
    _resolveFairRes(_fairApp!, FairJSFairJSDecoderHelper.transformPath(widget.path));
  }

  Future<dynamic> _resolveFairRes(FairApp _mFairApp, String? jsPath) async {
    var resolveJS='';
    try {
      resolveJS = await FairJSDecoder(decoder: _mFairApp.httpDecoder).decode(jsPath);
    } catch (e) {
      print(e);
    }
    // if it's not in a tree, it's not unnecessary to load js any more.
    if(mounted) {
      final results = await Future.wait([
        _mFairApp.runtime.addScript(state2key, resolveJS, widget.data),
        _mFairApp.register(this)
      ]);

      //debug mode throw error message to WarningWidget
      if (!kReleaseMode && results.isNotEmpty) {
        print('addScript Result:${results.first}');
        try {
          final addScriptResult = results.first.toString();
          var errorResult = jsonDecode(addScriptResult);
          isLoadJsError = (errorResult['status'] == 'error');

          if (isLoadJsError) {
            loadJsErrorInfo = errorResult['errorInfo'] ?? '';
            loadJsErrorLineNumber = errorResult['lineNumber'];

            //debug mode use json
            if(widget.path?.endsWith('.fair.json') == true){
              rawJsPath = widget.path?.replaceFirst('.fair.json', '.fair.js') ??
                  widget.path;

              jsSource = await rootBundle.loadString(rawJsPath!);
            }
          }
        } catch (e) {
          print(e);
        }
      }

      if(mounted) {
        delegate.didChangeDependencies();
        _reload();
      }
    }
  }

  @override
  void didUpdateWidget(covariant FairWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    delegate.didUpdateWidget(oldWidget);
  }

  void _reload() {
    if (mounted) {
      var name = state2key;
      var path = widget.path ?? _fairApp!.pathOfBundle(widget.name ?? '');
      if (path?.endsWith('.js') == true) {
        path = path?.replaceFirst(RegExp(r"\.(js)$"), ".bin");
      }
      bundleType =
      widget.path != null && widget.path?.startsWith('http') == true
          ? 'Http'
          : 'Asset';

      parse(context, page: name, url: path, data: widget.data ?? {})
          .then((value) {
        if (mounted && value != null) {
          setState(() => _child = value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    assert(_fairApp != null, 'FairWidget must be descendant of FairApp');
    if (!kReleaseMode && isLoadJsError) {
      return Scaffold(
        body: WarningWidget(
          parentContext: context,
          url: rawJsPath,
          error: loadJsErrorInfo,
          stackTrace: jsSource,
          highlightLines: [loadJsErrorLineNumber ?? -1],
          solution:
          'Unsupported JavaScript syntax, please check and correct your Dart method coding!',
        ),
      );
    }
    var builder = widget.holder ?? _fairApp?.placeholderBuilder;
    var result = _child ?? builder?.call(context);
    if (!kReleaseMode && _fairApp!.debugShowFairBanner) {
      result =
          _CheckedModeBanner(bundleType ?? '', child: result ?? Container());
    }
    return result ?? Container();
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive ?? false;

  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.dispose()`.
  @override
  void dispose() {
    _fairApp?.unregister(this);
    delegate.dispose();
    super.dispose();
  }

  // String get state2key =>
  //     widget.name ?? widget.key.toString() ?? '${toStringShort()}#$hashCode';

  @override
  void call(String t) {
    var params = {};
    try {
      params = jsonDecode(t);
    } catch (e) {
      print(e);
    }
    delegate.notifyValue(params);
  }

  @override
  String getMessageKey() => state2key;
}

/// Delegate for business logic. The delegate share similar life-circle with [State].
class FairDelegate extends RuntimeFairDelegate {
  FairState? _state;
  late String _key;

  void _bindState(FairState? state) {
    assert(state != null, 'FairState should not be null');
    _state = state!;
    _key = state.state2key;
  }

  /// state change can rebuild the widget tree, which can lead to DSL rebuild.
  /// Usually this can cost several milliseconds depend on the complexity of DSL.
  @override
  void setState(VoidCallback fn) {
    if (_state == null || !_state!.mounted) return;
    // ignore: invalid_use_of_protected_member
    _state?.setState(fn);
    _state?._reload();
  }

  @override
  BuildContext get context {
    return _state!.context;
  }

  @override
  Map<String, PropertyValue> bindValue() {
    return super.bindValue();
  }

  @override
  Map<String, Function> bindFunction() {
    var func = super.bindFunction();
    func['Sugar.paddingTop'] = (props) => Sugar.paddingTop(context);
    func['Sugar.paddingBottom'] = (props) => Sugar.paddingBottom(context);
    func['Sugar.height'] = (props) => Sugar.height(context);
    func['Sugar.width'] = (props) => Sugar.width(context);
    func['Sugar.requestFocus'] = (props) => Sugar.requestFocus(context);
    func['Sugar.onTapEmpty'] = (props) => Sugar.onTapEmpty();
    return func;
  }

  void initState() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void didUpdateWidget(covariant FairWidget oldWidget) {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  String key() {
    return _key;
  }
}

/// Displays a [Banner] saying "Fair" when running in checked mode.
/// [FairWidget] builds one of these by default.
/// Does nothing in release mode.
class _CheckedModeBanner extends StatelessWidget {
  /// Creates a const checked banner.
  const _CheckedModeBanner(this.appendix, {Key? key, required this.child}) : super(key: key);

  /// The widget to show behind the banner.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// Type indicator
  final String appendix;

  @override
  Widget build(BuildContext context) {
    var result = Banner(
      message: 'Fair $appendix',
      textDirection: TextDirection.ltr,
      location: BannerLocation.topStart,
      color: appendix == 'Http' ? Colors.green : Colors.orange,
      child: child,
    );
    return result;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    var message = 'disabled';
    assert(() {
      message = '"Fair $appendix"';
      return true;
    }());
    properties.add(DiagnosticsNode.message(message));
  }
}
