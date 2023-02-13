import 'package:intl/intl.dart';

class Log {
  static void d(String value, {String? tag}) {
    print(_formatLine(tag ?? "fair-online", value));
  }

  static String _formatLine(String tag, String value) {
    String date =
        "${DateFormat("yyyy-MM-dd HH:mm:ss.S").format(DateTime.now())}";
    return "$date D/$tag: $value";
  }
}
