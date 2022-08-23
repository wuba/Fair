
import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'datepick_item.dart';

@FairPatch()
class FairCupertinoDatePickerPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FairCupertinoDatePickerPageState();

}


class _FairCupertinoDatePickerPageState extends State<FairCupertinoDatePickerPage>{

  DateTime date = DateTime(2022, 8, 21);
  DateTime time = DateTime(2022, 8, 21, 17, 35);
  DateTime dateTime = DateTime(2022, 8, 3, 17, 45);

  void _showDialog(Widget child) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: child,
          ),
        ));
  }

  void _DateOnPressed(){
    _showDialog(CupertinoDatePicker(
        initialDateTime: date,
        onDateTimeChanged: (DateTime newDate) {
          setState(() {
            date = newDate;
          });
        }));
  }

  void _TimeOnPressed(){
    _showDialog(CupertinoDatePicker(
      initialDateTime: time,
      onDateTimeChanged: (DateTime newTime) {
        setState(() {
          time = newTime;
        });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: DefaultTextStyle(
        style: TextStyle(
            color: CupertinoColors.label.resolveFrom(context), fontSize: 22.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DatePickerItem(
                children: <Widget>[
                  Text('Date'),
                  CupertinoButton(
                      child: Text(
                        '${date.year}-${date.month}-${date.day}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: _DateOnPressed)
                ],
              ),
              DatePickerItem(
                children: <Widget>[
                  Text('Time'),
                  CupertinoButton(
                    child: Text(
                      '${time.hour}:${time.minute}',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    onPressed: () => _TimeOnPressed)
                ],
              ),
              DatePickerItem(
                children: <Widget>[
                  Text('DateTime'),
                  CupertinoButton(
                      child: Text(
                        '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}',
                        style: TextStyle(fontSize: 22.0),
                      ),
                      onPressed: () => _showDialog(CupertinoDatePicker(
                          onDateTimeChanged: (DateTime newDateTime) {
                            setState(() {
                              dateTime = newDateTime;
                            });
                          })))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
