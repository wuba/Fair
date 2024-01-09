import 'dart:developer';

import 'package:fair/fair.dart';
import 'package:fairmobx/counter.dart';
import 'package:fairmobx/text_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CounterExample extends StatefulWidget {
  const CounterExample();

  @override
  CounterExampleState createState() => CounterExampleState();
}

class CounterExampleState extends State<CounterExample> {
  final Counter counter = Counter();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('MobX Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Observer(builder: (_) {
                var state = counter.value;
                final textTheme = Theme.of(context).textTheme;
                log('$state');
                log('${textTheme.headline2}');
                return FairWidget(
                  wantKeepAlive: false,
                  name: "lib_text_widget",
                  key: Key('counterState$state'),
                  path: 'assets/bundle/lib_text_widget.fair.json',
                  data: {'state': '$state', 'headline2': textTheme.headline2},
                );
              }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: counter.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
