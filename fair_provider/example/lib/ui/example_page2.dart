import 'package:example/entity/counter_model.dart';
import 'package:example/entity/top_model.dart';
import 'package:fair/fair.dart';
import 'package:fair_provider/fair_provider.dart';
import 'package:flutter/material.dart';

@FairPatch()
class ExamplePage2 extends StatefulWidget {
  const ExamplePage2({super.key});

  @override
  State<ExamplePage2> createState() => _ExamplePage2State();
}

class _ExamplePage2State extends State<ExamplePage2> {
  void onLoad() {}

  void onUnload() {}

  void _incrementCounter(FairContext context) {
    var topModel = context.read<TopModel>("TopModel");
    topModel.intField++;
    topModel.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "跨组件共享状态",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '监听TopModel中的intFiled:',
            ),
            FairConsumer<TopModel>(
              builder: SugarProvider.consumerBuilder(
                  (context, value, child) =>
                      Text(SugarProvider.readAsString(value, 'intField'))),
            ),
          ],
        ),
      ),
      floatingActionButton: FairContextBuilder(
        builder:
            SugarProvider.widgetBuilder((context) => FloatingActionButton(
                  onPressed: () {
                    _incrementCounter(context);
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                )),
      ),
    );
  }
}
