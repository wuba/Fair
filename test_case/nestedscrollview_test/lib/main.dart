import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:nestedscrollview_test/src/home.dart';

import 'src/absorb_pointer_page.dart';
import 'src/animated_opacity_page.dart';
import 'src/animated_positioned_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FairApp.runApplication(
      _getApp(),
      plugins: {

      });
}

dynamic _getApp() => FairApp(
  child: MaterialApp(home: MyApp()),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      // FairWidget(
      //   name: 'NestedScrollview_test',
      //   path: 'assets/bundle/lib_src_home.fair.json',
      // )
      // Home()
      // FairWidget(
      //   name: 'AbsorbPointer',
      //   path: 'assets/bundle/lib_src_absorb_pointer_page.fair.json',
      // )
        // MyStatelessWidget(),
    //   FairWidget(
    //   name: 'AnimatedOpacity',
    //   path: 'assets/bundle/lib_src_animated_opacity_page.fair.json',
    // ),
        // AnimatedOpacityPage(),
        FairWidget(
        name: 'AnimatedPositioned',
        path: 'assets/bundle/lib_src_animated_positioned_page.fair.json',
      ),
      // AnimatedPositionedPage()
    );
  }
}
