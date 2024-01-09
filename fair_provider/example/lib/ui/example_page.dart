import 'package:example/entity/example_model.dart';
import 'package:fair/fair.dart';
import 'package:fair_provider/fair_provider.dart';
import 'package:flutter/material.dart';

@FairPatch()
class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  var exampleModelJson = '''
{
    "stringField":"字符串字段",
    "intField":22,
    "doubleField":3.3,
    "boolField":true,
    "listField":[1,2,3,4],
    "innerModel":{
        "innerBoolField":false
    }
}
      ''';

  var stringList = ['白日依山尽', '黄河入海流', '欲穷千里目', '更上一层楼'];
  var stringIndex = 0;

  var nestedList = [
    ['1', '2', '3', '4'],
    ['5', '6', '7', '8'],
    ['9', '10', '11', '12'],
    ['13', '14', '15', '16']
  ];
  var listIndex = 0;

  void onLoad() {}

  void onUnload() {}

  ///更新全部
  void _updateAll(FairContext context, FairContext context2) {
    var exampleModel = context.read<ExampleModel>("ExampleModel");
    if (stringIndex > 3) {
      stringIndex = 0;
    }
    exampleModel.stringField = stringList[stringIndex++];
    exampleModel.intField++;
    if (exampleModel.doubleField == 33.3) {
      exampleModel.doubleField = 66.6;
    } else {
      exampleModel.doubleField = 33.3;
    }
    exampleModel.boolField = !exampleModel.boolField;
    if (listIndex > 3) {
      listIndex = 0;
    }
    exampleModel.listField = nestedList[listIndex++];
    if (exampleModel.innerModel?.innerBoolField == true) {
      exampleModel.innerModel?.innerBoolField = false;
    } else {
      exampleModel.innerModel?.innerBoolField = true;
    }
    exampleModel.notify();
  }

  ///进度条变化
  void _onSliderChange(List input) {
    var progress = input[0];
    FairContext fairContext = input[1];
    var exampleModel = fairContext.read<ExampleModel>("ExampleModel");
    exampleModel.doubleField = progress;
    exampleModel.notify();
  }

  ///切换选中状态变化
  void _toggleBoolChange(List input) {
    var flag = input[0];
    FairContext fairContext = input[1];
    var exampleModel = fairContext.read<ExampleModel>("ExampleModel");
    exampleModel.boolField = flag;
    exampleModel.notify();
  }

  ///更新字符串字段
  void _updateStringField(FairContext context) {
    if (stringIndex > 3) {
      stringIndex = 0;
    }
    var exampleModel = context.read<ExampleModel>("ExampleModel");
    exampleModel.stringField = stringList[stringIndex++];
    exampleModel.notify();
  }

  ///更新整型字段
  void _updateIntField(FairContext context) {
    var exampleModel = context.read<ExampleModel>("ExampleModel");
    exampleModel.intField++;
    exampleModel.notify();
  }

  ///更新浮点型字段
  void _updateDoubleField(FairContext context) {
    var exampleModel = context.read<ExampleModel>("ExampleModel");
    if (exampleModel.doubleField == 33.3) {
      exampleModel.doubleField = 66.6;
    } else {
      exampleModel.doubleField = 33.3;
    }
    exampleModel.notify();
  }

  ///更新布尔值字段
  void _updateBoolField(FairContext context) {
    var exampleModel = context.read<ExampleModel>("ExampleModel");
    exampleModel.boolField = !exampleModel.boolField;
    exampleModel.notify();
  }

  ///更新数组字段
  void _updateListField(FairContext context) {
    var exampleModel = context.read<ExampleModel>("ExampleModel");
    if (listIndex > 3) {
      listIndex = 0;
    }
    exampleModel.listField = nestedList[listIndex++];
    exampleModel.notify();
  }

  ///更新嵌套字段
  void _updateInnerField(FairContext context) {
    var exampleModel = context.read<ExampleModel>("ExampleModel");
    if (exampleModel.innerModel?.innerBoolField == true) {
      exampleModel.innerModel?.innerBoolField = false;
    } else {
      exampleModel.innerModel?.innerBoolField = true;
    }
    exampleModel.notify();
  }

  @override
  Widget build(BuildContext context) {
    return FairChangeNotifierProvider<ExampleModel>(
      initialJson: exampleModelJson,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "基本使用示例",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0), // 设置左侧内边距
          child: ListView(
            scrollDirection: Axis.vertical, // 设置滑动方向为垂直或水平
            children: <Widget>[
              const Text(
                '初始化json信息👇🏻',
              ),
              Text(
                exampleModelJson,
                style: const TextStyle(color: Colors.green),
              ),
              Row(children: <Widget>[
                const Text('读取stringField: '),
                FairConsumer<ExampleModel>(
                  builder: SugarProvider.consumerBuilder(
                      (context, value, child) => Text(
                            SugarProvider.readString(value, 'stringField'),
                            style: const TextStyle(color: Colors.red),
                          )),
                ),
              ]),
              Row(
                children: [
                  const Text('读取intField: '),
                  FairConsumer<ExampleModel>(
                    builder: SugarProvider.consumerBuilder(
                        (context, value, child) => Text(
                              SugarProvider.anyToString(
                                  SugarProvider.readInt(value, 'intField')),
                              style: const TextStyle(color: Colors.red),
                            )),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('读取doubleField: '),
                  FairConsumer<ExampleModel>(
                    builder: SugarProvider.consumerBuilder((context, value,
                            child) =>
                        Text(
                          SugarProvider.anyToString(
                              SugarProvider.readDouble(value, 'doubleField')),
                          style: const TextStyle(color: Colors.red),
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('读取boolField: '),
                  FairConsumer<ExampleModel>(
                    builder: SugarProvider.consumerBuilder(
                        (context, value, child) => Text(
                              SugarProvider.anyToString(
                                  SugarProvider.readBool(value, 'boolField')),
                              style: const TextStyle(color: Colors.red),
                            )),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('读取listField: '),
                  FairConsumer<ExampleModel>(
                    builder: SugarProvider.consumerBuilder(
                        (context, value, child) => Text(
                              SugarProvider.anyToString(
                                  SugarProvider.readList(value, 'listField')),
                              style: const TextStyle(color: Colors.red),
                            )),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('读取数组下标为1字段：'),
                  FairConsumer<ExampleModel>(
                    builder: SugarProvider.consumerBuilder(
                        (context, value, child) => Text(
                              SugarProvider.readAsStringInList(
                                  value, 'listField', 1),
                              style: const TextStyle(color: Colors.red),
                            )),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('读取innerModel.innerBoolField: '),
                  FairSelector<ExampleModel, String>(
                      builder: SugarProvider.selectorBuilder(
                          (context, value, child) => Text(
                                value,
                                style: const TextStyle(color: Colors.red),
                              )),
                      selector: SugarProvider.selector((context, value) =>
                          SugarProvider.evaluationAsString(
                              value, 'innerModel.innerBoolField'))),
                ],
              ),
              Wrap(spacing: 8, runSpacing: 8, children: [
                FairContextBuilder(
                    builder:
                        SugarProvider.widgetBuilder((context) => ElevatedButton(
                              onPressed: () {
                                _updateStringField(context);
                              },
                              child: const Text('改变stringField'),
                            ))),
                FairContextBuilder(
                    builder:
                        SugarProvider.widgetBuilder((context) => ElevatedButton(
                              onPressed: () {
                                _updateIntField(context);
                              },
                              child: const Text('改变intField'),
                            ))),
                FairContextBuilder(
                    builder:
                        SugarProvider.widgetBuilder((context) => ElevatedButton(
                              onPressed: () {
                                _updateDoubleField(context);
                              },
                              child: const Text('改变doubleField'),
                            ))),
                FairContextBuilder(
                    builder:
                        SugarProvider.widgetBuilder((context) => ElevatedButton(
                              onPressed: () {
                                _updateBoolField(context);
                              },
                              child: const Text('改变boolField'),
                            ))),
                FairContextBuilder(
                    builder:
                        SugarProvider.widgetBuilder((context) => ElevatedButton(
                              onPressed: () {
                                _updateListField(context);
                              },
                              child: const Text('改变listField'),
                            ))),
                FairContextBuilder(
                    builder:
                        SugarProvider.widgetBuilder((context) => ElevatedButton(
                              onPressed: () {
                                _updateInnerField(context);
                              },
                              child: const Text('改变innerModel.innerBoolField'),
                            ))),
              ]),
              FairConsumer<ExampleModel>(
                builder: SugarProvider.consumerBuilder(
                    (context, value, child) => Text(
                          SugarProvider.concatenates(
                            '是否选中:',
                            SugarProvider.readAsString(value, 'boolField'),
                          ),
                        )),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FairConsumer<ExampleModel>(
                  builder: SugarProvider.consumerBuilder((context, value,
                          child) =>
                      FairContextBuilder(
                        builder: SugarProvider.widgetBuilder((fairContext) =>
                            Switch(
                                value:
                                    SugarProvider.readBool(value, "boolField"),
                                onChanged:
                                    SugarProvider.onValueChangeWithFairContext(
                                        function: _toggleBoolChange,
                                        fairContext: fairContext))),
                      )),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FairConsumer<ExampleModel>(
                  builder: SugarProvider.consumerBuilder(
                      (context, value, child) => Text(
                            SugarProvider.concatenates(
                              '进度:',
                              SugarProvider.readAsString(value, 'doubleField'),
                            ),
                          )),
                ),
              ),
              FairConsumer<ExampleModel>(
                builder: SugarProvider.consumerBuilder((context, value,
                        child) =>
                    FairContextBuilder(
                      builder: SugarProvider.widgetBuilder((fairContext) =>
                          Slider(
                              max: 100,
                              value: SugarProvider.readDouble(
                                  value, "doubleField"),
                              onChanged:
                                  SugarProvider.onValueChangeWithFairContext(
                                      function: _onSliderChange,
                                      fairContext: fairContext))),
                    )),
              ),
            ],
          ),
        ),
        floatingActionButton: FairContextBuilder(
          builder:
              SugarProvider.widgetBuilder((context) => FloatingActionButton(
                    onPressed: () {
                      _updateAll(context, context);
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  )),
        ),
      ),
    );
  }
}
