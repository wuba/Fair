import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sugar_demo/person.dart';

@FairPatch()
class SugarElseIfPage extends StatefulWidget {
  final dynamic fairProps;

  const SugarElseIfPage({Key? key, this.fairProps}) : super(key: key);

  @override
  State<SugarElseIfPage> createState() => _SugarElseIfPageState();
}

class _SugarElseIfPageState extends State<SugarElseIfPage> {
  @FairProps()
  var fairProps;

  int _value = 2;

  void logAction() {
    print('Click......');
  }

  int _getItemCount() {
    return _value;
  }

  // List<String> li = ['kk','ddd','dddd'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("SugarDemo")),
        body: Column(
          children: [
            Column(
              children: Sugar.mapEach([
                Person(name: "kk", age: 18, wei: 99),
                Person(name: "mm", age: 14, wei: 88)
              ], (index, Person item) {
                return Container(
                    height: 50,
                    width: Sugar.width(context),
                    child: Center(
                        child: Row(
                      children: [
                        Text(item.name),
                        Text("${item.age}"),
                      ],
                    )));
              }),
            ),
            Container(
                height: 50,
                width: Sugar.width(context),
                margin: EdgeInsets.only(top: 5),
                child: Center(
                  child: Sugar.switchCase(
                      _value,
                      [
                        SugarSwitchCaseObj(
                            reValue: () => Text("2-ValueTitle"),
                            sugarCase: () => 2),
                        SugarSwitchCaseObj(
                            reValue: () => Text("3-ValueTitle"),
                            sugarCase: () => 3),
                        SugarSwitchCaseObj(
                            reValue: () => Text("4-ValueTitle"),
                            sugarCase: () => 4)
                      ],
                      () => Text("default-ValueTitle")),
                )),
            SizedBox(
              width: Sugar.width(context),
              height: Sugar.height(context),
              child: ListView.builder(
                itemBuilder:
                    Sugar.indexedWidgetBuilder((context, index) => Center(
                          child: Container(
                            height: 20,
                            child: Text("$index"),
                          ),
                        )),
                itemCount: _getItemCount(),
              ),
            ),
            FloatingActionButton(
              child: Text(
                Sugar.switchCase(
                    _value,
                    [
                      SugarSwitchCaseObj(
                          reValue: () => "2", sugarCase: () => 2),
                      SugarSwitchCaseObj(
                          reValue: () => "3", sugarCase: () => 3),
                      SugarSwitchCaseObj(reValue: () => "4", sugarCase: () => 4)
                    ],
                    () => "defaultValue"),
                // style: TextStyle(fontWeight: FontWeight.w100),
              ),
              onPressed: logAction,
            ),
            SizedBox(
                width: Sugar.width(context),
                height: 50,
                child: ListView.builder(
                  itemBuilder:
                      Sugar.indexedWidgetBuilder((context, index) => Center(
                            child: Container(
                              height: 50,
                              width: 60,
                              child: Container(
                                color: Colors.amber,
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                  child: Text("$index"),
                                ),
                              ),
                            ),
                          )),
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: 15,
                )),
            SizedBox(
              height: 40,
              width: Sugar.width(context),
              child: Container(
                margin: EdgeInsets.only(left: 0, right: 1, top: 10),
                color: Colors.green,
                child: Center(child: Text("CustomScrollView-Sugar")),
              ),
            ),
            SizedBox(
                width: Sugar.width(context),
                height: 400,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          Sugar.nullableIndexedWidgetBuilder(
                              (context, index) => Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: 85,
                                    alignment: Alignment.center,
                                    color: Colors.blue,
                                    child: Text(
                                      '$index',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )),
                          childCount: 3),
                    ),
                    SliverGrid(
                      //Grid
                      gridDelegate:
                          Sugar.sliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, //Grid按两列显示
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 4.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                          Sugar.nullableIndexedWidgetBuilder(
                              (context, index) => Container(
                                    alignment: Alignment.center,
                                    color: Colors.deepOrange,
                                    child: Text('是 grid item $index 啊~~'),
                                  )),
                          childCount: 20),
                    ),
                  ],
                ))
          ],
        ));
  }
}
