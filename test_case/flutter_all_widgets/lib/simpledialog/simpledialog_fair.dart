import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSimpleDialogPage extends StatefulWidget {
  dynamic fairProps;

  FairSimpleDialogPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSimpleDialogPageState();
}

class _FairSimpleDialogPageState extends State<FairSimpleDialogPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  List<Widget> _getChildren() {
    return [
      Container(
        height: 80,
        alignment: Alignment.center,
        child: Text('确认删除吗？'),
      ),
      Divider(
        height: 1,
      ),
      FlatButton(
        child: Text('取消'),
        onPressed: () {
          Navigator.of(context).pop('cancel');
        },
      ),
      Divider(
        height: 1,
      ),
      FlatButton(
        child: Text('确认'),
        onPressed: () {
          Navigator.of(context).pop('ok');
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleDialog(
      title: Text('提示'),
      children: _getChildren(),
    ));
  }
}
