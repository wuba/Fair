import 'GenericStatementNode.dart';
import 'StatementNode.dart';
import '../funs/addCommaAsNeeded.dart';

class AssignmentStatementNode extends StatementNode {
  String? leftSide;
  String operator_ = '=';
  GenericStatementNode? rightSide;

  @override
  String toSource() {
    return '$leftSide $operator_ ${addCommaAsNeeded(rightSide?.toSource())}';
  }
}