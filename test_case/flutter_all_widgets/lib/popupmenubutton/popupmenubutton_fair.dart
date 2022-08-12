import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairPopupmenuButtonPage extends StatefulWidget {
  dynamic fairProps;

  FairPopupmenuButtonPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairPopupmenuButtonPageState();
}

class _FairPopupmenuButtonPageState extends State<FairPopupmenuButtonPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  List<String> _getItems() => fairProps['item'];

  List<PopupMenuEntry<dynamic>> _getItemBuilder(context) => _getItems()
      .map((e) => PopupMenuItem<String>(
            value: e,
            child: Text(e),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PopupMenuButton(
      itemBuilder: _getItemBuilder,
    ));
  }
}
