import 'package:sprintf/sprintf.dart';

///支持 字符串模版 替换
String format(String replaced, replacements) {
  return sprintf(replaced, replacements);
}

///扩展 字符串模版
extension StringExt on String {
  String format(replacements) {
    return sprintf(this, replacements);
  }
}
