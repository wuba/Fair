
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class BottomSheetDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomSheetDemo'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text('Flutter BottomSheet'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlutterBottomSheetPage()));
            },
          ),
          ElevatedButton(
            child: Text('Fair BottomSheet'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FairWidget(path: 'assets/bundle/bottomsheet/lib_bottomsheet_bottomsheet_widget.fair.json',)));
            },
          )
        ],
      ),
    );
  }

}

class FlutterBottomSheetPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FlutterBottomSheetPageState();

}

class _FlutterBottomSheetPageState extends State<FlutterBottomSheetPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BottomSheet'),
      ),
      body: Center(),
      bottomSheet: BottomSheet(
        onClosing: (){
          print('flutter bootomsheet close');
        },
        builder: (context){
          return Container(
            height: 300,
              color: Colors.amberAccent,
            alignment: Alignment.centerLeft,
            child: Text('BottomSheet in Scaffold'),
          );
        },
      ),
    );
  }

}