import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:sugar_demo/sugar_elseif_test_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
    getApp(),
  );

}

FairApp getApp() => FairApp(
  modules: const {
  },
  delegate: const {
  },
  child: MaterialApp(
    color: Colors.blue,
    home: //SugarElseIfPage(fairProps: json.encode({'value':1}),)
    FairWidget(
        name: 'DynamicWidget',
        path: 'assets/bundle/lib_sugar_elseif_test_page.fair.json',
        data: {"fairProps": json.encode({'value':1})}),
  ),
);

