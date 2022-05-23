import 'dart:developer';

import 'package:demo/my_home_page_delegate.dart';
import 'package:demo/src/generated.fair.dart';
import 'package:fair/fair.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    FairApp(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Counter()),
        ],
        child: const MyApp(),
      ),
      generated: AppGeneratedModule(),
    ),
  );
}

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var count = context.watch<Counter>().count;
    log('$count');
    return MaterialApp(
      home: FairWidget(
        key: Key('counterState$count'),
        path: 'assets/bundle/lib_my_home_page.fair.json',
        data: {'count': count},
        delegate: MyHomePageDelegate(),
      ),
    );
  }
}
