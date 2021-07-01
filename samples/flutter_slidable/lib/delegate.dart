/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';

class MyHomePageDelegate extends FairDelegate {

  void onTagClick(){
    print('11111');
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['onTagClick'] = onTagClick;
    return fun;
  }
}
