/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@FairPatch()
class MapPage extends StatefulWidget {
  var fairProps;

  MapPage(dynamic data) {
    fairProps = data;
  }

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MapPage> {
  @FairProps()
  var fairProps;

  var _list = [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 100];

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  String getTitle() {
    return fairProps['pageName'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTitle()),
        ),
        body: ListView(
          children: Sugar.map(_list, builder: (item) {
            return Container(
              padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Image.network(
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
                            width: 100.0,
                            height: 100.0,
                          ),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$item',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 17,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '君不见黄河之水天上来，奔流到海不复还',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 14,
                                          color: Colors.blueGrey),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}
