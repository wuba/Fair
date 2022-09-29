import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairBottomSheetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FairBottomSheetPageState();

}

class _FairBottomSheetPageState extends State<FairBottomSheetPage> {

  void onClosing() {
    print('fair bootomsheet close');
  }

  Widget _bottomWidget(context) {
      return Container(
        height: 300,
        color: Colors.amber,
        alignment: Alignment.centerLeft,
        child: Text('BottomSheet in Scaffold'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fair BottomSheet'),
      ),
      body: Center(),
      bottomSheet: BottomSheet(
        onClosing: onClosing,
        builder: _bottomWidget,
      ),
    );
  }

}