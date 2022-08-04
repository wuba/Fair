
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class AppBarDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar'),
        actions: [
          IconButton(onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          }, icon: Icon(Icons.add_alert)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context){
                return  FairWidget(
                  path: 'assets/bundle/appbar/lib_appbar_appbar_widget.fair.json',
                );
              }
            ));
          },
              icon: Icon(Icons.navigate_next),
              tooltip:'Go to the next page')
        ],
      ),
      body: Center(
        child: Text('This is the flutter page',style: TextStyle(fontSize:24 ),),
      ),
    );
  }
  
}