import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDatePickerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CupertinoDatePicker'),
      ),
      body: Column(
        children: [
          FlutterCupertinoDatePickerPage(),
          FairWidget(
            path: 'assets/bundle/cupertinodatepicker/lib_cupertinodatepicker_cupertinodatepicker_widget.fair.json',
          )
        ],
      ),
    );
  }
}

class FlutterCupertinoDatePickerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlutterCupertinoDatePickerPageState();
}

class _FlutterCupertinoDatePickerPageState extends State<FlutterCupertinoDatePickerPage> {
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
              _DatePickerItem(
                children: [
                  Text('Date'),
                  CupertinoButton(
                      child: Text(
                        '${date.year}-${date.month}-${date.day}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () => _showDialog(CupertinoDatePicker(
                          initialDateTime: date,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              date = newDate;
                            });
                          })))
                ],
              ),
              _DatePickerItem(
                children: [
                  Text('Time'),
                  CupertinoButton(
                    child: Text(
                      '${time.hour}:${time.minute}',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    onPressed: () => _showDialog(CupertinoDatePicker(
                      initialDateTime: time,
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() {
                          time = newTime;
                        });
                      },
                    )),
                  )
                ],
              ),
              _DatePickerItem(
                children: [
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

class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
