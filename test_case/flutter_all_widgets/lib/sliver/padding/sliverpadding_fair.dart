import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairSliverPaddingPage extends StatefulWidget {
  dynamic fairProps;

  FairSliverPaddingPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairSliverPaddingPageState();
}

class _FairSliverPaddingPageState extends State<FairSliverPaddingPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  EdgeInsetsGeometry _getPadding() =>
      fairProps['padding'] ?? EdgeInsets.all(10);

  Widget _getSliver() =>
      fairProps['sliver'] ??
      SliverToBoxAdapter(child: Container(
        color: Colors.green,
        child: Center(
          child: Text('Fair'),
        ),
      ),);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: _getPadding(),
            sliver: _getSliver(),
          ),
        ],
      ),
    );
  }
}