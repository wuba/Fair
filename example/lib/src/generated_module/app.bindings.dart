// flutterVersion = '3.13.9'
// dartVersion = '3.1.5'
// widgetCount = 2
// apiCount = 25
// ignore_for_file: unused_import, unnecessary_import, implementation_imports, unused_shown_name, deprecated_member_use, prefer_single_quotes, unused_element, unused_field, duplicate_import, prefer_const_constructors, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:example/fair_widget/fairbinding/fair_binding_widget.dart';
import 'package:example/best_flutter_ui/app_theme.dart';
import 'package:example/best_flutter_ui/hotel_booking/hotel_app_theme.dart';
import 'package:example/best_flutter_ui/component/composer_widget.dart';
import 'package:fair/fair.dart';

const String flutterVersion = '3.13.9';
const String dartVersion = '3.1.5';
const int widgetCount = 2;
const int apiCount = 25;

/// appComponents
Map<String, dynamic> appComponents = {
  'AppTheme.body1': AppTheme.body1,
  'AppTheme.body2': AppTheme.body2,
  'AppTheme.caption': AppTheme.caption,
  'AppTheme.chipBackground': AppTheme.chipBackground,
  'AppTheme.darkText': AppTheme.darkText,
  'AppTheme.dark_grey': AppTheme.dark_grey,
  'AppTheme.darkerText': AppTheme.darkerText,
  'AppTheme.deactivatedText': AppTheme.deactivatedText,
  'AppTheme.dismissibleBackground': AppTheme.dismissibleBackground,
  'AppTheme.display1': AppTheme.display1,
  'AppTheme.fontName': AppTheme.fontName,
  'AppTheme.grey': AppTheme.grey,
  'AppTheme.greyWithOpacity': AppTheme.greyWithOpacity,
  'AppTheme.headline': AppTheme.headline,
  'AppTheme.lightText': AppTheme.lightText,
  'AppTheme.nearlyBlack': AppTheme.nearlyBlack,
  'AppTheme.nearlyWhite': AppTheme.nearlyWhite,
  'AppTheme.notWhite': AppTheme.notWhite,
  'AppTheme.spacer': AppTheme.spacer,
  'AppTheme.subtitle': AppTheme.subtitle,
  'AppTheme.textTheme': AppTheme.textTheme,
  'AppTheme.title': AppTheme.title,
  'AppTheme.white': AppTheme.white,
  'ComposerWidget': (props) => ComposerWidget(),
  'FairBindingWidget': (props) => FairBindingWidget(key: props['key']),
  'HotelAppTheme': (props) => HotelAppTheme(),
  'HotelAppTheme.buildLightTheme': (props) => HotelAppTheme.buildLightTheme(),
};

/// appMapping
Map<String, bool> appMapping = {
  'AppTheme.body1': false,
  'AppTheme.body2': false,
  'AppTheme.caption': false,
  'AppTheme.chipBackground': false,
  'AppTheme.darkText': false,
  'AppTheme.dark_grey': false,
  'AppTheme.darkerText': false,
  'AppTheme.deactivatedText': false,
  'AppTheme.dismissibleBackground': false,
  'AppTheme.display1': false,
  'AppTheme.fontName': false,
  'AppTheme.grey': false,
  'AppTheme.greyWithOpacity': false,
  'AppTheme.headline': false,
  'AppTheme.lightText': false,
  'AppTheme.nearlyBlack': false,
  'AppTheme.nearlyWhite': false,
  'AppTheme.notWhite': false,
  'AppTheme.spacer': false,
  'AppTheme.subtitle': false,
  'AppTheme.textTheme': false,
  'AppTheme.title': false,
  'AppTheme.white': false,
  'ComposerWidget': true,
  'FairBindingWidget': true,
  'HotelAppTheme': false,
  'HotelAppTheme.buildLightTheme': false,
};
