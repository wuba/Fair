import 'package:flutter/material.dart';

import 'checkbox/checkbox_demo.dart';

class WidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "All Widget Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomePage()
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Widget Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
//          GestureDetector(
//              child: Text("Text"),
//              onTap:(){
//                Navigator.push(context, MaterialPageRoute(builder:(context)=>TextDemo()));
//              }
//          ),
          GestureDetector(
              child: Text("Checkbox"),
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>CheckboxDemo()));
              }
          ),
        ],
      ),
    );
  }

}
