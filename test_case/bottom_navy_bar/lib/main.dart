import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:bootom_navy_bars/src/generated.fair.dart';

import 'delegate.dart';
import 'module.dart';

@FairBinding(packages: [
  'package:bottom_navy_bar/bottom_navy_bar.dart',])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
      _getApp(),
      plugins: {

      });
}

dynamic _getApp() => FairApp(
  child: MyApp(),
  delegate: {
    //'home_page': (_, data) => MyHomePageDelegate(),
  },
  modules: {
    BottomNavyBarModule.tagName:() => BottomNavyBarModule(),
  },
  generated: AppGeneratedModule(),
);


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FairWidget(
        name: 'home_page',
        path: 'assets/bundle/lib_home_page.fair.json',
        data: {
          'title': 'Flutter Demo Home Page',
        },
      ) /*MyHomePage(title: 'Flutter Demo Home Page')*/,
    );
  }
}
