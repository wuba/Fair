import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairDeviceInfoWidget extends StatefulWidget {
  final String title;

  FairDeviceInfoWidget({Key key, this.title}) : super(key: key);

  @override
  _FairDeviceInfoWidgetState createState() {
    return _FairDeviceInfoWidgetState();
  }
}

class _FairDeviceInfoWidgetState extends State<FairDeviceInfoWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.title
        ),
      ),
    );
  }
}