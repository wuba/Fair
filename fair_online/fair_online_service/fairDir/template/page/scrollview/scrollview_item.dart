import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@FairPatch()
class @@PageName@@Item extends StatefulWidget {
  dynamic fairProps;

  @@PageName@@Item({Key? key, required this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _@@PageName@@ItemState();
}

class _@@PageName@@ItemState extends State<@@PageName@@Item> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  String getImagePath() {
    return fairProps['imagePath'];
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        child: Image.network(getImagePath(), fit: BoxFit.cover),
      ),
    );
  }
}
