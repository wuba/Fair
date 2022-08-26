import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairWidgetsAppPage extends StatefulWidget {
  dynamic fairProps;

  FairWidgetsAppPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairWidgetsAppPageState();
}

class _FairWidgetsAppPageState extends State<FairWidgetsAppPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFFFFFFFF),
      onGenerateRoute: (RouteSettings settings) {
        return CupertinoPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) {
            return  CupertinoTabView(
              builder: (BuildContext context) => const Text('home'),
            );
          },
        );
      },
    );
  }
}
