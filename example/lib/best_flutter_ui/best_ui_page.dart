import 'dart:io';

import 'package:example/best_flutter_ui/app_theme.dart';
import 'package:example/best_flutter_ui/navigation_home_screen.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@FairBinding(packages: [
  'package:font_awesome_flutter/font_awesome_flutter.dart',
  'package:smooth_star_rating_nsafe/smooth_star_rating.dart'
])
class BestUiPage extends StatefulWidget {
  const BestUiPage({Key? key}) : super(key: key);

  @override
  State<BestUiPage> createState() => _BestUiPageState();
}

class _BestUiPageState extends State<BestUiPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
      Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Theme(data: ThemeData(
      primarySwatch: Colors.blue,
      textTheme: AppTheme.textTheme,
      platform: TargetPlatform.iOS,
    ), child: NavigationHomeScreen());

    // return MaterialApp(
    //   title: 'Flutter UI',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     textTheme: AppTheme.textTheme,
    //     platform: TargetPlatform.iOS,
    //   ),
    //   home: NavigationHomeScreen(),
    // );
  }
}
