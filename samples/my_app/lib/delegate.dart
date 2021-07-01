/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:ui';

import 'package:fair/fair.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

class MyHomePageDelegate extends FairDelegate {
  int _counter = 0;
  bool _check = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _putPhotoCheck();
  }

  void _putPhotoCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('survey_permission_check',true);

    _getPhotoCheck();
  }

  void _getPhotoCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check = prefs.getBool('survey_permission_check');
    setState(() {
      _check = check;
    });
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['_counter'] = () => _counter;
    value['_color'] = () => const Color(0xffff0000);
    value['_check']= () => _check;
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_incrementCounter'] = _incrementCounter;
    fun['ThemeStyle.headline4'] = (props) => ThemeStyle.headline4(context);
    fun['putPhotoCheck'] = (props) => _putPhotoCheck;
    fun['getPhotoCheck'] = (props) => _getPhotoCheck;
    //fun['AJKColors.ajkPrimaryColor'] = () => AJKColors.ajkPrimaryColor;
    return fun;
  }
}
