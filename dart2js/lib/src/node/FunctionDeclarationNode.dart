import 'FunctionBodyNode.dart';
import '../utils/const.dart';

class FunctionDeclarationNode {
  String? name;
  String? className;
  List<List<String>> argumentList = [];
  List<List<String>> namedArgumentList = [];
  List<List<String>> optionalArgumentList = [];
  bool isAsync = false;
  bool isGenerativeConstructor = false;
  bool isRedirectConstructor = false;
  bool withContext = false;
  bool classHasStaticFields = false;
  bool isStatic = false;
  FunctionBodyNode body = FunctionBodyNode();
  static final argContext = '__arg_ctx__';

  String argumentObj() {
    if (argumentList.isEmpty &&
        namedArgumentList.isEmpty &&
        optionalArgumentList.isEmpty) {
      return '';
    }
    var res = StringBuffer('{');
    if (argumentList.isNotEmpty) {
      res
        ..write(argumentList.map((e) => e[0]).join(','))
        ..write(',');
    }
    if (namedArgumentList.isNotEmpty) {
      res
        ..write(namedArgumentList.map((e) => e[0]).join(','))
        ..write(',');
    }
    if (optionalArgumentList.isNotEmpty) {
      res
        ..write(optionalArgumentList.map((e) => e[0]).join(','))
        ..write(',');
    }
    res.write('}');
    return res.toString();
  }

  String withArgumentObjAsNeeded(String body) {
    if (argumentList.isEmpty &&
        namedArgumentList.isEmpty &&
        optionalArgumentList.isEmpty) {
      return body;
    }

    return '''
    with ($argContext) {
      $body
    }
    ''';
  }

  String withClassAsNeeded(String body) {
    if (!classHasStaticFields || isStatic) {
      return body;
    }
    return '''
    with($className) {
      $body
    }
    ''';
  }

  String wrapBodyWithCtx() {
    var argObj = argumentObj();
    if (isRedirectConstructor) {
      return '''
      ${argObj.isNotEmpty ? 'const $argContext = $argObj;' : ''}
      ${withArgumentObjAsNeeded(body.toSource())}
      ''';
    }
    return '''
      const $thisAlias = ${!isGenerativeConstructor ? 'this' : 'Object.create($className.prototype)'};
      ${argObj.isNotEmpty ? 'const $argContext = $argObj;' : ''}
      ${!isGenerativeConstructor ? '' : '$className.$innerName.call($thisAlias);'}
      ${withClassAsNeeded('''
      with ($thisAlias) {
        ${withArgumentObjAsNeeded(isGenerativeConstructor ? '(function() {${body.toSource()}}).call($thisAlias);' : body.toSource())}
      }
      ''')}
      ${!isGenerativeConstructor ? '' : 'return $thisAlias;'}
    ''';
  }

  String toSource() {
    var namedArgs = '';
    if (namedArgumentList.isNotEmpty) {
      if (argumentList.isNotEmpty) {
        namedArgs = ',';
      }
      namedArgs +=
          '''{${namedArgumentList.map((e) => e[0] + (e.length == 2 ? '=' + e[1] : '')).join(',')}}={}''';
    }
    var optionalArgs = '';
    if (optionalArgumentList.isNotEmpty) {
      if (namedArgumentList.isNotEmpty || argumentList.isNotEmpty) {
        optionalArgs = ',';
      }
      optionalArgs +=
          '''${optionalArgumentList.map((e) => e[0] + (e.length == 2 ? '=' + e[1] : '')).join(',')}''';
    }

    var finalBody = withContext ? wrapBodyWithCtx() : body.toSource();
    return '''${isAsync ? 'async ' : ''}function $name(${argumentList.map((elem) => elem[0]).join(',')}$namedArgs$optionalArgs) { 
      $finalBody
    }''';
  }
}
