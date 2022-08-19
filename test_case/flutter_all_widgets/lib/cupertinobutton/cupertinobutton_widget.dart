
import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';

@FairPatch()
class FairCupertinoButtonPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _FairCupertinoButtonPageState();

}

class _FairCupertinoButtonPageState extends State<FairCupertinoButtonPage>{

  void _onPressed(){

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CupertinoButton(
            onPressed: null,
            child: Text('Disabled'),
          ),
          const SizedBox(height: 30),
          const CupertinoButton.filled(
            onPressed: null,
            child: Text('Disabled'),
          ),
          const SizedBox(height: 30),
          CupertinoButton(
            onPressed: _onPressed,
            child: const Text('Enabled'),
          ),
          const SizedBox(height: 30),
          CupertinoButton.filled(
            onPressed: _onPressed,
            child: const Text('Enabled'),
          ),
        ],
      ),
    );
  }

}