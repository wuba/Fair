import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class GoogleFontsPage extends StatefulWidget {
  Map<String, dynamic> params;
  GoogleFontsPage({Key key, this.params}) : super(key: key);

  @override
  _GoogleFontsPageState createState() {
    return _GoogleFontsPageState();
  }
}

class _GoogleFontsPageState extends State<GoogleFontsPage> {
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
    return FairWidget(
      name: "google_fonts",
      path: "assets/bundle/lib_google_fonts_fair_google_fonts_widget.fair.json",
      data: {
        'title': "google fonts Demo Page"
      },
    );
  }
}