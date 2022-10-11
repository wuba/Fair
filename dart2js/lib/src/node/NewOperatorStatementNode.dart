import 'MethodInvokeStatementNode.dart';

/**
 *
 * thiz 必然为null
 *
 */
class NewOperatorStatementNode extends MethodInvokeStatementNode {
  @override
  String toSource() {
    if (thiz != null) {
      throw Exception('thiz must be null for NewOperatorStatementNode');
    }
    return 'new ${super.toSource()}';
  }
}