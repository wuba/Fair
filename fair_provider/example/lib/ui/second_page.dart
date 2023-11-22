import 'package:example/entity/top_model.dart';
import 'package:fair/fair.dart';
import 'package:fair_provider/fair_provider.dart';
import 'package:flutter/material.dart';

@FairPatch()
class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
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
          "状态共享-页面2",
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '监听TopModel中的intFiled:',
                  ),
                  FairConsumer<TopModel>(
                    builder: SugarProvider.consumerBuilder((context, value,
                            child) =>
                        Text(SugarProvider.readAsString(value, 'intField'))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FairContextBuilder(
        builder: SugarProvider.widgetBuilder((context) => FloatingActionButton(
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
