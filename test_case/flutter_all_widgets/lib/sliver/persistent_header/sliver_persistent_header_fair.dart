import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSliverPersistentHeaderPage extends StatefulWidget {
  dynamic fairProps;

  FairSliverPersistentHeaderPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSliverPersistentHeaderPageState();
}

class _FairSliverPersistentHeaderPageState
    extends State<FairSliverPersistentHeaderPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: FairSliverPersistentHeaderDelegate(),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 3),
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              color: Colors.primaries[index % Colors.primaries.length],
            );
          }, childCount: 20),
        ),
      ],
    );
  }
}

class FairSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text('Fair SliverPersistentHeader Demo',
            style: TextStyle(color: Colors.white)));
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      false; // 如果内容需要更新，设置为true
}
