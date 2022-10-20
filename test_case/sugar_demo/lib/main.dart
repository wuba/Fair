import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:sugar_demo/sugar_elseif_test_page.dart';
import 'person.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
    getApp(),
  );

}

class TestGeneratedModule implements GeneratedModule{
  @override
  Map<String, dynamic> components() {
    return {
      'Person': Person.from
    };
  }

  @override
  Map<String, bool> mapping() {
    return const {
      'Person':false
    };
  }

}

FairApp getApp() => FairApp(
  modules: const {
  },
  delegate: const {
  },
  generated: TestGeneratedModule(),
  child: MaterialApp(
    color: Colors.blue,
    home:
    // SugarElseIfPage(fairProps: json.encode({'value':1}),)
    FairWidget(
        name: 'DynamicWidget',
        path: 'assets/bundle/lib_sugar_elseif_test_page.fair.json',
        data: {"fairProps": json.encode({'value':1})}),
  ),
);

