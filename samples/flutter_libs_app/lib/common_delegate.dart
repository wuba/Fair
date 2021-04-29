
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonDelegate extends FairDelegate{

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_pop'] = ()=>Navigator.pop(context);
    fun['GoogleFonts.getFont'] = (props) {
      GoogleFonts.getFont(props['pa'][0]);
    };
    return fun;
  }
}