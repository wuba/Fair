import 'package:fair/fair.dart';
import 'package:fairbloc/view/list_card_item.dart';
import 'package:fairbloc/view/moments_list.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
    _getApp(),
    plugins: {
    },
  );
}

dynamic _getApp() => FairApp(child:  MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      // MomentsList(),
      FairWidget(
        name: 'home_page',
        path: 'assets/bundle/lib_view_moments_list.fair.json',
      ),
    );
  }
}
