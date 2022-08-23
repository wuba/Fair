import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairScrollConfigurationDemoPage extends StatefulWidget {
  dynamic fairProps;

  FairScrollConfigurationDemoPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _FairScrollConfigurationDemoPageState();
}

class _FairScrollConfigurationDemoPageState
    extends State<FairScrollConfigurationDemoPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  Widget _getChild(){
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Text('Item$index');
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemCount: 50,
    );
  }

  ScrollBehavior _getBehavior() {
    return ScrollBehavior();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ScrollConfiguration(
      behavior: _getBehavior(),
      child: _getChild(),
    ));
  }
}
