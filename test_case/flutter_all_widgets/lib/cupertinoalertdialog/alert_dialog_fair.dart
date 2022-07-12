import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';

class FairAlertDialogPage extends StatefulWidget {
  dynamic fairProps;

  FairAlertDialogPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairAlertDialogState();
}

@FairPatch()
class _FairAlertDialogState extends State<FairAlertDialogPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    this.fairProps = widget.fairProps;
  }

  String _getTitle() {
    return fairProps['title'];
  }

  String _getContent(){
    return fairProps['content'];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(_getTitle()),
      content: Text(_getContent()),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('取消'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('确定'),
        )
      ],
    );
  }
}
