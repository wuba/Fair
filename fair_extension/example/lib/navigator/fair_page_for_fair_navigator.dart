import 'package:fair/fair.dart';
import 'package:fair_extension/navigator/fair_navigator_plugin.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairPageForFairNavigator extends StatefulWidget {
  FairPageForFairNavigator({Key? key, this.fairProps}) : super(key: key);

  dynamic fairProps;

  @override
  _FairPageForFairNavigatorState createState() =>
      _FairPageForFairNavigatorState();
}

class _FairPageForFairNavigatorState extends State<FairPageForFairNavigator> {
  @FairProps()
  var fairProps;

  String pageName = "";

  dynamic list = [];

  void onLoad() {
    if (fairProps && fairProps['page_name']) {
      pageName = fairProps['page_name'];
    }
    if (fairProps && fairProps['button_list']) {
      list = fairProps['button_list'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Sugar.ifEqualBool(isPageNameNull(),
                trueValue: () => const Text('Fair动态化页面'),
                falseValue: () => Text(pageName)),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(onPressed: back, child: const Text('返回')),
              ),
              Column(
                children: Sugar.mapEach<Widget, String>(
                    list,
                    (index, item) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              onPressed: () => null, child: Text('$item')),
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void back() {
    FairNavigator.pop();
  }

  bool isPageNameNull() {
    return pageName.isEmpty;
  }
}
