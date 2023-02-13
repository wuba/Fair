import 'package:fair_online/app/app_initializer.dart';
import 'package:fair_online/base/components/no_glow_scroll_behavior.dart';
import 'package:fair_online/app/globals.dart';
import 'package:fair_online/models/api_call_model.dart';
import 'package:fair_online/models/custom_code_model.dart';
import 'package:fair_online/models/dependency_file_model.dart';
import 'package:fair_online/models/page_model.dart';
import 'package:fair_online/models/project_model.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/utils/device_utils.dart';
import 'package:fair_online/views/project/project_page.dart';
import 'package:fair_online/views/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/app_model.dart';
import 'models/dart_editor_model.dart';
import 'models/fair_dsl_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AppModel()),
      ChangeNotifierProvider.value(value: DartEditorModel()),
      ChangeNotifierProvider.value(value: FairDslModel()),
      ChangeNotifierProvider.value(value: ProjectModel()),
      ChangeNotifierProvider.value(value: PageListModel()),
      ChangeNotifierProvider.value(value: ApiCallModel()),
      ChangeNotifierProvider.value(value: CustomCodeModel()),
      ChangeNotifierProvider.value(value: ApiCallModel()),
      ChangeNotifierProvider.value(value: DependencyFileModel())
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<WelcomePageState> _welcomePageKey = GlobalKey();
  final GlobalKey<WelcomePageState> _projectPageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    AppInitializer().init();
    DeviceUtils.requestFingerId(() {
      //标记初始化完毕
      context.read<AppModel>().hasInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasInitialized =
        context.select<AppModel, bool>((value) => value.hasInitialized);

    /// Bind to AppModel.theme and get current theme
    ThemeType themeType =
        context.select<AppModel, ThemeType>((value) => value.theme);
    AppTheme theme = AppTheme.fromType(themeType);

    return Provider.value(
      value: theme, // Provide the current theme to the entire app
      child: MaterialApp(
        title: "Fair Online Platform",
        debugShowCheckedModeBanner: false,
        navigatorKey: AppGlobals.rootNavKey,

        /// Pass active theme into MaterialApp
        theme: theme.themeData,

        /// Home defaults to SplashView, BootstrapCommand will load the initial page
        home: hasInitialized
            ? AppInitializer.hasVisited()
                ? ProjectPage(key: _projectPageKey)
                : WelcomePage(key: _welcomePageKey)
            : Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              ),

        /// Wrap root navigator in various styling widgets
        builder: (_, navigator) {
          if (navigator == null) return Container();
          // Wrap root page in a builder, so we can make initial responsive tweaks based on MediaQuery
          return Builder(builder: (c) {
            // Disable all Material glow effects with [ NoGlowScrollBehavior ]
            return ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: navigator,
            );
          });
        },
      ),
    );
  }
}
