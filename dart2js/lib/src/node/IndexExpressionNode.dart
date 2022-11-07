import '../utils/const.dart';
import 'GenericStatementNode.dart';
import 'StatementNode.dart';

class IndexExpressionNode extends StatementNode {
  GenericStatementNode? key;
  GenericStatementNode? target;
  var isSet = false;
  GenericStatementNode? value;

  @override
  String toSource() {
    return isSet
        ? '''${target?.toSource()}.${OperatorOverloadSymbol.indexEqual}(${key?.toSource()}, ${value?.toSource()});'''
        : '''${target?.toSource()}.${OperatorOverloadSymbol.index}(${key?.toSource()})''';
  }
}