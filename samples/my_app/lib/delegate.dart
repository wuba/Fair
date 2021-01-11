/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';

import 'theme.dart';

class MyHomePageDelegate extends FairDelegate {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['_counter'] = () => _counter;
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_incrementCounter'] = _incrementCounter;
    fun['ThemeStyle.headline4'] = (props) => ThemeStyle.headline4(context);
    return fun;
  }
}
