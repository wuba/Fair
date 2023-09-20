import 'package:fair/fair.dart';
import 'package:fair_extension/navigator/fair_navigator_plugin.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairNavigatorSample extends StatefulWidget {
  @override
  _FairNavigatorSampleState createState() => _FairNavigatorSampleState();
}

class _FairNavigatorSampleState extends State<FairNavigatorSample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FairNavigator示例'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: jumpPushNamed, child: const Text('路由表跳转')),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: jumpPushNamedWithParams,
                    child: const Text('路由表跳转&传参')),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: jumpPushFairPath,
                    child: const Text('Fair动态化页面跳转')),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: jumpPushFairPathWithParams,
                    child: const Text('Fair动态化页面跳转&传参')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void jumpPushNamed() {
    FairNavigator.pushNamed(routeName: 'flutter_page_for_fair_navigator');
  }

  void jumpPushNamedWithParams() {
    FairNavigator.pushNamed(
        routeName: 'flutter_page_for_fair_navigator',
        arguments: {
          'page_name':'使用FairNavigator传参到Flutter页面',
          'button_list': [
            'one',
            'two',
            'three',
            'four',
            'five',
          ],
        });
  }

  void jumpPushFairPath() {
    FairNavigator.pushFairPath(
        fairPath:
            'assets/fair/lib_navigator_fair_page_for_fair_navigator.fair.json',
        fairName: 'lib_navigator_fair_page_for_fair_navigator');
  }

  void jumpPushFairPathWithParams() {
    FairNavigator.pushFairPath(
        fairPath:
            'assets/fair/lib_navigator_fair_page_for_fair_navigator.fair.json',
        fairName: 'lib_navigator_fair_page_for_fair_navigator',
        arguments: {
          'page_name':'使用FairNavigator传参到Fair页面',
          'button_list': [
            'one',
            'two',
            'three',
            'four',
            'five',
          ],
        });
  }
}
