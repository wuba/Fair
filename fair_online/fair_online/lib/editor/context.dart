library context;

import 'services/dartservices.dart';

abstract class ContextBase {
  bool get isFocused;
  String get dartSource;
  String get htmlSource;
  String get cssSource;
}

abstract class Context implements ContextBase {
  final List<AnalysisIssue> issues = [];

  String get focusedEditor;
  @override
  bool get isFocused => focusedEditor == 'dart';

  String? name;
  String? description;

  @override
  String dartSource = '';

  @override
  String htmlSource = '';

  @override
  String cssSource = '';

  String get activeMode;
  Stream<String> get onModeChange;
  void switchTo(String name);
}
