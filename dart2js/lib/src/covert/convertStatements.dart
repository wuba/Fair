import 'convertBlock.dart';

String convertStatements(String code) {
  if (!code.endsWith(';') && !code.endsWith('}')) {
    code += ';';
  }
  var res = convertBlock('''{$code}''');
  return res;
}