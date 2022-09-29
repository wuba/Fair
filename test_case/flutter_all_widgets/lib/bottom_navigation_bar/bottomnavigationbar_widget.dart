
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairBottomNavigationBarPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FairBottomNavigationBarPageState();

}

class _FairBottomNavigationBarPageState extends State<FairBottomNavigationBarPage>{
  int _currentIndex = 0;

  void setCurrentIndex(int index){
    setState(() {
      _currentIndex = index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fair BottomNavigationBar'),
      ),
      bottomNavigationBar:BottomNavigationBar(
        onTap: setCurrentIndex,
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