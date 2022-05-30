import 'package:example/fair_widget/plugin/fair_basic_plugin.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairPluginWidget extends StatefulWidget {
  const FairPluginWidget({Key? key}) : super(key: key);

  @override
  State<FairPluginWidget> createState() => _FairPluginWidgetState();
}

class _FairPluginWidgetState extends State<FairPluginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fair plugin介绍和使用"),
      ),
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: callPhone,
            child: Container(
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text('拨打电话'),
            ),
          ),
        ),
      ),
    );
  }

  callPhone(){
    FairBasicPlugin().call({
      'pageName': '#FairKey#',
      'args': {
        'type': 'Call',
        'phoneNumber': '15800342502',
        'response': (data) {
          print('response = $data');
        }
      }
    });
  }
}
