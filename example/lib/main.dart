import 'dart:math';

import 'package:example/fair_widget/delegate/test_fair_delegate.dart';
import 'package:example/fair_widget/plugin/fair_basic_plugin.dart';
import 'package:example/home_page.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FairApp.runApplication(
    FairApp(
      child: MyApp(),
      delegate: {
        ///此处delegate注册的key名必须与fairwidget页面name的名字一致,
        ///TestFairDelegate只作用于相同名字的fairwidget
        'assets/fair/lib_fair_widget_fair_delegate_widget.fair.json': (ctx, _) => TestFairDelegate(),
      },
    ),
    ///需要在此注册需要全局使用的plugin,key名可以随意不做要求
    plugins: {
      "FairBasicPlugin": FairBasicPlugin(),
    },
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

Color randomColor() {
  return Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
}
