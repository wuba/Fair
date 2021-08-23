import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/generated.fair.dart';

import 'delegate.dart';

@FairBinding(packages: ['package:animated_text_kit/src/rotate.dart'])
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
        'home_page': (_, data) => MyHomePageDelegate(),
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
