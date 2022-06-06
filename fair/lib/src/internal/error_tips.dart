/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'warning_dialog_widget.dart';

class WarningWidget extends StatelessWidget {
  final String? name;
  final String? url;
  final String? solution;
  final dynamic error;
  final BuildContext?  parentContext;


  const WarningWidget({Key? key, this.name, this.url, this.error, this.solution,this.parentContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(child: Scrollbar(
        child: SingleChildScrollView(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Failure!',
                   style:  TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Color(0xff000000),
                     fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Tag: $name',
                   style:  TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Color(0xffff0000),
                     fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Bundle: $url',
                   style:  TextStyle(
                      color: Color(0xff000000),
                      fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Error: $error',
                  style:  TextStyle(
                     color: Color(0xff000000),
                     fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                 'Solution: $solution',
                  style:  TextStyle(
                     color: Color(0xff000000),
                     fontWeight: FontWeight.bold,
                     fontSize: 20.0,
                  ),
                ),
                RaisedButton(
                  child: Text('Click the button for details'),
                  color: Theme.of(context).accentColor,
                  onPressed: (){
                    warningShow();
                  },
                ),
              ],
            ),
          ),

        ),
      ),);
  }

  void warningShow(){
    showDialog(
        context: parentContext!,
        barrierDismissible: false,
        builder: (BuildContext context){
          return DialogWidget(
            name: name,
            url: url,
            solution: solution,
            error: error,
            cancelFun: (){
                 Navigator.pop(parentContext!);
            },
          );
        }
    );
  }



}
