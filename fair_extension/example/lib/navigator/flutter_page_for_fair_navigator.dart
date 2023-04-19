import 'package:flutter/material.dart';

class FlutterPageForFairNavigator extends StatefulWidget {
  @override
  _FlutterPageForFairNavigatorState createState() =>
      _FlutterPageForFairNavigatorState();
}

class _FlutterPageForFairNavigatorState
    extends State<FlutterPageForFairNavigator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(args?['page_name'] ?? "路由表注册的Flutter页面"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('返回')),
              ),
              if (args != null && args['button_list']!=null) ...[
                ...(args['button_list'] as List<dynamic>).map((e) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          onPressed: () => {
                                setState(() {

                                })
                              },
                          child: Text(e)),
                    ))
              ]
            ],
          ),
        ),
      ),
    );
  }
}
