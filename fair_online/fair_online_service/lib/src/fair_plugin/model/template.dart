///Sugar.ifEqual 代码模版
//Sugar.ifEqual(variable, value, trueValue: trueWidget, falseValue: falseWidget)
String sugarIfEqualTemplate(
    String actual,
    String expect,
    String ifStatement, {
      String? elseStatement,
    }) {
  return '${ifStatement.contains("return") ? 'return ' : ''}Sugar.ifEqual($actual, $expect,trueValue:${_tryGetWidget(ifStatement)},${null != elseStatement ? 'falseValue:${_tryGetWidget(elseStatement)}' : 'falseValue:falseWidget'});';
}

///Sugar.ifEqualBool 代码模版
//Sugar.ifEqualBool(state, trueValue: trueWidget,falseValue: falseWidget)
String sugarIfEqualBoolTemplate(String condition, String ifStatement,
    {String? elseStatement}) {
  return '${ifStatement.contains("return") ? 'return ' : ''}Sugar.ifEqualBool($condition, trueValue:${_tryGetWidget(ifStatement)}, ${null != elseStatement ? 'falseValue:${_tryGetWidget(elseStatement)}' : 'falseValue:falseWidget'});';
}

///Sugar.ifRange 代码模版
//Sugar.ifRange(actual, expect, trueValue: trueWidget, falseValue: falseWidget)
String sugarIfRangeTemplate(String actual, String expect, String ifStatement,
    {String? elseStatement}) {
  return 'Sugar.ifRange($actual, $expect, trueValue:trueWidget, ${null != elseStatement ? 'falseValue:falseWidget' : ''});';
}

///Sugar.map 代码模版
//Sugar.map(data, builder: (e) => widget)
String sugarMapTemplate(
    String data,
    String variable,
    String forLooperBody,
    ) {
  return 'Sugar.map($data, builder: ($variable) => $forLooperBody);';
}

String sugarMapTemplate2(String data, String builderParts) {
  return 'Sugar.map($data, builder: $builderParts)';
}

///Sugar.mapEach 代码模版
//Sugar.mapEach(data, (index, item) => null)
String sugarMapEachTemplate(
    String data, String index, String item, String loopBody) {
  return 'Sugar.mapEach($data, ($index, $item)=> $loopBody);';
}

String sugarMapEachTemplate2(String data, String item, String builderParts) {
  return 'Sugar.mapEach($data, (index, $item)=> $builderParts)';
}

String _tryGetWidget(String statement) {
  String result = '';
  if (statement.contains("return")) {
    result = statement.substring(
        statement.lastIndexOf("return") + 6, statement.lastIndexOf(";"));
  } else if (statement.contains("=")) {
    result = statement.substring(
        statement.lastIndexOf("=") + 1, statement.lastIndexOf(";"));
  }
  return result.isEmpty ? statement : result;
}
