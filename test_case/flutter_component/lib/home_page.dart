/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/slidable_widget.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:animated_text_kit/src/rotate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'theme.dart';

@FairPatch()
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = ""}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @FairWell('_counter')
  int _counter = 0;

  @FairWell('_check')
  bool _check = false;

  @FairWell('_currentIndex')
  int _currentIndex = 0;

  @FairWell('_incrementCounter')
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    // _putPhotoCheck();
  }

  _onPressed(){

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
            Sugar.listBuilder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomWidget(
                    title: "Test",
                  );
                }),
            IconButton(
              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                icon: FaIcon(FontAwesomeIcons.solidCircle), onPressed: _onPressed,
            ),
            RotateAnimatedTextKit(
                text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
                textStyle: TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
                textAlign: TextAlign.start,
                alignment: Alignment.topLeft
              // or Alignment.topLeft )
            )
            //AnimateWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: onItemSelect,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Item One'), icon: Icon(Icons.home)),
          BottomNavyBarItem(title: Text('Item Two'), icon: Icon(Icons.apps)),
          BottomNavyBarItem(
              title: Text('Item Three'), icon: Icon(Icons.chat_bubble)),
          BottomNavyBarItem(
              title: Text('Item Four'), icon: Icon(Icons.settings)),
        ],
      ),
    );
  }

// //@FairWell('_putPhotoCheck')
//   void _putPhotoCheck() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('survey_permission_check1', true);
//     _getPhotoCheck();
//   }
//
// //@FairWell('_getPhotoCheck')
//   void _getPhotoCheck() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if(prefs.getBool('survey_permission_check1') != null) {
//       _check = prefs.getBool('survey_permission_check1')!;
//     }
//     setState(() {
//       _check = _check;
//     });
//   }

  @FairWell('onItemSelect')
  void onItemSelect(index) {
    print(index);
    setState(() {
      _currentIndex = index;
    });
  }

}
