import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidables/src/generated.fair.dart';

import 'delegate.dart';

@FairBinding(packages: [
  'package:flutter_slidable/flutter_slidable.dart',])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(FairApp(
    child: MyApp(),
    // modules: {
    //   SlidableModule.tagName:() => SlidableModule(),
    // },
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
