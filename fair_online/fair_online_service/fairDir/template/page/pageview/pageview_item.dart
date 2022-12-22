import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

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

  String getImagePath() {
    return fairProps['imagePath'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(getImagePath(), fit: BoxFit.scaleDown),
    );
  }
}
