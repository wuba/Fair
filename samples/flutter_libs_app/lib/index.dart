import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libs_app/routes.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildOperateBtn("device info page", (){
              FairRouter.push(context, RoutePath.deviceInfoPage);
            }),
            _buildOperateBtn("url launcher page", (){
              FairRouter.push(context, RoutePath.urlLauncherPage);
            }),
            _buildOperateBtn("google font page", (){
              FairRouter.push(context, RoutePath.googleFontPage);
            }),
            _buildOperateBtn("package info page", (){
              FairRouter.push(context, RoutePath.packageInfoPage);
            })
          ],
        ),
      ),
    );
  }

  Widget _buildOperateBtn(String name, Function callback){
    return GestureDetector(
      child: FlatButton(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
                vertical: 20
            ),
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87
              ),
            ),
          ),
        ),
        onPressed: (){
          callback?.call();
        },
      ),
    );
  }
}