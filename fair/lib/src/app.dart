/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:io';

import 'package:fair/fair.dart';
import 'package:fair/src/internal/global_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'internal/flexbuffer/fair_js_decoder_http_decoder.dart';
import 'state.dart';

/// Application which can update the widget tree through bundle file.
///
/// Use [bundleAlias] to declare a map of local DSL assets.
///
/// The [bundleProvider] can be setup to a custom instance of [BundleLoader],
/// so you can handle the process of bundle loading.
/// eg:
/// * redirect http request to native-side
/// * add inApp headers
/// * add cache-layer to both local assets and http resource
///
/// Example:
///```dart
/// FairApp(
///   child: MaterialApp(
///     child: Scaffold(
///       appBar: AppBar(title: const Text('FairDemo')
///     ),
///   )
/// )
/// ```
/// Also see:
/// * [FairWidget]
class FairApp extends InheritedWidget with AppState {
  /// Remote or local bundle assets. The key should be unique tag name while
  /// value represent binary resource for layout, such as assets path or url.
  final Map<String, String>? bundleAlias;

  /// Optional, provide the loading widget before real content is ready.
  final WidgetBuilder? placeholderBuilder;

  /// Provide custom router when Fair notify a named route event.
  final FairRouteBuilder? routeBuilder;

  /// Provide custom bundle loader
  final BundleLoader? bundleProvider;

  final HttpDecoder? httpDecoder;

  /// Turns on a little "Fair" banner in checked mode to indicate
  /// that the app is using Fair SDK. This is on by default (in
  /// checked mode), to turn it off, set the constructor argument to
  /// false. In release mode this has no effect.
  final bool debugShowFairBanner;
  
  /// Define a custom DynamicWidgetBuilder to solve special case
  List<DynamicWidgetBuilderFunction?>? dynamicWidgetBuilder;
      
  static final WidgetBuilder _defaultHolder = (BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: CircularProgressIndicator()),
    );
  };

  /// Construct new instance of [FairApp]
  ///
  /// * [profile] enable internal log for to debug/profile
  /// * [placeholder], widget being loaded before [FairWidget] is displayed.
  /// * [delegate] provide state delegate
  /// * [modules], module is a named component factory, which return a Widget/Function/Model
  /// * [generated], widget annotated with [FairBinding] will be generate as a map.
  FairApp({
    Key? key,
    required Widget child,
    this.bundleAlias,
    this.routeBuilder,
    this.bundleProvider,
    this.debugShowFairBanner = true,
    bool profile = false,
    WidgetBuilder? placeholder,
    Map<String, FairDelegateBuilder>? delegate,
    Map<String, FairModuleBuilder>? modules,
    GeneratedModule? generated,
    this.httpDecoder,
    this.dynamicWidgetBuilder,
  })  : placeholderBuilder = placeholder ?? _defaultHolder,
        super(key: key, child: child) {
    setup(profile, delegate, generated, modules);
  }

  static FairApp? of(BuildContext? context, {bool rebuild = false}) {
    return rebuild ? context?.dependOnInheritedWidgetOfExactType<FairApp>() : context?.findAncestorWidgetOfExactType<FairApp>();
  }

  String? pathOfBundle(String tag) {
    return bundleAlias != null ? bundleAlias![tag] : null;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Map<String, String>>('bundle', bundleAlias));
  }

  static void runApplication(
    Widget app, {
    Map<String, IFairPlugin>? plugins,
    Map<String, String>? jsPlugins,
    String? package,
    List<String>? baseJsSources,
    List<IFairLibraryAdapter>? adapters,
  }) {
    if (plugins == null) {
      plugins = {};
    }
    if (jsPlugins == null) {
      jsPlugins = {};
    }
    //init 3rd-library adapter
    initFairLibraryAdapter(app, plugins: plugins, jsPlugins: jsPlugins, adapters: adapters);

    // WidgetsFlutterBinding.ensureInitialized();
    FairPluginDispatcher.registerPlugins(plugins);

    if(!kIsWeb && Platform.isAndroid){
      var runtime = Runtime();
      var basicChannel = runtime.getBasicChannel();
      basicChannel.invokeMethod('jsLoadListener').then((value){
        runtime.loadCoreJs(package: package, jsPlugins: jsPlugins, baseJsSources: baseJsSources).then((value) => runApp(app));
      });

    }else{
      Runtime().loadCoreJs(package: package, jsPlugins: jsPlugins, baseJsSources: baseJsSources).then((value) => runApp(app));
    }
  }

  ///[app] FairApp
  ///[plugins] Fair plugin code with Dart
  ///[jsPlugins] Fair plugin code with JavaScript
  ///[adapters] 3rd-party libraries which adapted Fair
  static void initFairLibraryAdapter(
    Widget app, {
    Map<String, IFairPlugin>? plugins,
    Map<String, String>? jsPlugins,
    List<IFairLibraryAdapter>? adapters,
  }) {

    if (adapters != null && adapters.isNotEmpty) {
      adapters.forEach((element) {

        if (element.provideFairPlugins()?.isNotEmpty == true) {
          plugins?.addAll(element.provideFairPlugins()!);
        }

        if (element.provideJSPlugins()?.isNotEmpty == true) {
          jsPlugins?.addAll(element.provideJSPlugins()!);
        }

        if (app is FairApp) {
          if (element.provideFairModule() != null) {
            app.modules.addAll(element.provideFairModule());
          }

          if (element.provideGeneratedModule() != null && app.proxy is ProxyMirror) {
            (app.proxy as ProxyMirror).addGeneratedBinding(element.provideGeneratedModule()!);
          }

          if (element.provideFairDelegate() != null) {
            GlobalState.instance().addExtBuilder(element.provideFairDelegate());
          }

          if (element.provideDynamicWidgetBuilder() != null) {
            if (app.dynamicWidgetBuilder == null) {
              app.dynamicWidgetBuilder = [element.provideDynamicWidgetBuilder()];
            } else {
              app.dynamicWidgetBuilder!.add(element.provideDynamicWidgetBuilder());
            }
          }
        }
      });
    }
  }
}
