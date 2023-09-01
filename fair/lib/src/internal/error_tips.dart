/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/src/internal/stack_trace_detail.dart';
import 'package:flutter/material.dart';

import 'warning_dialog_widget.dart';

class WarningWidget extends StatelessWidget {
  final String? name;
  final String? url;
  final String? solution;
  final dynamic error;
  final BuildContext?  parentContext;
  final String? stackTrace;
  final Map? errorBlock;
  final List<int>? highlightLines;


  const WarningWidget(
      {Key? key,
      this.name,
      this.url,
      this.error,
      this.solution,
      this.parentContext,
      this.stackTrace,
      this.errorBlock,
      this.highlightLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(child: Scrollbar(
      child: SingleChildScrollView(
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: (){
                  warningShow();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage('packages/fair/assets/images/error.jpg'),
                      width: 80,
                      height: 80,
                    ),
                    Text('click show message!')
                  ],
                ),
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
            stackTraceVisible: stackTrace != null,
            viewStackTrace: () {
              Navigator.push(
                  parentContext!,
                  MaterialPageRoute(
                      builder: (context) =>
                          StackTraceDetailPage(
                            stackTrace: stackTrace!,
                            name: name,
                            errorJson: errorBlock,
                            error: error,
                            highlightLines: highlightLines,
                          )));
            },
          );
        }
    );
  }



}
