import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

import 'list_demo_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
    getApp(),
  );
}

FairApp getApp() => FairApp(
      modules: const {},
      delegate: const {},
      child: MaterialApp(
        color: Colors.blue,
        home:
            //  ListDemoPage()
            FairWidget(
                name: 'ListDemoPage',
                path: 'assets/bundle/lib_list_demo_page.fair.json',
                data: const {"": ""}),
      ),
    );
