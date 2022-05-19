import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class DeviceInfoPage extends StatefulWidget {
  Map<String, dynamic>? params;

  DeviceInfoPage({Key? key, this.params}) : super(key: key);

  @override
  _DeviceInfoPageState createState() {
    return _DeviceInfoPageState();
  }
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {

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
    return FairWidget(
      name: "device_info",
      path: "assets/bundle/lib_device_info_fair_device_info_widget.fair.json",
      data: {
        'title': "Device Info Demo Page"
      },
    );
  }
}