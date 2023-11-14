import 'package:example/entity/counter_model.dart';
import 'package:fair/fair.dart';
import 'package:fair_provider/fair_provider.dart';
import 'package:flutter/material.dart';

@FairPatch()
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  var counterModelJson = '''
{
    "count":22
}
      ''';

  void onLoad() {}

  void onUnload() {}

  void _incrementCounter(FairContext context) {
    var counterModel = context.read<CounterModel>("CounterModel");
    counterModel.count++;
    counterModel.notify();
  }

  @override
  Widget build(BuildContext context) {
    return FairChangeNotifierProvider<CounterModel>(
      initialJson: counterModelJson,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "计数器示例",
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
                builder: SugarProvider.consumerBuilder(
                    (context, value, child) =>
                        Text(SugarProvider.readAsString(value, 'count'))),
              ),
              FairSelector<CounterModel, int>(
                  builder:
                      SugarProvider.selectorBuilder((context, value, child) {
                    return Text(SugarProvider.anyToString(value));
                  }),
                  selector: SugarProvider.selector((context, value) =>
                      SugarProvider.readInt(value, 'count'))),
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
      ),
    );
  }
}
