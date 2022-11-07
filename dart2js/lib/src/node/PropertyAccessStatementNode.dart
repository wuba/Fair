import 'MemberAccessStatementNode.dart';
import '../utils/const.dart';

class PropertyAccessStatementNode extends MemberAccessStatementNode {
  String? fieldName;
  String? setVal;

  @override
  String toSource() {
    var finalThiz =
    thiz != null && thiz!.trim() == superSubstitution ? 'this' : thiz;
    return '''
    ${finalThiz?.isNotEmpty == true ? finalThiz! + '.' : ''}$fieldName${setVal == null ? '' : '=' + setVal! + ';'}
    ''';
  }
}
