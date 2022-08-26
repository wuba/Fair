import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairTablePage extends StatefulWidget {
  dynamic fairProps;

  FairTablePage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairTablePageState();
}

class _FairTablePageState extends State<FairTablePage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Table(
      children: [
        TableRow(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.blue),
            children: [
              TableCell(child: Text('Fair 一期')),
              TableCell(child: Text('Fair 二期')),
              TableCell(child: Text('Fair 三期')),
            ]),
        TableRow(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.green),
            children: [
              TableCell(child: Text('布局动态化')),
              TableCell(child: Text('逻辑动态化')),
              TableCell(child: Text('变得更好用')),
            ]),
        TableRow(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.yellow),
            children: [
              TableCell(child: Text('2020')),
              TableCell(child: Text('2021')),
              TableCell(child: Text('2022')),
            ]),
      ],
    ));
  }
}
