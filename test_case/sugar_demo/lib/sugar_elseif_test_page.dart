import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'person.dart';

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

  int _value = 1;

  void logAction(){
    print('Click...');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color:Sugar.colorsWithOpacity(Color(0xffff602f), 0.5) ),
        child: Column(
          children: [
            Container(
              height: 100,
              width: Sugar.width(context),
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Sugar.switchCase(_value, [
                  SugarSwitchCaseObj(reValue: Text("2-ValueTitle"), sugarCase: 2),
                  SugarSwitchCaseObj(reValue: Text("3-ValueTitle"), sugarCase: 3),
                  SugarSwitchCaseObj(reValue: Text("4-ValueTitle"), sugarCase: 4)
                ], Text("default-ValueTitle")),
              )
            ),
            FloatingActionButton(
                child: Text(
                  Sugar.switchCase(_value, [
                    SugarSwitchCaseObj(reValue: "2", sugarCase: 2),
                    SugarSwitchCaseObj(reValue: "3", sugarCase: 3),
                    SugarSwitchCaseObj(reValue: "4", sugarCase: 4)
                  ], "defaultValue"),
                  style: TextStyle(
                    fontWeight: FontWeight.w100
                  ),
                ),
                onPressed: logAction,),
            Column(
              children: Sugar.mapEach([Person(name: "kk",age: 18, wei: 99),Person(name: "mm", age: 14, wei: 88)], (index, Person item) {
            return Container(
                height: 100,
                width: Sugar.width(context),
                child: Center(
                 child: Row(
                   children: [
                     Text(item.name),
                     Text("${item.age}")
                   ],
                 ),
                ));
          }),
            )

          ],
        ));
  }
}
