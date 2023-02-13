import 'dart:io';

import 'package:path/path.dart' as path;

String kFairCompileCode(String projectPath, String projectName) {
  return '''
/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'package:flutter/material.dart';
import 'package:fair_pushy/fair_pushy.dart';

class FairPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fair 预览'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          ${_routesCode(projectPath)}    
      ],
        ),
      ),
    );
  }

  Widget addItem(String itemName, dynamic onPress) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.centerLeft,
        color: Colors.white,
        height: 60,
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          itemName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
  
  void showWidget(BuildContext context, {required fairPath, required fairName}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return FairDevTools.fairWidgetBuilder(fairName, fairPath);
    }));
  }
}
  ''';
}

String _routesCode(String projectPath) {
  final bundlePath = path.join(projectPath, 'assets', 'fair');
  final bundleDirectory = Directory(bundlePath);
  return bundleDirectory.listSync().map((file) {
    if (path.extension(file.path, 2) == '.fair.json') {
      var basename = path.basename(file.path);
      var basenameWithoutExtension = path
          .basenameWithoutExtension(path.basenameWithoutExtension(file.path));
      return '''
      addItem('$basenameWithoutExtension', () {
                showWidget(
                  context,
                  fairName: '$basenameWithoutExtension',
                  fairPath: 'assets/fair/$basename',
              );
           }),
      Container(height: 1, color: Color(0xFFE7EBEE)),
      ''';
    } else {
      return '';
    }
  }).join();
}
