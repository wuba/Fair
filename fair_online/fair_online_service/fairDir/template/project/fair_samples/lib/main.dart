import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:fair/fair.dart';
import 'package:fair_pushy/fair_pushy.dart';
import 'package:fair_pushy/src/files/fair_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'fair_common.dart';
import 'fair_preview.dart';
import 'src/module.fair.dart' as g;

@FairBinding(packages: [
  'package:flutter_staggered_grid_view/src/widgets/staggered_grid.dart',
  'package:flutter_staggered_grid_view/src/widgets/masonry_grid_view.dart',
])
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FairPushy.init(debug: true);
  var devPath;
  if (kIsWeb) {
    devPath = 'assets/fair';
  } else {
    var devDir = await FairFile.getMainFolder();
    devPath = '${devDir?.path}/files/debug';
  }

  FairDevTools.fairWidgetBuilder = (name, path) {
    return FairWidget(name: name, path: path, data: {
      'fairProps': jsonEncode({}),
    });
  };
  FairDevTools.config = FairDevConfig()
    ..addEnv(OnlineEnvInfo(
        envName: '环境1',
        updateUrl: 'https://fangfe.58.com/fairapp/module_patch_bundle',
        readOnly: true))
    ..addEnv(OnlineEnvInfo(envName: '环境2', updateUrl: '', readOnly: false));

  FairApp.runApplication(
    FairApp(
      generated: g.FairAppModule(),
      child: DevicePreview(
        backgroundColor: const Color(0xff15181B),
        enabled: true,
        tools: const [
          ...DevicePreview.defaultTools,
        ],
        builder: (context) => const MyApp(),
      ),
    ),
    plugins: {'FairNet': FairNet()},
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fair Samples',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        'fair_page': (context) => FairWidget(
                name: _getParams(context, 'name'),
                path: _getParams(context, 'path'),
                data: {
                  'fairProps':
                      jsonEncode(_getData(context, _getParams(context, 'name')))
                }),
      },
    );
  }

  dynamic _getParams(BuildContext context, String key) =>
      (ModalRoute.of(context)?.settings.arguments is Map)
          ? (ModalRoute.of(context)?.settings.arguments as Map)[key]
          : null;

  dynamic _getData(BuildContext context, String name) {
    var data =
        Map.from((ModalRoute.of(context)?.settings.arguments as Map)['data']);
    data.addAll({'pageName': name});
    return data;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('fair组件模板'),
      ),
      body: ListView(
        children: [
          addItem('Fair 预览-云开发平台使用', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FairPreview(),
                ));
          }),
          addItem('Fair开发者选项', () {
            FairDevTools.openDevPage(context);
          }),

          /// 组件
          addItem('以下是 组件模板 ↓↓↓↓↓↓↓↓↓', () {}),
          addItem('Listview >>>', () {
            showWidget(
              fairName: 'lib_page_hotel_listview_hotel_listview_template',
              fairPath:
                  'assets/fair/lib_page_hotel_listview_hotel_listview_template.fair.json',
            );
          }),
          addItem('Scrollview >>>', () {
            showWidget(
              fairName: 'lib_page_scrollview_home_scrollview',
              fairPath:
                  'assets/fair/lib_page_scrollview_home_scrollview.fair.json',
            );
          }),
          addItem('Gridview >>>', () {
            showWidget(
              fairName: 'lib_page_gridview_gridview_template',
              fairPath:
                  'assets/fair/lib_page_gridview_gridview_template.fair.json',
            );
          }),
          addItem('PageView >>>', () {
            showWidget(
              fairName: 'lib_page_pageview_pageview_template',
              fairPath:
                  'assets/fair/lib_page_pageview_pageview_template.fair.json',
            );
          }),
          addItem('StaggeredView >>>', () {
            showWidget(
              fairName: 'lib_page_staggered_view_staggeredview_template',
              fairPath:
                  'assets/fair/lib_page_staggered_view_staggeredview_template.fair.json',
            );
          }),
          addItem('AppBar >>>', () {
            showWidget(
              fairName: 'lib_page_appbar_appbar_template',
              fairPath: 'assets/fair/lib_page_appbar_appbar_template.fair.json',
            );
          }),
          addItem('FAB >>>', () {
            showWidget(
              fairName: 'lib_page_fab_fab_template',
              fairPath: 'assets/fair/lib_page_fab_fab_template.fair.json',
            );
          }),
          addItem('Drawer >>>', () {
            showWidget(
              fairName: 'lib_page_drawer_drawer_template',
              fairPath: 'assets/fair/lib_page_drawer_drawer_template.fair.json',
            );
          }),
          addItem('以下是 页面模板 ↓↓↓↓↓↓↓↓↓', () {}),
          addItem('Login >>>', () {
            showWidget(
              fairName: 'lib_page_login_page_login_page_template',
              fairPath:
                  'assets/fair/lib_page_login_page_login_page_template.fair.json',
            );
          }),
          addItem('Detail >>>', () {
            showWidget(
              fairName: 'lib_page_detail_page_fair_detail',
              fairPath:
                  'assets/fair/lib_page_detail_page_fair_detail.fair.json',
            );
          }),
          addItem('ListPage >>>', () {
            showWidget(
              fairName: 'lib_page_list_page_list_page',
              fairPath: 'assets/fair/lib_page_list_page_list_page.fair.json',
            );
          }),
          addItem('ListCard >>>', () {
            showWidget(
              fairName: 'lib_page_list_card_moments_list',
              fairPath: 'assets/fair/lib_page_list_card_moments_list.fair.json',
            );
          }),
          addItem('TabBar >>>', () {
            showWidget(
              fairName: 'lib_page_tabbar_page_tabbar_page',
              fairPath:
                  'assets/fair/lib_page_tabbar_page_tabbar_page.fair.json',
            );
          }),
        ],
      ),
    );
  }

  void showWidget({required fairPath, required fairName}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return FairDevTools.fairWidgetBuilder(fairName, fairPath);
    }));
  }

  Widget addItem(String itemName, dynamic onPress) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
            alignment: Alignment.centerLeft,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 0.5))),
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              itemName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.left,
            )));
  }
}
