import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSliverToBoxAdapterPage extends StatefulWidget {
  dynamic fairProps;

  FairSliverToBoxAdapterPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSliverToBoxAdapterPageState();
}

class _FairSliverToBoxAdapterPageState
    extends State<FairSliverToBoxAdapterPage> {
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
        SliverAppBar(
          pinned: true,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Fair Sample'),
            background: Image.network(
              'https://github.com/wuba/fair/raw/main/best-ui-template.png',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Text('Fair'),
        ),
        SliverFixedExtentList(
          itemExtent: 80.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.primaries[(index % 18)],
                  child: Text(''),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
