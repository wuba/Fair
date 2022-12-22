import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class PageViewItemTemplate extends StatefulWidget {
  dynamic fairProps;

  PageViewItemTemplate({Key? key, required this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PageViewItemTemplateState();
}

class _PageViewItemTemplateState extends State<PageViewItemTemplate> {
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
