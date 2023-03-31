import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class PopupMenuDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PopupMenuState();
}

class PopupMenuState extends State<PopupMenuDemo> {
  String _selectedMenu = '';

  void _onSelected(dynamic item) {
    setState(() =>_selectedMenu = item.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(itemBuilder:
            Sugar.popMenuButtonItemBuilder((context){
            return <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Item 1',
                child: Text('Item 1'),
              ),
              const PopupMenuItem<String>(
                value: 'Item 2',
                child: Text('Item 2'),
              ),
              const PopupMenuItem<String>(
                value: 'Item 3',
                child: Text('Item 3'),
              ),
              const PopupMenuItem<String>(
                value: 'Item 4',
                child: Text('Item 4'),
              ),
            ];
          }) ,
            onSelected: _onSelected,
          ),
        ],
      ),
      body: Center(
        child: Text('_selectedMenu:$_selectedMenu'),
      ),
    );
  }
}
