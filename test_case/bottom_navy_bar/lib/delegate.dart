/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:ui';

import 'package:fair/fair.dart';

import 'theme.dart';

class MyHomePageDelegate extends FairDelegate {
  int _currentIndex = 0;


  void onItemSelect(index){
    print(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['_currentIndex']=()=>_currentIndex;
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['onItemSelect'] = (props) => onItemSelect(props);
    return fun;
  }
}
