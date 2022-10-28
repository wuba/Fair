import 'convertStatements.dart';

String convertExpression(String code) {
  // print("[convertExpression]" + code);
  var res = '';
  var start = 0;
  try {
    res = convertStatements(code + ';');
    res = res.trim();
  } on ArgumentError {
    // 有些表达式直接变成语句会报错，例如字典字面量对象
    var prefix = 'var __variable__ = ';
    res = convertStatements('''$prefix$code;''');
    res = res.trim();
    start = res.indexOf('=') + 1;
  }
  var end = res.length - 1;
  while (end >= 0 && RegExp(r'[\s\r\n;]', multiLine: false).hasMatch(res[end])) {
    end--;
  }
  return res.substring(start, end + 1);
}