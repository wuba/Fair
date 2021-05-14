
import 'package:google_fonts/google_fonts.dart';

Map<String, dynamic> googleFontsComponent= {
  'GoogleFonts.getFont':(props){
    return GoogleFonts.getFont(
        props['pa'][0]
    );
  }
};