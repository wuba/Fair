import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/src/generated.fair.dart';

import 'delegate.dart';
import 'home_page.dart';
import 'module.dart';

@FairBinding(packages: ['package:flutter_component/slidable_widget.dart',
  'package:flutter_slidable/flutter_slidable.dart',
  'package:animated_text_kit/src/rotate.dart',
  'package:bottom_navy_bar/bottom_navy_bar.dart'])
void main() {
  runApp(FairApp(
    child: MyApp(),

    modules: {
      SlidableModule.tagName:() => SlidableModule(),
      //BottomNavyBarModule.tagName:() => BottomNavyBarModule(),
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
