import '../../fair_common.dart';
import 'package:flutter/material.dart';

@FairPreviewPage()
class FairPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fair 预览'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[],
        ),
      ),
    );
  }

  Widget addItem(String itemName, dynamic onPress) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.centerLeft,
        color: Colors.white,
        height: 100,
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          itemName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
