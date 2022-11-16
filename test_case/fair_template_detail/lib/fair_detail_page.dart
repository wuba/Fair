import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:fair_template/fair_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FairDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fair Detail Template',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: FairDetail(),
      home: FairWidget(
        path: 'assets/bundle/lib_fair_detail.fair.json',
        data: {
          'fairProps': jsonEncode({
            'auth': 'Internal Team',
            'title': 'Kickoff Meeting',
            'time':'8:00am',
            'location':'Kaleo Office - San Starbucks',
            'des':"Short description goes here and can ben more than one line. Two lines is the best lenth Short description goes here and can ben more than one line. Two lines is the best lenth",
            'detail':
                "Drag-and-drop builder and no-code configuration make it easy to add chat to your app. Professionally designed templates and custom styling will take your app to the next level.Drag-and-drop builder and no-code configuration make it easy to add chat to your app. Professionally designed templates and custom styling will take your app to the next level. Drag-and-drop builder and no-code configuration make it easy to add chat to your app. Professionally designed templates and custom styling will take your app to the next level. "
          })
        },
      ),
    );
  }
}
