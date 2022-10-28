import '../utils/const.dart';
import 'MemberAccessStatementNode.dart';
class MethodInvokeStatementNode extends MemberAccessStatementNode {
  String? methodName;
  List<String> unnamedParameters = [];
  List<List<String>> namedParameters = [];
  String? parentClassName;

  @override
  String toSource() {
    var finalNamedParameters = StringBuffer();
    if (unnamedParameters.isNotEmpty && namedParameters.isNotEmpty) {
      finalNamedParameters.write(',');
    }
    if (namedParameters.isNotEmpty) {
      finalNamedParameters.write('{');
      finalNamedParameters
          .write(namedParameters.map((e) => '''${e[0]}:${e[1]}''').join(','));
      finalNamedParameters.write('}');
    }

    if (thiz != null && thiz?.trim() == superSubstitution) {
      var params =
          '${unnamedParameters.join(',')}${finalNamedParameters.toString()}';
      if (parentClassName == null || parentClassName!.isEmpty) {
        return '';
      }
      return '$parentClassName.prototype.$methodName.call(this${params.isEmpty ? '' : ',$params'});';
    }
    if (transpileOption.modifySetState && methodName == setStateMethodName) {
      unnamedParameters.insert(0, "'$FairKeyPlaceholder'");
    }
    return '''
    ${thiz != null && thiz!.isNotEmpty ? thiz! + '.' : ''}$methodName(${unnamedParameters.join(',')}${finalNamedParameters.toString()});
    ''';
  }
}