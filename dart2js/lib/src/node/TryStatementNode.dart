import 'StatementNode.dart';

class TryStatementNode extends StatementNode {
  String? tryBody;
  String? catchBody;
  String? exceptionParameter; // catch(e) ,e：stackTraceParameter
  String? finallyBody;
  String? stackTraceParameter; // catch(e,s) ,s：stackTraceParameter

  @override
  String toSource() {
    String tryStr = '''try {
    $tryBody
    }''';

    String catchStr = ''' catch(${exceptionParameter}){
     ${catchBody}
    }''';

    String finallyStr = ''' finally {
     ${finallyBody}
    }''';

    String result = tryStr;
    if (catchBody != null) {
      result = result + catchStr;
    }
    if (finallyBody != null) {
      result = result + finallyStr;
    }
    return result;
  }
}
