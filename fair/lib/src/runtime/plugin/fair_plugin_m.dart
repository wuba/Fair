/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';

class FairMethod {
  void call(String className, String methodName, {Map? args}) {
    var fairReq = {
      'isDart': true,
      'className': '$className#$methodName',
      'args': args,
    };
    FairPluginDispatcher.dispatch(fairReq);
  }
}

void main() {
  FairMethod().call('WBPermission', 'photoPermission', args: {
    'Granted': (resp) {
      print('success__result');
    },
    'Restricted': (resp) {
      print('failure__result');
    },
  });
}
