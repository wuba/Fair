import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:sugar_demo_tabbar/home_page.dart';
import 'package:sugar_demo_tabbar/sugar_tabbar_activeItembuilder_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
    getApp(),
  );

}


FairApp getApp() => FairApp(
  modules: const {
  },
  delegate:  {
    'assets/bundle/lib_sugar_tabbar_page.fair.json': (ctx, _) => ActiveItemBuilderDelegate(
        [{'imageUrl': 'https://gd-hbimg.huaban.com/bb8f4ae6711528dc754799afe6b95d438481265d245ac-ROmreT_fw658','title':'比个耶','isSelected':true},
          {'imageUrl': 'https://gd-hbimg.huaban.com/bd8cc5148671f983bd24c4e505e4c4eeb10af2938408-k9V6J9_fw1200','title':'你瞅啥','isSelected':true},
          {'imageUrl':'https://gd-hbimg.huaban.com/cf52abaf5ff720d05321478104dfc0f7aabdd05936f5e-8ePNcm','title':'我打你哦','isSelected':false}]
    ),
  },
  child: MaterialApp(
      color: Color(0xFF1565C0),
      home:HomePage()

  ),
);

