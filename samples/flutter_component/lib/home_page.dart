/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/slidable_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'theme.dart';

@FairPatch()
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @FairWell('_counter')
  int _counter = 0;

  @FairWell('_check')
  bool _check = false;

  @FairWell('_incrementCounter')
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _putPhotoCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              '$_counter',
              style: ThemeStyle.headline4(context),
            ),
            Text(
              '$_check',
              style: ThemeStyle.headline4(context),
            ),
            CustomWidget(
              title: "Test",
            ),
            //AnimateWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

//@FairWell('_putPhotoCheck')
  void _putPhotoCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('survey_permission_check1', true);
    _getPhotoCheck();
  }

//@FairWell('_getPhotoCheck')
  void _getPhotoCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _check = prefs.getBool('survey_permission_check1');
    setState(() {
      _check = _check;
    });
  }
}
