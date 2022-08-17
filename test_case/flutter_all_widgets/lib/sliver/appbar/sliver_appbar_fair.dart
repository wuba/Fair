import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSliverAppBarPage extends StatefulWidget {
  dynamic fairProps;

  FairSliverAppBarPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSliverAppBarPageState();
}

class _FairSliverAppBarPageState extends State<FairSliverAppBarPage> {
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
            title: Text('Fair'),
            background: Image.network(
              'https://github.com/wuba/fair/raw/main/best-ui-template.png',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}
