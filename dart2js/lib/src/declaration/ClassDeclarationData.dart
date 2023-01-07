import 'dart:ffi';

import 'FieldDeclarationData.dart';
import 'MethodDeclarationData.dart';
import '../covert/convertFunctionFromData.dart';
import 'package:fair_dart2js/src/list_ext.dart';
import '../utils/const.dart';

class ClassDeclarationData {
  String? className = '';
  var fields = <FieldDeclarationData>[];
  var methods = <MethodDeclarationData>[];
  var outputTemplateType = ClassOutputTemplateType.raw;
  String? parentClass = '';
  bool isDataBean = false;

  bool isFactoryDefaultContructor = false;
  bool isAutoGenDefaultConstructor = false;

  String genJsCode() {
    var tpl = '';
    switch (outputTemplateType) {
      case ClassOutputTemplateType.raw:
        {
          init();
          var fieldsLiterval = parseFields(fields);
          var memberMethodsLiterval = parseMemberMethods(methods);
          var staticFieldsLiteral = parseStaticFields(fields);
          var staticMethodsLiteral = parseStaticMethods(methods);
          var defaultConstructor = parseDefaultConstructor();
          var instanceConstruction = parseInstanceConstruction();
          var beanToJson = parseBeanToJson();
          var beanFromJson = parseBeanFromJson();
          tpl = '''
        function $className() {          
          $instanceConstruction
        }
        $className.$innerName = function inner() {
          ${parentClass != null && parentClass!.isNotEmpty ? '$parentClass.$innerName.call(this);' : ''}
          $fieldsLiterval
        };
        $className.prototype = {
          $memberMethodsLiterval
          ${isDataBean ? beanToJson : ''}
        };
        ${isAutoGenDefaultConstructor ? defaultConstructor : ''}
        $staticMethodsLiteral
        $staticFieldsLiteral
        ${isDataBean ? beanFromJson : ''}
        ${parentClass != null && parentClass!.isNotEmpty ? 'inherit($className, $parentClass);' : ''}
        ''';
        }
        break;
      case ClassOutputTemplateType.pageState:
        {
          var fieldsLiterval = '';
          fields.forEach((element) {
            fieldsLiterval += '${element.name}: ${element.initVal},';
          });
          var methodsLiterval = '';
          methods.forEach((element) {
            methodsLiterval +=
                '${element.name}: ${convertFunctionFromData(element, this)},';
          });
          tpl = '''
        {
          $fieldsLiterval
          $methodsLiterval
        }
        ''';
        }

        break;
    }
    return tpl;
  }

  init() {
    isFactoryDefaultContructor = methods.firstWhereOrNull(
            (element) =>
                element.isFactory == true &&
                element.name == factoryConstructorAlias,
            orElse: () => null) !=
        null;

    isAutoGenDefaultConstructor = methods.firstWhereOrNull(
            (element) => !element.isStatic && element.name == constructorAlias,
            orElse: () => null) ==
        null;
  }

  parseDefaultConstructor() {
    var fun = (parentClass != null && parentClass!.isNotEmpty)
        ? '''${parentClass}.prototype.$constructorAlias.call(this)'''
        : '';

    var defaultConstructor = '''
          $className.prototype.$constructorAlias = function() {
            ${fun}
          };
        ''';
    return defaultConstructor;
  }

  parseFields(List<FieldDeclarationData> fields) {
    var fieldsLiterval = '';
    fields.where((element) => !element.isStatic).forEach((element) {
      if(element.isGetter){
        fieldsLiterval += 'this.${element.name} = (function(_this) { with (_this) {${element.initVal ?? 'null'} } })(this);';
      }else{
          fieldsLiterval += 'this.${element.name} = ${element.initVal};';
      }
    });
    return fieldsLiterval;
  }

  parseMemberMethods(List<MethodDeclarationData> methods) {
    var memberMethodsLiterval = '';
    methods.where((element) => !(element.isStatic)).forEach((element) {
      memberMethodsLiterval +=
          '${element.name}: ${convertFunctionFromData(element, this)},';
    });
    return memberMethodsLiterval;
  }

  parseStaticFields(List<FieldDeclarationData> fields) {
    var staticFieldsLiteral = fields
        .where((element) => element.isStatic)
        .map((e) => e.isGetter
            ? '$className.${e.name} = (function() { with ($className) {${e.initVal ?? 'null'}} })();'
            : '$className.${e.name} = (function() { with ($className) { return ${e.initVal ?? 'null'}; } })();')
        .join('\r\n');
    return staticFieldsLiteral;
  }

  parseStaticMethods(List<MethodDeclarationData> methods) {
    var staticMethodsLiteral = methods
        .where((element) => element.isStatic)
        .map((e) =>
            '$className.${e.name} = ${convertFunctionFromData(e, this)};')
        .join('\r\n');
    return staticMethodsLiteral;
  }

  parseInstanceConstruction() {
    var instanceConstruction = !isFactoryDefaultContructor
        ? '''
          const inner = $className.$innerName;
          if (this == __global__) {
            return new $className({$argsName: arguments});
          } else {
            const args = arguments.length > 0 ? arguments[0].$argsName || arguments : [];
            inner.apply(this, args);
            $className.prototype.$constructorAlias.apply(this, args);
            return this;
          }
        '''
        : '''
          return $className.$factoryConstructorAlias.apply($className, arguments);
        ''';
    return instanceConstruction;
  }

  parseBeanToJson() {
    var beanToJson = '''
          toJson: function() {
            let res = {};
            ${fields.map((element) => 'res.${element.name} = this.${element.name};').join('\r\n')}
            return JSON.stringify(res);
          },
        ''';
    return beanToJson;
  }

  parseBeanFromJson() {
    var beanFromJson = '''
        $className.fromJson = function(json) {
            if (typeof json == 'string') {
              json = JSON.parse(json);
            }
            var res = new $className();
            ${fields.map((element) => 'res.${element.name} = json.${element.name};').join('\r\n')}
            return res;
          };
        ''';
    return beanFromJson;
  }

}
