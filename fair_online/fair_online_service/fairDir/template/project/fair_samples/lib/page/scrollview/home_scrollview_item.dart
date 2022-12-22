import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@FairPatch()
class HomeScrollviewListItem extends StatefulWidget {
  dynamic fairProps;

  HomeScrollviewListItem({Key? key, required this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScrollviewListItemState();
}

class _HomeScrollviewListItemState extends State<HomeScrollviewListItem> {
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
