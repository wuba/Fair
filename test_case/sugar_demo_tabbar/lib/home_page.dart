import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sugar_demo'),
        ),
        body: ListView(
          children: [
            addItem("TabBar", () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                // flutter
                // return SugarTabBarPage(fairProps: "");

                //fair
                return FairWidget(
                    name: 'assets/bundle/lib_sugar_tabbar_page.fair.json',
                    path: 'assets/bundle/lib_sugar_tabbar_page.fair.json',
                    data: {
                      'fairProps': json.encode([
                        {
                          'imageUrl':
                              'https://gd-hbimg.huaban.com/bb8f4ae6711528dc754799afe6b95d438481265d245ac-ROmreT_fw658',
                          'isSelected': true
                        },
                        {
                          'imageUrl':
                              'https://gd-hbimg.huaban.com/bd8cc5148671f983bd24c4e505e4c4eeb10af2938408-k9V6J9_fw1200',
                          'isSelected': true
                        },
                        {
                          'https://gd-hbimg.huaban.com/cf52abaf5ff720d05321478104dfc0f7aabdd05936f5e-8ePNcm':
                              false
                        }
                      ])
                    });
              }));
            }),
          ],
        ),
      ),
    );
  }

  Widget addItem(String itemName, dynamic onPress) {
    return GestureDetector(
        child: Container(
            alignment: Alignment.centerLeft,
            color: Colors.white,
            height: 100,
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              itemName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.left,
            )),
        onTap: onPress);
  }
}
