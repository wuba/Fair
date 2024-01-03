import 'package:example/fair_widget/plugin/fair_basic_plugin.dart';
import 'package:example/fair_widget/plugin/fair_common_plugin.dart';
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
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: callPhone,
                    child: Text('拨打电话-基于FairBasicPlugin')),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: commonHttp,
                    child: Text('网络请求-基于FairCommonPlugin')),
              ),
            ],
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

  commonHttp() {
    FairCommonPlugin().http({
      'method': 'GET',
      'url':
          'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/3b8ae7a4e0884b4d75b8094f6c83cd8c_list_page_data.json',
      'callback': (dynamic result) {
        if (result != null) {
          var statusCode = result['statusCode'];
          if (statusCode == 200) {
            var list = result['data']['data'];
            list.forEach((item) {
              var icon = item['icon'];
              print('icon = $icon');
            });
          }
        }
      }
    });
  }

}