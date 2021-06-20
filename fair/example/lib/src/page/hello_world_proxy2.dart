/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:flutter/foundation.dart';

class HelloWorldDelegate2 extends FairDelegate {
  // void _bindAllFunc(Map data) {
  //   data.forEach((key, value) {
  //     bindFunction()
  //         .addAll({key: () => runtime.invokeMethod(pageName, value, null)});
  //   });
  // }
  //
  // void bindAll(Map allVariables) {
  //   //todo 这应该获取js中的数据
  //   _bindAllFunc({
  //
  //   });
  //   _bindAllValue({});
  // }
  //
  // void _bindAllValue(Map data) {
  //   data.forEach((key, value) {
  //     bindValue().addAll({key: () => createValueNotifier(key, value)});
  //   });
  // }
  //
  // final Map valueMap = {};
  //
  // dynamic createValueNotifier(key, value) {
  //   valueMap[key] = value;
  //   return valueMap[key];
  // }
  //
  // //纯数据驱动
  // void notifyValue(Map values) {
  //   values.forEach((key, value) {
  //     valueMap[key] = value;
  //   });
  //   setState(() {});
  // }
}
