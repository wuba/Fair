import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:nestedscrollview_test/src/home.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
      _getApp(),
      plugins: {

      });
}

dynamic _getApp() => FairApp(
  child: MaterialApp(home: MyApp()),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      FairWidget(
        name: 'NestedScrollview_test',
        path: 'assets/bundle/lib_src_home.fair.json',
      )
      // Home(),
    );
  }
}
