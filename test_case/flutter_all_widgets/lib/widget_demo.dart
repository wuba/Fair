import 'package:flutter/material.dart';
import 'package:flutter_all_widgets/outlinebutton/outlinebutton_demo.dart';

import 'checkbox/checkbox_demo.dart';
import 'cupertino_tabbar/cupertino_tabbar_demo.dart';

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

  Widget addWidget(BuildContext context,String title, Widget widget){
    return GestureDetector(
        child: Text(title),
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder:(context)=>widget));
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Widget Demo"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
//          GestureDetector(
//              child: Text("Text"),
//              onTap:(){
//                Navigator.push(context, MaterialPageRoute(builder:(context)=>TextDemo()));
//              }
//          ),
              addWidget(context,'OutlineButton',OutlineButtonDemo()),
              GestureDetector(
                  child: Text("Checkbox"),
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>CheckboxDemo()));
                  }
              ),
              GestureDetector(
                  child: Text("CupertinoTabBar"),
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>CupertinoTabBarDemo()));
                  }
              ),
            ],
          ),
        ],
      )
    );
  }

}
