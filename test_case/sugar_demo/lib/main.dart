import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'person.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
    getApp(),
  );
}

class TestGeneratedModule implements GeneratedModule {
  @override
  Map<String, dynamic> components() {
    return {'Person': Person.from};
  }

  @override
  Map<String, bool> mapping() {
    return const {'Person': false};
  }
}

FairApp getApp() => FairApp(
      modules: const {},
      delegate: const {},
      generated: TestGeneratedModule(),
      child: MaterialApp(
        color: Colors.blue,
        home: FairWidget(
            name: 'DynamicWidget',
            path: Assets.assets_fair_lib_sugar_menu_fair_json,
            data: {
              "fairProps": json.encode({'value': 1})
            }),
      ),
    );
