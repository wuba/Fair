import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'alert_dialog_fair.dart';

class AlertDialogDemo extends StatelessWidget {
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Flutter Alert'),
              content: Text('我是CupertinoAlertDialog,请点击取消或确定退出'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('取消'),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('确定'),
                )
              ],
            ));
  }

  void _showFairAlertDialog(BuildContext context){
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => FairAlertDialogPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CupertinoAlertDialog"),
      ),
      body: Column(
        children: [
          CupertinoButton(
            onPressed: () => _showAlertDialog(context),
            child: const Text('Flutter Alert Click me'),
          ),
          CupertinoButton(
            onPressed: () => _showFairAlertDialog(context),
            child: const Text('Fair Alert Click me'),
          ),
        ],
      ),
    );
  }
}
