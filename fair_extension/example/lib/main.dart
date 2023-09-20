import 'package:fair/fair.dart';
import 'package:fair_extension/fair_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fair_widget_page.dart';
import 'navigator/flutter_page_for_fair_navigator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
      FairApp(
        child: const MyApp(),
      ),
      plugins: FairExtension.plugins,
      jsPlugins: FairExtension.jsPlugins);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fair Extension Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Fair Extension Example'),
      navigatorKey: FairExtension.fairNavigatorKey,
      routes: {
        'flutter_page_for_fair_navigator': (context) => FlutterPageForFairNavigator(),
      },
    );
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
        title: const Text('Fair Extension Example'),
      ),
      body: ListView(
        children: [
          addItem('Network', () {
            showWidget(
              fairPath: 'assets/fair/lib_net_network_page.fair.json',
              fairName: 'lib_net_network_page',
            );
          }),
          addItem('Log', () {
            showWidget(
              fairPath: 'assets/fair/lib_log_log_page.fair.json',
              fairName: 'lib_log_log_page',
            );
          }),
          addItem('Permission + ImagePicker', () {
            showWidget(
              fairPath:
                  'assets/fair/lib_image_picker_image_picker_page.fair.json',
              fairName: 'lib_image_picker_image_picker_page',
            );
          }),
          addItem('Toast', () {
            showWidget(
              fairPath: 'assets/fair/lib_toast_toast_page.fair.json',
              fairName: 'lib_toast_toast_page',
            );
          }),
          addItem('UrlLauncher', () {
            showWidget(
              fairPath:
                  'assets/fair/lib_url_launcher_url_launcher_page.fair.json',
              fairName: 'lib_url_launcher_url_launcher_page',
            );
          }),
          addItem('Navigator', () {
            showWidget(
              fairPath:
                  'assets/fair/lib_navigator_fair_navigator_sample.fair.json',
              fairName: 'lib_navigator_fair_navigator_sample',
            );
          }),
        ],
      ),
    );
  }

  void showWidget({required fairPath, fairArguments, required fairName}) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
      return FairWidgetPage(
        fairArguments: fairArguments,
        fairPath: fairPath,
        fairName: fairName,
      );
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
