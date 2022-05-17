/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/src/rotate.dart';

@FairPatch()
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


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
            RotateAnimatedTextKit(
                text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
                textStyle: TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
                textAlign: TextAlign.start,
                isRepeatingAnimation: true,
                alignment: Alignment.centerRight
              // or Alignment.topLeft )
            )
            //AnimateWidget(),
          ],
        ),
      ),
    );
  }

}
