/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair_version/fair_version.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';


/// Show a dialog displaying the Fair information.
void showFairAboutDialog(BuildContext context) {
  void _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      assert(() {
        throw 'Could not launch $url';
      }());
    }
  }

  final textStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);
  final url = 'https://fair.58.com';
  final aboutBoxChildren = <Widget>[
    SizedBox(height: 24),
    RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              style: textStyle,
              text:
                  'Flutter Fair is an OTA package for Flutter Apps. With Fair you can update widgets of the app through DSL bundle.'
                  ' Learn more about Fair at '),
          TextSpan(
              style: textStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
              recognizer: TapGestureRecognizer()..onTap = () => _openUrl(url),
              text: url),
          TextSpan(style: textStyle, text: '.'),
        ],
      ),
    ),
  ];

  showAboutDialog(
      context: context,
      applicationIcon: FlutterLogo(),
      applicationName: 'Flutter Fair v$fairVersion',
      applicationVersion: 'Compatible with Flutter v$flutterVersion',
      applicationLegalese: '© 2020 The Fair Authors',
      children: aboutBoxChildren);
}
