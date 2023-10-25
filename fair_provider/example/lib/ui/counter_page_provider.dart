import 'package:example/entity/counter_model.dart';
import 'package:example/entity/login_model.dart';
import 'package:fair/fair.dart';
import 'package:fair_provider/fair_provider.dart';
import 'package:flutter/material.dart';

@FairPatch()
class CounterPageProvider extends StatefulWidget {
  const CounterPageProvider({super.key});

  @override
  State<CounterPageProvider> createState() => _CounterPageProviderState();
}

class _CounterPageProviderState extends State<CounterPageProvider> {
  var title = "我是写在js侧的title";

  var counterModelJson = '''
{
    "count":22,
    "testName":"zzzzzz",
    "someModel":{
        "a":"ffffff"
    }
}
      ''';

  var loginModelJson = '''
        {
    "account":"qwerty12345",
    "password":"zxcv54321"
}
      ''';

  var counterModelJson2 = '''
{
    "count":333,
    "testName":"testName的初始值",
    "someModel":{
        "a":"someModel中a的初始值"
    }
}
      ''';

  void onLoad() {}

  void onUnload() {}

  void _incrementCounter(FairContext context) {
    var counterModel = context.read<CounterModel>("CounterModel");
    counterModel.count++;
    counterModel.testName = "及哦飞机佛IE我房间";
    counterModel.someModel?.a = "hahahaha";
    counterModel.notify();
  }

  @override
  Widget build(BuildContext context) {
    return FairChangeNotifierProvider<CounterModel>(
      initialJson: counterModelJson,
      child: FairChangeNotifierProvider<LoginModel>(
        initialJson: loginModelJson,
        child: FairChangeNotifierProvider<CounterModel>(
          initialJson: counterModelJson2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                title,
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  FairConsumer<CounterModel>(
                    builder: FairSugarProvider.consumerBuilder((context, value,
                            child) =>
                        Text(FairSugarProvider.anyToString(
                            FairSugarProvider.valueReader(value, 'count')))),
                  ),
                  FairConsumer<CounterModel>(
                    builder: FairSugarProvider.consumerBuilder(
                        (context, value, child) => Text(
                            FairSugarProvider.stringValueReader(
                                value, 'testName'))),
                  ),
                  FairSelector<CounterModel, String>(
                      builder: FairSugarProvider.selectorBuilder(
                          (context, value, child) => Text(value)),
                      selector: FairSugarProvider.selector((context, value) =>
                          FairSugarProvider.evaluationToString(
                              value, 'someModel.a'))),
                ],
              ),
            ),
            floatingActionButton: FairContextBuilder(
              builder: FairSugarProvider.widgetBuilder(
                  (context) => FloatingActionButton(
                        onPressed: () {
                          _incrementCounter(context);
                        },
                        tooltip: 'Increment',
                        child: const Icon(Icons.add),
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
