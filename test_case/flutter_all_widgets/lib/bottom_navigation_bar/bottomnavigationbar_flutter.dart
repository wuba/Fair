
import 'package:flutter/material.dart';

class FlutterBottomNavigationBarPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FlutterBottomNavigationBarPageState();

}

class _FlutterBottomNavigationBarPageState extends State<FlutterBottomNavigationBarPage>{
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BottomNavigationBar'),
      ),
      bottomNavigationBar:BottomNavigationBar(
        onTap: (int index){
         setState(() {
           _currentIndex = index;
         });
        },
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: '首页',icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '书籍',icon: Icon(Icons.book)),
          BottomNavigationBarItem(label: '我的',icon: Icon(Icons.perm_identity)),
        ],
      ),

    );
  }

}