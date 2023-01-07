// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
  test('test package split', () {
    var e = 'package:smooth_star_rating/smooth_star_rating.dart';
    expect(e.substring(e.indexOf(':')+1, e.indexOf('/')), "smooth_star_rating");
    expect(e.substring(0, e.indexOf(':')), "package");
  });

  /// covert `package://` into `file:///` path
  List<String> _package2path(Iterable<String> packageList) {
    var nameMap = <String, String>{};
    packageList.forEach((e) {
      final end = e.indexOf('/');
      nameMap.putIfAbsent(e.substring(e.indexOf(':') + 1, end),
              () => e.substring(end + 1).trimRight());
    });

    var p = File('.packages');
    if (p.existsSync()) {
      final localPackagePaths = p.readAsLinesSync();
      var packagesMap = <String, String>{};
      localPackagePaths.forEach((e) {
        final end = e.indexOf(':');
        packagesMap.putIfAbsent(
            e.substring(0, end), () => e.substring(end + 1).trimRight());
      });
      return nameMap
          .map((key, value) => MapEntry(key, packagesMap[key]! + value))
          .values.toList();
    }
    return [];
  }

  test('parse package', () {
    final fairPackage = File('fair.package');
    if (fairPackage.existsSync() && fairPackage.lengthSync() > 0) {
      print('===========> found custom package $fairPackage');
      final packageList = fairPackage
          .readAsLinesSync()
          .toSet()
          .where((l) => !l.startsWith('#'));
      _package2path(packageList).forEach((element) {
        print(element);
      });
    }
  });
}
