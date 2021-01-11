/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:flutter/widgets.dart';

class WarningWidget extends StatelessWidget {
  final String name;
  final String url;
  final dynamic error;

  const WarningWidget({Key key, this.name, this.url, this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Failure!\ntag=$name\nbundle=$url\n$error'));
  }
}
