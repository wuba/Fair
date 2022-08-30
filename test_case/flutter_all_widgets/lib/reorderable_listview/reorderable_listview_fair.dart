import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairReorderableListViewPage extends StatefulWidget {
  dynamic fairProps;

  FairReorderableListViewPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairReorderableListViewPageState();
}

class _FairReorderableListViewPageState
    extends State<FairReorderableListViewPage> {
  @FairProps()
  var fairProps;

  var items = List.generate(20, (int i) => '$i');

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  List<Widget> _getChildren() {
    return <Widget>[
      for (String item in items)
        Container(
          key: ValueKey(item),
          height: 100,
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          decoration: BoxDecoration(
              color:
                  Colors.primaries[int.parse(item) % Colors.primaries.length],
              borderRadius: BorderRadius.circular(10)),
        )
    ];
  }

  void _onReorder(oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var child = items.removeAt(oldIndex);
    items.insert(newIndex, child);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ReorderableListView(
      children: _getChildren(),
      onReorder: _onReorder,
    ));
  }
}
