import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class ConvexBottomBarWidget extends StatefulWidget {
  final String title;

  ConvexBottomBarWidget({required Key key, required this.title}) : super(key: key);

  @override
  _ConvexBottomBarWidgetState createState() {
    return _ConvexBottomBarWidgetState();
  }
}

class _ConvexBottomBarWidgetState extends State<ConvexBottomBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: Text("example for bottom bar")
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.list),
          TabItem(icon: Icons.calendar_today),
          TabItem(icon: Icons.assessment),
        ],
      ),
    );
  }
}