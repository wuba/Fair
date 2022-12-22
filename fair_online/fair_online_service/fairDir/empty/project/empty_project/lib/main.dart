import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:fair/fair.dart';
import 'package:fair_pushy/fair_pushy.dart';
import 'package:fair_pushy/src/files/fair_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'datasource/fair_test_data.dart';
import 'delegate/listview_common_delegate.dart';
import 'extension/ext.dart';
import 'fair_common.dart';
import 'fair_preview.dart';
import 'fair_widget_page.dart';
import 'src/module.fair.dart' as g;

@FairBinding(packages: [
  'package:flutter_staggered_grid_view/src/widgets/staggered_grid.dart',
  'package:flutter_staggered_grid_view/src/widgets/masonry_grid_view.dart',
])
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FairPushy.init(debug: true);
  var devPath = '';
  if (kIsWeb) {
    devPath = 'assets/fair';
  } else {
    var devDir = await FairFile.getMainFolder();
    devPath = '${devDir?.path}/files/debug';
  }

  //这里的path是item的fair bundle产物
  FairDevTools.fairWidgetBuilder = (name, path) {
    ///纯item模版展示逻辑，一般item不会有decoration，所以套一个scaffold
    if ((name as String).contains('_item')) {
      return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: FairWidget(name: name, path: path, data: {
          'fairProps': jsonEncode(dataLogicMap.fuzzyMatching(name)),
        }),
      );
    } else if (templateWithNoItem.fuzzyMatching(name)) {
      ///只有父布局动态化没有动态化item的模版/写死数据的模版以及listview_template展示逻辑
      return FairWidget(name: name, path: path, data: {
        'fairProps': jsonEncode(dataLogicMap.fuzzyMatching(name)),
      });
    } else {
      ///其他动态化component模版展示逻辑
      final dataSource = itemDataLogicMap.fuzzyMatching(name);
      return FairWidget(
          name: name,
          path: path,
          delegate: dataSource == null
              ? null
              : ListviewCommonDelegate(
                  path:
                      '$devPath/${name}_item.fair.json', //此处只兼容一种item的情况，后续可能需要扩展
                  dataSource:
                      itemDataLogicMap.fuzzyMatching(name)), //对应下标item数据源
          data: dataSource == null
              ? null
              : {
                  'fairProps': jsonEncode(dataLogicMap.fuzzyMatching(name)),
                  //外部列表动态化也可能会有数据源，但是目前demo模版没有，暂不处理
                });
    }
  };
  FairDevTools.config = FairDevConfig()
    ..addEnv(OnlineEnvInfo(
        envName: "环境1",
        updateUrl: "https://fangfe.58.com/fairapp/module_patch_bundle",
        readOnly: true))
    ..addEnv(OnlineEnvInfo(envName: "环境2", updateUrl: "", readOnly: false));

  FairApp.runApplication(
    FairApp(
      child: DevicePreview(
        backgroundColor: const Color(0xff15181B),
        enabled: true,
        tools: const [
          ...DevicePreview.defaultTools,
        ],
        builder: (context) => const App(),
      ),
      delegate: const {},
      generated: g.FairAppModule(),
    ),
    plugins: {'FairNet': FairNet()},
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fair',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Fair Home Page'),
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: ListView(
        children: [
          addItem("Fair 预览-云开发平台使用", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FairPreview(),
                ));
          }),
          addItem('Fair 开发者选项', () {
            FairDevTools.openDevPage(context);
          }),
          addItem('listview 示例', () {
            showWidget(
              fairPath:
                  'assets/fair/lib_page_hotel_listview_hotel_listview_template.fair.json',
              fairName: 'lib_page_hotel_listview_hotel_listview_template',
            );
          }),
        ],
      ),
    );
  }

  void showWidget({required fairPath, fairArguments, required fairName}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return FairWidgetPage(
        fairArguments: fairArguments,
        fairPath: fairPath,
        fairName: fairName,
      );
    }));
  }

  Widget addItem(String itemName, dynamic onPress) {
    return GestureDetector(
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
            )),
        onTap: onPress);
  }
}
