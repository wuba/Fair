import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libs_app/google_fonts/google_font_page.dart';
import 'package:google_fonts/google_fonts.dart';

@FairPatch()
class GoogleFontsExamplePage extends StatefulWidget {
  String title;
  GoogleFontsExamplePage({Key key, this.title}) : super(key: key);

  @override
  _GoogleFontsExamplePageState createState() {
    return _GoogleFontsExamplePageState();
  }
}

class _GoogleFontsExamplePageState extends State<GoogleFontsExamplePage> {
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
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.getFont("Lato"),
        ),
    ));
  }
}