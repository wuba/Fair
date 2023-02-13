import 'package:sprintf/sprintf.dart';

extension StringExt on String {
  String format(replacements) {
    return sprintf(this, replacements);
  }
}