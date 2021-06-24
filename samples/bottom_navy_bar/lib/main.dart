import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:bootom_navy_bars/src/generated.fair.dart';

import 'delegate.dart';
import 'module.dart';

@FairBinding(packages: [
  'package:bottom_navy_bar/bottom_navy_bar.dart',
  'package:font_awesome_flutter/font_awesome_flutter.dart'])
void main() {
  runApp(FairApp(
    child: MyApp(),
    modules: {
      BottomNavyBarModule.tagName:() => BottomNavyBarModule(),
    },
    delegate: {
      'home_page': (_, data) => MyHomePageDelegate(),
    },
    generated: AppGeneratedModule(),
  ));
}

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
