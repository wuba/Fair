// ignore_for_file: prefer_function_declarations_over_variables, implementation_imports

import 'dart:io';

import 'package:fair/fair.dart';
import 'package:fair_gallery/fair_gallery_route.dart';
import 'package:fair_gallery/fair_gallery_routes.dart';
import 'package:fair_gallery/src/delegate/delegate_base.dart';
import 'package:fair_gallery/src/app_generated_module.dart';
import 'package:fair_gallery/src/plugin/fair_common_plugin.dart';
import 'package:fair_gallery/src/utils/dynamic_widget_builder.dart';
import 'package:fair_gallery/src/utils/fair_bindings.dart';
import 'package:fair_gallery/src/utils/js_decoder.dart';
import 'package:fair_gallery/src/utils/loader.dart';
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fair/src/internal/flexbuffer/fair_js_decoder.dart';
import 'package:fair_version/src/widgets/version.dart' as fair_version;
import 'package:fair_gallery/src/generated_module/flutter.bindings.dart'
    as local_version;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // mock 的 fair_version ，把本地的配置传给它
  fair_version.fairVersion = '3.22.2';
  fair_version.flutterVersion = local_version.flutterVersion;
  fair_version.dartVersion = local_version.dartVersion;
  fair_version.widgetCount = local_version.widgetCount;
  fair_version.apiCount = local_version.apiCount;

  FairJSDecoder.resolve = (String? jsPath) async {
    return CustomFairJSDecoder().decode(jsPath);
  };
  FairBindings.init();

  FairApp.runApplication(
      FairApp(
        generated: FairAppGeneratedModule(),
        child: const MyApp(),
        delegate: FairDelegateBase.delegates,
        dynamicWidgetBuilder: [
          (
            proxyMirror,
            page,
            bound, {
            bundle,
          }) =>
              CustomDynamicWidgetBuilder(
                proxyMirror,
                page,
                bound,
                bundle: bundle,
              ),
        ],
        bundleProvider: CustomFairBundleLoader(),
      ),
      plugins: <String, IFairPlugin>{'FairCommonPlugin': FairCommonPlugin()});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'FairGallery',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: MyApp.navigatorKey,
        initialRoute: Routes.fairMainPage.name,
        onGenerateRoute: (RouteSettings settings) {
          final FFRouteSettings ffRouteSettings = getRouteSettings(
            name: settings.name!,
            arguments: settings.arguments as Map<String, dynamic>?,
          );

          final WidgetBuilder builder = (BuildContext context) {
            if (ExtendedFairWidget.fairEnable(ffRouteSettings.exts) ||
                // maybe new fair page
                ffRouteSettings.name == FFRoute.notFoundName) {
              Widget page = ExtendedFairWidget(
                name: ffRouteSettings.name!,
                fairProps: settings.arguments as Map<String, dynamic>?,
                builder: (BuildContext b) {
                  return ffRouteSettings.builder();
                },
              );

              return page;
            }

            return ffRouteSettings.builder();
          };

          switch (ffRouteSettings.pageRouteType) {
            case PageRouteType.material:
              return MaterialPageRoute<dynamic>(
                settings: ffRouteSettings,
                builder: (BuildContext _) => builder(_),
              );
            case PageRouteType.cupertino:
              return CupertinoPageRoute<dynamic>(
                settings: ffRouteSettings,
                builder: (BuildContext _) => builder(_),
              );
            case PageRouteType.transparent:
              return FFTransparentPageRoute<dynamic>(
                settings: ffRouteSettings,
                pageBuilder: (
                  BuildContext _,
                  Animation<double> __,
                  Animation<double> ___,
                ) =>
                    builder(_),
              );
            default:
              return kIsWeb || !Platform.isIOS
                  ? MaterialPageRoute<dynamic>(
                      settings: ffRouteSettings,
                      builder: (BuildContext _) => builder(_),
                    )
                  : CupertinoPageRoute<dynamic>(
                      settings: ffRouteSettings,
                      builder: (BuildContext _) => builder(_),
                    );
          }
        },
      ),
    );
  }
}
