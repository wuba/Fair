// 原样输出的语句
import 'StatementNode.dart';

class GenericStatementNode extends StatementNode {
  String? code;

  GenericStatementNode(String code_) {
    code = code_;
  }

  @override
  String toSource() {
    return code ?? '';
  }
}