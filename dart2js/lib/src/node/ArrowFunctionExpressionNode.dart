import 'FunctionDeclarationNode.dart';
import '../funs/addCommaAsNeeded.dart';

class ArrowFunctionExpressionNode extends FunctionDeclarationNode {
  @override
  String toSource() {
    return '''
      ${isAsync ? 'async ' : ''}(${argumentList.map((elem) => elem[0]).join(',')}) => ${addCommaAsNeeded(body.statements[0].toSource())}
    ''';
  }
}