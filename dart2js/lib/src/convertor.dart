/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'dart:collection';
import 'dart:io';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:dartToJs/src/list_ext.dart';
import 'package:path/path.dart' as p;

enum ClassOutputTemplateType { raw, pageState }

const superSubstitution = '__super__';
const argsName = '__args__';
const innerName = '__inner__';
const constructorAlias = 'ctor';
const factoryConstructorAlias = '__fty__ctor__';
const thisAlias = '__thiz__';
const setStateMehtodName = 'setState';
const FairKeyPlaceholder = '#FairKey#';

const commonJs = '''
var __global__ = global;
global.int = {
  parse: function(source, {radix} = {}) {
    return parseInt(source, radix || 10);
  }
};
var print = console.log.bind(console);
function inherit(cls, sup) {
    var oldProto = cls.prototype;
    cls.prototype = Object.create(Object.create(sup.prototype));
    Object.assign(cls.prototype, oldProto);
    cls.prototype.constructor = cls;
    cls.prototype.$superSubstitution = cls.prototype.__proto__;
}

function convertObjectLiteralToSetOrMap(obj) {
  let isSet = Object.prototype.toString.call(obj) == '[object Array]';
  if (!isSet) {
    let keys = Object.getOwnPropertyNames(obj);
    let res = new Map();
    keys.forEach(k => res.set(k, obj[k]));
    return res;
  } else {
    let res = new Set();
    obj.forEach(item => res.add(item));
    return res;
  }
}

Object.prototype.ctor = function(){};
Object.__inner__ = function(){};
''';

class TranspileOption {
  bool modifySetState = false;
}

var transpileOption = TranspileOption();

class OperatorOverloadSymbol {
  static final add = '__op_add__';
  static final minus = '__op_minus__';
  static final negative = '__op_ngt__';
  static final multi = '__op_multi__';
  static final idivide = '__op_idivide__';
  static final lessThan = '__op_lt__';
  static final greaterThan = '__op_gt__';
  static final lessEqualThan = '__op_lte__';
  static final greaterEqualThan = '__op_gte__';
  static final equal = '__op_eq__';
  static final index = '__op_idx__';
  static final indexEqual = '__op_idxeq__';
}

String resolvePath(basePath, relativePath) {
  var p1 = p.split(basePath);
  var p2 = p.split(relativePath);
  for (var segment in p2) {
    if (segment == '..') {
      p1.removeLast();
    } else if (segment == '.') {
      continue;
    } else {
      p1.add(segment);
    }
  }
  return p.joinAll(p1);
}

class MethodDeclarationData {
  var name = '';
  var body = '';
  var _isGenerativeConstructor = false;
  var _isRedirectConstructor = false;
  var isArrow = false;
  var _isStatic = false;
  var _isFactory = false;

  bool get isRedirectConstructor => _isRedirectConstructor;

  set isRedirectConstructor(bool val) {
    _isRedirectConstructor = true;
    if (val) {
      _isGenerativeConstructor = val;
    }
  }

  bool get isStatic => _isStatic;

  set isStatic(bool val) {
    if (!val && (_isFactory || _isGenerativeConstructor)) {
      throw 'invalid value';
    }
    _isStatic = val;
  }

  bool get isGenerativeConstructor => _isGenerativeConstructor;

  set isGenerativeConstructor(bool val) {
    if (isRedirectConstructor && !val) {
      throw 'invalid value';
    }
    _isGenerativeConstructor = val;
    if (val) {
      isStatic = val;
    }
  }

  bool get isFactory => _isFactory;

  set isFactory(bool val) {
    _isFactory = val;
    if (val) {
      isStatic = val;
    }
  }

  var renamedParameters = HashMap<int, String>();
  var abtractedInitializer = <String>[];

  MethodDeclarationData(this.name, this.body, this.isArrow);
}

class FieldDeclarationData {
  String? name;
  String? initVal;
  var isStatic = false;
  var isGetter = false;

  FieldDeclarationData(this.name, this.initVal);
}

class ClassDeclarationData {
  String? className = '';
  var fields = <FieldDeclarationData>[];
  var methods = <MethodDeclarationData>[];
  var outputTemplateType = ClassOutputTemplateType.raw;
  String? parentClass = '';
  bool isDataBean = false;

  String genJsCode() {
    var tpl = '';
    switch (outputTemplateType) {
      case ClassOutputTemplateType.raw:
        {
          var fieldsLiterval = '';
          fields.where((element) => !element.isStatic).forEach((element) {
            element.isGetter ?
            fieldsLiterval += 'this.${element.name} = (function(_this) { with (_this) {${element.initVal ?? 'null'} } })(this);' :
            fieldsLiterval += 'this.${element.name} = ${element.initVal};';
          });
          var memberMethodsLiterval = '';
          methods.where((element) => !(element.isStatic)).forEach((element) {
            memberMethodsLiterval += '${element.name}: ${convertFunctionFromData(element, this)},';
          });
          var staticFieldsLiteral =
              fields.where((element) => element.isStatic).map((e) => e.isGetter
                  ? '$className.${e.name} = (function() { with ($className) {${e.initVal ?? 'null'}} })();'
                  : '$className.${e.name} = (function() { with ($className) { return ${e.initVal ?? 'null'}; } })();').join('\r\n');
          var staticMethodsLiteral = methods.where((element) => element.isStatic).map((e) => '$className.${e.name} = ${convertFunctionFromData(e, this)};').join('\r\n');
          var defaultContructorIsFactory = methods.firstWhereOrNull((element) => element.isFactory == true && element.name == factoryConstructorAlias, orElse: () => null) != null;
          var autoGenDefaultConstructor = methods.firstWhereOrNull((element) => !element.isStatic && element.name == constructorAlias, orElse: () => null) == null;
          var defaultConstructor = '''
          $className.prototype.$constructorAlias = function() {
            ${(parentClass != null && parentClass!.isNotEmpty) ? parentClass : 'Object'}.prototype.$constructorAlias.call(this);
          };
        ''';
          var instanceConstruction = !defaultContructorIsFactory
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
          var beanToJson = '''
          toJson: function() {
            let res = {};
            ${fields.map((element) => 'res.${element.name} = this.${element.name};').join('\r\n')}
            return JSON.stringify(res);
          },
        ''';
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
        ${autoGenDefaultConstructor ? defaultConstructor : ''}
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
            methodsLiterval += '${element.name}: ${convertFunctionFromData(element, this)},';
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
}

class UniqueNameGenerator {
  static final _instance = UniqueNameGenerator._internal();
  int seq = 0;

  factory UniqueNameGenerator() => _instance;

  void reset() {
    _instance.seq = 0;
  }

  String next() {
    seq++;
    return '__temp_f_$seq\_\_';
  }

  UniqueNameGenerator._internal();
}

class ClassDeclarationVisitor extends RecursiveAstVisitor<ClassDeclarationVisitor> {
  List<ClassDeclarationData> classes = [];
  bool isDataBean;
  List<MethodDeclaration> getterList = [];

  ClassDeclarationVisitor([this.isDataBean = false]);

  @override
  ClassDeclarationVisitor? visitClassDeclaration(ClassDeclaration node) {
    var classDeclarationData = ClassDeclarationData();
    classDeclarationData.isDataBean = isDataBean;
    classDeclarationData.className = node.name.name;
    if (node.extendsClause != null) {
      classDeclarationData.parentClass = node.extendsClause!.superclass.toString();
    }
    node.members.forEach((element) {
      if (element is FieldDeclaration) {
        var fieldDeclaration = element.fields.variables.first.toString().split('=');
        classDeclarationData.fields
            .add(FieldDeclarationData(fieldDeclaration[0].trim(), fieldDeclaration.length == 2 ? convertExpression(fieldDeclaration[1].trim()) : null)..isStatic = element.isStatic);
      } else if (element is MethodDeclaration) {
        if (isDataBean && ['fromJson', 'toJson'].contains(element.name.name)) {
          return;
        }
        if (element.isGetter) {
          getterList.add(element);
          return;
        }
        // var fairWellExp = RegExp(r"@FairWell\('(.+)'\)");
        // if (fairWellExp.allMatches(element.metadata.first.toString()).isNotEmpty) {
        var excludeMethods = ['build'];
        if (!excludeMethods.contains(element.name.name)) {
          classDeclarationData.methods.add(MethodDeclarationData(
              element.name.name, '${element.returnType.toString()} ${element.name.name}${element.parameters.toString()}${element.body.toString()}', element.body is ExpressionFunctionBody)
            ..isStatic = element.isStatic);
        }
        // }
      } else if (element is ConstructorDeclaration) {
        if (isDataBean && ['fromJson', 'toJson'].contains(element.name?.name)) {
          return;
        }
        var idx = 0;
        var constructorBody = element.body.toString();
        if (element.body is EmptyFunctionBody) {
          constructorBody = '{}';
        }
        constructorBody = '$constructorAlias${element.parameters.toString()}$constructorBody';
        var methodDeclaration = MethodDeclarationData(element.name?.name ?? constructorAlias, constructorBody, element.body is ExpressionFunctionBody);
        if (element.factoryKeyword?.stringValue == 'factory') {
          methodDeclaration.isFactory = true;
          methodDeclaration.name = (element.name == null) ? factoryConstructorAlias : element.name!.name;
        } else {
          methodDeclaration.isGenerativeConstructor = element.name != null;
        }
        element.parameters.parameters.forEach((element) {
          if (element is FieldFormalParameter) {
            var newParamName = UniqueNameGenerator().next();
            methodDeclaration
              ..renamedParameters[idx] = newParamName
              ..abtractedInitializer.add('${element.toString()} = $newParamName;');
          } else if (element is DefaultFormalParameter) {
            if (element.parameter is FieldFormalParameter) {
              var newParamName = element.parameter.identifier.toString();
              methodDeclaration
                ..renamedParameters[idx] = newParamName
                ..abtractedInitializer.add('${element.parameter.toString()} = $newParamName;');
            }
          }
          idx++;
        });
        var callSuperConstructorImplicitly = false;
        element.initializers.forEach((initializer) {
          if (initializer is SuperConstructorInvocation) {
            callSuperConstructorImplicitly = true;
            var params = initializer.argumentList.arguments.map((e) => e.toString()).join(',');
            methodDeclaration.abtractedInitializer.add('${classDeclarationData.parentClass}.prototype.$constructorAlias.call($thisAlias${params.isEmpty ? '' : ',$params'});');
          } else if (initializer is ConstructorFieldInitializer) {
            methodDeclaration.abtractedInitializer.add('this.${initializer.fieldName} = ${convertExpression(initializer.expression.toString())};');
          } else if (initializer is RedirectingConstructorInvocation) {
            var params = initializer.argumentList.arguments.map((e) => convertExpression(e.toString())).join(',');
            methodDeclaration.abtractedInitializer.add('return new ${element.returnType.name}($params);');
            methodDeclaration.isRedirectConstructor = true;
          } else {
            throw 'Unhandled constructor element ${element.toString()}';
          }
        });
        if (!callSuperConstructorImplicitly && !methodDeclaration.isRedirectConstructor && !methodDeclaration.isFactory) {
          methodDeclaration.abtractedInitializer.insert(0,
              '${classDeclarationData.parentClass == null || classDeclarationData.parentClass!.isEmpty ? 'Object' : classDeclarationData.parentClass}.prototype.$constructorAlias.call($thisAlias);');
        }
        classDeclarationData.methods.add(methodDeclaration);
      }
    });
    if (getterList.length > 0) {
      getterList.forEach((element) {
        var elementBody = element.body.toString();
        if (element.body is EmptyFunctionBody) {
          elementBody = '{}';
        }
        if (element.body is ExpressionFunctionBody) {
          classDeclarationData.fields.add(FieldDeclarationData(
              element.name.name.trim(),
              "return ${convertExpression(element.body.toString().replaceAll("=>", "").trim())};")
            ..isStatic = element.isStatic
            ..isGetter = true);
        } else {
          var methodDeclaration = MethodDeclarationData(
              element.name.name.trim(),
              "void test() ${elementBody}",
              element.body is ExpressionFunctionBody);
          // stdout.writeln("fieldDeclaration[1].trim === ${convertFunctionFromData(methodDeclaration)}");
          var res = parseString(content: methodDeclaration.body);

          var generator = SimpleFunctionGenerator(
              isArrowFunc: false,
              renamedParameters: methodDeclaration.renamedParameters,
              parentClass: classDeclarationData?.parentClass);

          generator.func
            ?..withContext = true
            ..classHasStaticFields = element.isStatic;
          res.unit.visitChildren(generator);

          classDeclarationData.fields.add(FieldDeclarationData(
              element.name.name, generator.func?.body.toSource())
            ..isStatic = element.isStatic
            ..isGetter = true);
        }
        return;
      });
    }
    classes.add(classDeclarationData);
    return null;
  }

  void parseByFile(String filePath) {
    var file = File(filePath);
    var result = parseFile(path: file.absolute.uri.normalizePath().path, featureSet: FeatureSet.fromEnableFlags([]));
    result.unit.visitChildren(this);
  }

  void parseByString(String content) {
    var res = parseString(content: content);
    res.unit.visitChildren(this);
  }

  String genJsCode() {
    return classes.map((e) => e.genJsCode()).join('\r\n');
  }
}

class WidgetStateGenerator extends RecursiveAstVisitor<WidgetStateGenerator> {
  static var FairPropsAttribute = 'FairProps';
  static var InitPropsName = '__initProps__';
  var baseFilePath = '';
  var moduleSequence = 1;
  Map<String, String> dependencyCache = {}; // module path / module sequence

  var classDeclarationData = ClassDeclarationData();
  var allStates = <ClassDeclarationData?>[];
  var allInnerDataClasses = <ClassDeclarationData>[];

  WidgetStateGenerator(this.baseFilePath);

  void goThroughMembers(ClassDeclaration node, ClassDeclarationData tempClassDeclaration) {
    node.members.forEach((element) {
      if (element is FieldDeclaration) {
        var fieldDeclaration = element.fields.variables.first.toString().split('=');
        var hasFairPropsAttribute = element.metadata.any((elem) => elem.name.toString() == FairPropsAttribute);
        tempClassDeclaration.fields.add(FieldDeclarationData(
            fieldDeclaration[0].trim(),
            fieldDeclaration.length == 2
                ? convertExpression(fieldDeclaration[1].trim())
                : hasFairPropsAttribute
                    ? InitPropsName
                    : null));
      } else if (element is MethodDeclaration) {
        // var fairWellExp = RegExp(r"@FairWell\('(.+)'\)");
        // if (fairWellExp.allMatches(element.metadata.first.toString()).isNotEmpty) {
        var excludeMethods = ['build'];
        if (!excludeMethods.contains(element.name.toString()) && element.returnType.toString() != 'Widget') {
          tempClassDeclaration.methods.add(MethodDeclarationData(element.name.toString(), element.toString(), element.body is ExpressionFunctionBody));
        }
        // }
      }
    });
  }

  String findCreateStateReturn(FunctionBody body) {
    if (body is BlockFunctionBody) {
      ReturnStatement? returnStatement = body.block.statements.singleWhereOrNull((element) => element is ReturnStatement, orElse: () => null) as ReturnStatement?;
      assert(returnStatement != null, 'too complicated createState implementation');
      assert(returnStatement?.expression is MethodInvocation, 'too complicated return expression in method createState');
      return (returnStatement?.expression as MethodInvocation).methodName.name;
    } else if (body is ExpressionFunctionBody) {
      assert(body.expression is MethodInvocation, 'too complicated return expression in method createState');
      return (body.expression as MethodInvocation).methodName.name;
    } else {
      throw 'Unsupported body in method createState';
    }
  }

  @override
  WidgetStateGenerator? visitClassDeclaration(ClassDeclaration node) {
    var stateExp = RegExp(r'^State(<.+>)?$');

    var tempClassDeclaration = ClassDeclarationData();
    tempClassDeclaration.className = node.name.name;
    goThroughMembers(node, tempClassDeclaration);
    if (node.extendsClause != null && stateExp.allMatches(node.extendsClause!.superclass.toString()).isNotEmpty) {
      allStates.add(tempClassDeclaration);
      if (classDeclarationData.className != null && classDeclarationData.className == tempClassDeclaration.className) {
        classDeclarationData = tempClassDeclaration;
      }
    } else if (node.extendsClause == null || node.extendsClause!.superclass.toString() == 'Object') {
      allInnerDataClasses.add(tempClassDeclaration);
    }
    var fairPatchAttributeName = 'FairPatch';
    const statefulWidgetClassName = 'StatefulWidget';
    const statelessWidgetClassName = 'StatelessWidget';
    if (node.metadata.isNotEmpty && node.metadata.any((item) => item.name.toString() == fairPatchAttributeName)) {
      if (node.extendsClause != null) {
        switch (node.extendsClause!.superclass.toString()) {
          case statefulWidgetClassName:
            var member = node.members.firstWhereOrNull((element) => element is MethodDeclaration && element.name.toString() == 'createState', orElse: () => null);
            if (member != null) {
              var expectedStateClassName = ((member as MethodDeclaration).returnType as TypeName).name.name;
              if (expectedStateClassName == 'State') {
                expectedStateClassName = findCreateStateReturn(member.body);
              }
              var data = allStates.firstWhere((element) => element?.className == expectedStateClassName, orElse: () => null);
              if (data != null) {
                classDeclarationData = data;
              } else {
                classDeclarationData.className = expectedStateClassName;
              }
            } else {
              throw 'method createState is not found in class ${node.name.toString()}';
            }
            break;
          case statelessWidgetClassName:
            classDeclarationData.className = node.name.name;
            goThroughMembers(node, classDeclarationData);
            break;
          default:
            // nothing to do
            break;
        }
      }
    }
    return null;
  }

  void generateDependencies(String refererPath, List<Tuple<String, bool, String>> imports, List<String> result) {
    if (imports.isEmpty) {
      return;
    }

    var dependencySequences = reserveSequence(imports.length);
    var index = 0;
    imports.forEach((element) {
      var absPath = resolvePath(p.dirname(refererPath), element.k1);
      if (dependencyCache.containsKey(absPath)) {
        return;
      }
      dependencyCache[absPath] = dependencySequences[index];
      var partJsGenerator = PartJsCodeGenerator();
      partJsGenerator.parse(absPath);
      var selfDependencySequences = <String>[];
      if (partJsGenerator.importLocalFiles.isNotEmpty) {
        generateDependencies(absPath, partJsGenerator.importLocalFiles, result);
        selfDependencySequences = reserveSequence(partJsGenerator.importLocalFiles.length, true);
        var index1 = 0;
        partJsGenerator.importLocalFiles.forEach((element) {
          var tempDependencyPath = resolvePath(p.dirname(absPath), element.k1);
          if (dependencyCache.containsKey(tempDependencyPath)) {
            selfDependencySequences[index1] = dependencyCache[tempDependencyPath].toString();
          }
          if (element.k3 != null && element.k3!.isNotEmpty) {
            selfDependencySequences[index1] = '[${selfDependencySequences[index1]},\'${element.k3}\']';
          }
          index1++;
        });
      }
      var classDeclarationVisitor1 = ClassDeclarationVisitor(element.k2 ?? false);
      classDeclarationVisitor1.parseByFile(absPath);
      result.add('''
          defineModule(${dependencySequences[index]}, function(__mod__) {
            with (__mod__.imports) {
              ${classDeclarationVisitor1.genJsCode()}
            }
            ${classDeclarationVisitor1.classes.map((e) => '__mod__.exports.${e.className} = ${e.className};').join('\r\n')}
          }, [${selfDependencySequences.join(',')}]);
          ''');
      index++;
    });
  }

  List<String> reserveSequence(int num, [bool keepSequence = false]) {
    var result = new List<int>.generate(num, (index) => moduleSequence + index).map((item) => item.toString()).toList();
    if (!keepSequence) {
      moduleSequence += num;
    }
    return result;
  }

  String genJsCode() {
    var dependencySequences = <String>[];
    var dependencyClasses = <String>[];
    try {
      var partJsGenerator = PartJsCodeGenerator();
      partJsGenerator.parse(baseFilePath);
      // parse local file dependencies
      // import as? - supported
      // import show / hide - not supported
      // conditional export - not supported
      if (partJsGenerator.importLocalFiles.isNotEmpty) {
        dependencySequences = reserveSequence(partJsGenerator.importLocalFiles.length, true);
        var index = 0;
        partJsGenerator.importLocalFiles.forEach((element) {
          if (element.k3 != null && element.k3!.isNotEmpty) {
            dependencySequences[index] = '[${dependencySequences[index]},\'${element.k3}\']';
          }
          index++;
        });
        generateDependencies(baseFilePath, partJsGenerator.importLocalFiles, dependencyClasses);
      }
    } catch (exception) {
      print(exception);
    }
    classDeclarationData.outputTemplateType = ClassOutputTemplateType.raw;
    return '''
    GLOBAL['$FairKeyPlaceholder'] = (function($InitPropsName) {
      const __global__ = this;
      ${dependencyClasses.join('\r\n')}
      return runCallback(function(__mod__) {
        with(__mod__.imports) {
          ${allInnerDataClasses.map((e) => e.genJsCode()).join('\r\n')}
          ${classDeclarationData.genJsCode()};
          return ${classDeclarationData.className}();
        }
      }, [${dependencySequences.join(',')}]);
    })(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
    ''';
  }
}

class Tuple<K1, K2, K3> {
  K1? k1;
  K2? k2;
  K3? k3;

  Tuple(this.k1, this.k2, this.k3);
}

class PartJsCodeGenerator extends SimpleAstVisitor<PartJsCodeGenerator> {
  // libPath, isDataBean, moduleAlias
  List<Tuple<String, bool, String>> importLocalFiles = <Tuple<String, bool, String>>[];
  var BeanDir = '/bean/';
  var PackagePrefix = new RegExp('(dart|package):');

  @override
  PartJsCodeGenerator? visitImportDirective(ImportDirective node) {
    var libraryPath = node.uri.stringValue;
    if (libraryPath?.contains(BeanDir) == true) {
      importLocalFiles.add(Tuple(libraryPath, true, node.prefix?.toSource()));
    } else if (!(libraryPath?.startsWith(PackagePrefix) ?? false)) {
      importLocalFiles.add(Tuple(libraryPath, false, node.prefix?.toSource()));
    }
    return null;
  }

  void parse(String filePath) {
    var file = File(filePath);
    var result = parseFile(path: Platform.isWindows ? filePath : file.absolute.uri.normalizePath().path, featureSet: FeatureSet.fromEnableFlags([]));
    result.unit.visitChildren(this);
  }
}

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
    if (argumentList.isEmpty && namedArgumentList.isEmpty && optionalArgumentList.isEmpty) {
      return '';
    }
    var res = StringBuffer('{');
    if (argumentList.isNotEmpty) {
      res..write(argumentList.map((e) => e[0]).join(','))..write(',');
    }
    if (namedArgumentList.isNotEmpty) {
      res..write(namedArgumentList.map((e) => e[0]).join(','))..write(',');
    }
    if (optionalArgumentList.isNotEmpty) {
      res..write(optionalArgumentList.map((e) => e[0]).join(','))..write(',');
    }
    res.write('}');
    return res.toString();
  }

  String withArgumentObjAsNeeded(String body) {
    if (argumentList.isEmpty && namedArgumentList.isEmpty && optionalArgumentList.isEmpty) {
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
      namedArgs += '''{${namedArgumentList.map((e) => e[0] + (e.length == 2 ? '=' + e[1] : '')).join(',')}}={}''';
    }
    var optionalArgs = '';
    if (optionalArgumentList.isNotEmpty) {
      if (namedArgumentList.isNotEmpty || argumentList.isNotEmpty) {
        optionalArgs = ',';
      }
      optionalArgs += '''${optionalArgumentList.map((e) => e[0] + (e.length == 2 ? '=' + e[1] : '')).join(',')}''';
    }

    var finalBody = withContext ? wrapBodyWithCtx() : body.toSource();

    return '''${isAsync ? 'async ' : ''}function $name(${argumentList.map((elem) => elem[0]).join(',')}$namedArgs$optionalArgs) { 
      $finalBody
    }''';
  }
}

class ArrowFunctionExpressionNode extends FunctionDeclarationNode {
  @override
  String toSource() {
    return '''
      ${isAsync ? 'async ' : ''}(${argumentList.map((elem) => elem[0]).join(',')}) => ${addCommaAsNeeded(body.statements[0].toSource())}
    ''';
  }
}

class FunctionBodyNode {
  List<StatementNode> statements = [];

  void push(StatementNode node) {
    statements.add(node);
  }

  String toSource() {
    return statements.map((e) => e.toSource()).join('\r\n');
  }
}

class StatementNode {
  String toSource() {
    return '';
  }

  @override
  String toString() {
    return toSource();
  }
}

// 原样输出的语句
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

// bool表达式进行特殊处理：

// 不支持如下运算符的嵌套：三目运算符、类型测试
class ConditionalExpressionNode extends StatementNode {
  GenericStatementNode? condition;
  GenericStatementNode? then;
  GenericStatementNode? elseExpr;

  @override
  String toSource() {
    return '''${condition?.toSource()} ? ${then?.toSource()} : ${elseExpr?.toSource()}''';
  }
}

class ParenthesizedExpressionNode extends GenericStatementNode {
  ParenthesizedExpressionNode(String code_) : super(code_);

  @override
  String toSource() {
    return '''($code)''';
  }
}

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

class BinaryExpressionNode extends StatementNode {
  String? operator;
  GenericStatementNode? left;
  GenericStatementNode? right;

  @override
  String toSource() {
    return '''${left?.toSource()}$operator${right?.toSource()}''';
  }
}

class PrefixExpressionNode extends StatementNode {
  String? operator;
  GenericStatementNode? operand;

  @override
  String toSource() {
    return '''$operator${operand?.toSource()}''';
  }
}

class DeclarationStatmentNode extends StatementNode {
  List<String> variables = [];

  @override
  String toSource() {
    return '''
      let ${variables.join(',')};
    ''';
  }
}

class WhileStatementNode extends StatementNode {
  String? condition;
  String? body;

  @override
  String toSource() {
    var finalBody = body == null || body?.isEmpty == true
        ? ';'
        : '''
    {
      $body
    }
    ''';
    return '''
    while ($condition) $finalBody
    ''';
  }
}

class DoWhileStatementNode extends WhileStatementNode {
  @override
  String toSource() {
    return '''
    do {
      $body
    } while ($condition);
    ''';
  }
}

class IfStatementNode extends StatementNode {
  String? condition;
  String? thenBody;
  String? lastElseBody;
  IfStatementNode? elseBody;

  @override
  String toSource() {
    var finalElseBody = '';
    if (elseBody != null) {
      finalElseBody = '''
      else ${elseBody?.toSource()}
      ''';
    } else if (lastElseBody != null) {
      finalElseBody = lastElseBody?.isEmpty == true
          ? ''
          : '''
      else {
        $lastElseBody
      }
    ''';
    }
    return '''
    if ($condition) {
      $thenBody
    } $finalElseBody
    ''';
  }
}

class SwitchStatementNode extends StatementNode {
  GenericStatementNode? expr;
  List<List<String>>? cases;
  String? default_;

  String genCase(List<String> case_) {
    return case_.length == 2
        ? '''
    case ${case_[0]}:
    ${case_[1]}
    '''
        : '''
    case ${case_[0]}:
    ''';
  }

  String genDefault() {
    return default_ != null && default_!.isNotEmpty
        ? '''
    default:
      $default_
    '''
        : '';
  }

  @override
  String toSource() {
    return '''
    switch (${expr?.toSource()}) {
      ${cases != null && cases!.isNotEmpty ? cases?.map((e) => genCase(e)).join('') : ''}
      ${genDefault()}
    }
    ''';
  }
}

String? addCommaAsNeeded(String? statement) {
  if (statement?.endsWith(';') == true) {
    return statement;
  }
  return (statement ?? '') + ';';
}

String removeCommaAsNeeded(String statement) {
  if (!statement.endsWith(';')) {
    return statement;
  }
  return statement.substring(0, statement.lastIndexOf(';'));
}

class ForStatementNode extends StatementNode {
  String initExpr = '';
  String? conditionalExpr;
  String stepExpr = '';
  String? body;

  @override
  String toSource() {
    return '''
    for (${initExpr.isEmpty ? ';' : initExpr} ${addCommaAsNeeded(conditionalExpr)} ${removeCommaAsNeeded(stepExpr)}) {
      $body
    }
    ''';
  }
}

class ForInStatementNode extends StatementNode {
  String? loopVariable;
  GenericStatementNode? iterable;
  String? body;

  @override
  String toSource() {
    return '''
    for (let $loopVariable in ${iterable?.toSource()}) {
      $body
    }
    ''';
  }
}

class MemberAccessStatementNode extends StatementNode {
  String? thiz;
}

class MethodInvokeStatementNode extends MemberAccessStatementNode {
  String? methodName;
  List<String> unnamedParameters = [];
  List<List<String>> namedParameters = [];
  String? parentClassName;

  @override
  String toSource() {
    var finalNamedParameters = StringBuffer();
    if (unnamedParameters.isNotEmpty && namedParameters.isNotEmpty) {
      finalNamedParameters.write(',');
    }
    if (namedParameters.isNotEmpty) {
      finalNamedParameters.write('{');
      finalNamedParameters.write(namedParameters.map((e) => '''${e[0]}:${e[1]}''').join(','));
      finalNamedParameters.write('}');
    }

    if (thiz != null && thiz?.trim() == superSubstitution) {
      var params = '${unnamedParameters.join(',')}${finalNamedParameters.toString()}';
      if (parentClassName == null || parentClassName!.isEmpty) {
        return '';
      }
      return '$parentClassName.prototype.$methodName.call(this${params.isEmpty ? '' : ',$params'});';
    }
    if (transpileOption.modifySetState && methodName == setStateMehtodName) {
      unnamedParameters.insert(0, "'$FairKeyPlaceholder'");
    }
    return '''
    ${thiz != null && thiz!.isNotEmpty ? thiz! + '.' : ''}$methodName(${unnamedParameters.join(',')}${finalNamedParameters.toString()});
    ''';
  }
}

class PropertyAccessStatementNode extends MemberAccessStatementNode {
  String? fieldName;
  String? setVal;

  @override
  String toSource() {
    var finalThiz = thiz != null && thiz!.trim() == superSubstitution ? 'this' : thiz;
    return '''
    ${finalThiz?.isNotEmpty == true ? finalThiz! + '.' : ''}$fieldName${setVal == null ? '' : '=' + setVal! + ';'}
    ''';
  }
}

class ReturnStatementNode extends StatementNode {
  String? expr;

  @override
  String toSource() {
    return '''
    return $expr${!(expr?.endsWith(';') ?? false) ? ';' : ''}
    ''';
  }
}

class CascadeOperatorStatementNode extends StatementNode {
  String? target;
  List<MemberAccessStatementNode>? cascades;

  @override
  String toSource() {
    var tempThiz = '__target__';
    cascades?.forEach((element) {
      element.thiz = tempThiz;
    });
    return '''(function() {
      let $tempThiz = $target;
      ${cascades?.map((e) => e.toSource()).join('')}
      return $tempThiz;
    })()
    ''';
  }
}

class AwaitStatementNode extends StatementNode {
  StatementNode? expr;

  @override
  String toSource() {
    return '''await ${addCommaAsNeeded(expr?.toSource())}''';
  }
}

class AssignmentStatementNode extends StatementNode {
  String? leftSide;
  String operator_ = '=';
  GenericStatementNode? rightSide;

  @override
  String toSource() {
    return '$leftSide $operator_ ${addCommaAsNeeded(rightSide?.toSource())}';
  }
}

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

class ListLiteralStatementNode extends StatementNode {
  List<StatementNode> elements = [];
  static const elsePlaceholder = '"__if_element_placeholder__"';
  var hasPlaceholder = false;

  void addElement(CollectionElement e) {
    var code = '';
    if (e is SpreadElement) {
      code = '...${convertExpression(e.expression.toString())}';
    } else if (e is IfElement) {
      hasPlaceholder = e.elseElement == null;
      var elseElem = hasPlaceholder ? elsePlaceholder : convertExpression(e.elseElement.toString());
      code = '(${convertExpression(e.condition.toString())}) ? ${convertExpression(e.thenElement.toString())} : $elseElem';
    } else {
      code = convertExpression(e.toString());
    }
    elements.add(GenericStatementNode(code));
  }

  @override
  String toSource() {
    return !hasPlaceholder
        ? '[${elements.map((e) => e.toString()).join(",")}]'
        : '''
    (function() {
      let __arr__ = [${elements.map((e) => e.toString()).join(",")}];
      return __arr__.filter(elem => elem !== $elsePlaceholder);
    })();
    ''';
  }
}

class SimpleFunctionGenerator extends GeneralizingAstVisitor<SimpleFunctionGenerator> {
  FunctionDeclarationNode? func;
  String? parentClass;
  HashMap<int, String>? renamedParameters;

  SimpleFunctionGenerator({bool isArrowFunc = false, this.renamedParameters, this.parentClass}) {
    func = isArrowFunc ? ArrowFunctionExpressionNode() : FunctionDeclarationNode();
  }

  @override
  SimpleFunctionGenerator? visitFunctionDeclaration(FunctionDeclaration node) {
    func?.name = node.name.toString();
    return super.visitFunctionDeclaration(node);
  }

  @override
  SimpleFunctionGenerator? visitFormalParameterList(FormalParameterList node) {
    var idx = 0;
    node.parameters.forEach((param) {
      var ident = param.identifier.toString();
      if (renamedParameters != null && renamedParameters!.containsKey(idx)) {
        ident = renamedParameters![idx]!;
      }
      var arg = [ident];

      if (param.isNamed) {
        if (param is DefaultFormalParameter && (param.defaultValue != null)) {
          arg.add(param.defaultValue.toString());
        }
        func?.namedArgumentList.add(arg);
      } else if (param.isOptional) {
        if (param is DefaultFormalParameter && (param.defaultValue != null)) {
          arg.add(param.defaultValue.toString());
        }
        func?.optionalArgumentList.add(arg);
      } else {
        func?.argumentList.add(arg);
      }

      idx++;
    });
    return null;
  }

  @override
  SimpleFunctionGenerator? visitBlockFunctionBody(BlockFunctionBody node) {
    func?.isAsync = node.isAsynchronous;
    return super.visitBlockFunctionBody(node);
  }

  MethodInvokeStatementNode handleMethodInvocation(MethodInvocation currentNode) {
    var gnNode = MethodInvokeStatementNode();
    gnNode.parentClassName = parentClass;
    gnNode.thiz = currentNode.target != null ? convertExpression(currentNode.target.toString()) : '';
    gnNode.methodName = currentNode.methodName.toString();
    currentNode.argumentList.arguments.forEach((arg) {
      if (arg is NamedExpression) {
        gnNode.namedParameters.add([arg.name.label.toString(), convertExpression(arg.expression.toString())]);
      } else {
        gnNode.unnamedParameters.add(convertExpression(arg.toString()));
      }
    });
    return gnNode;
  }

  NewOperatorStatementNode handleCreationCall(InstanceCreationExpression currentNode) {
    var gnNode = NewOperatorStatementNode();
    gnNode.methodName = currentNode.constructorName.toString();
    currentNode.argumentList.arguments.forEach((arg) {
      if (arg is NamedExpression) {
        gnNode.namedParameters.add([arg.name.label.toString(), convertExpression(arg.expression.toString())]);
      } else {
        gnNode.unnamedParameters.add(convertExpression(arg.toString()));
      }
    });
    return gnNode;
  }

  String handleFuncitonExpression(FunctionExpression currentNode) {
    return currentNode.body is ExpressionFunctionBody ? convertArrayFuncExpression(currentNode) : convertFunctionExpression(currentNode.toString());
  }

  String handleMapLiteral(SetOrMapLiteral literal) {
    if (literal.elements.isEmpty) {
      return '{}';
    } else {
      if (literal.elements.first is MapLiteralEntry) {
        var res = StringBuffer('{');
        literal.elements.cast<MapLiteralEntry>().forEach((element) {
          res.write(
              '[${convertExpression(element.key.toString())}]: ${element.value is MapLiteralEntry ? handleMapLiteral(element.value as SetOrMapLiteral) : convertExpression(element.value.toString())},');
        });
        res.write('}');
        return res.toString();
      } else {
        var res = StringBuffer('[');
        literal.elements.forEach((element) {
          res.write('${convertExpression(element.toString())},');
        });
        res.write(']');
        return res.toString();
      }
    }
  }

  @override
  SimpleFunctionGenerator? visitNode(AstNode node) {
    if (node is ExpressionStatement) {
      if (node.expression is MethodInvocation) {
        func?.body.push(handleMethodInvocation(node.expression as MethodInvocation));
      } else if (node.expression is PropertyAccess) {
        var gnNode = PropertyAccessStatementNode();
        var currentNode = node.expression as PropertyAccess;
        if (currentNode.target != null) {
          gnNode.thiz = convertExpression(currentNode.target.toString());
        }
        gnNode.fieldName = currentNode.propertyName.toString();
        func?.body.push(gnNode);
      } else if (node.expression is FunctionExpression) {
        func?.body.push(GenericStatementNode(handleFuncitonExpression(node.expression as FunctionExpression)));
      } else if (node.expression is AssignmentExpression) {
        var gnNode = AssignmentStatementNode();
        var currentNode = node.expression as AssignmentExpression;
        if (currentNode.leftHandSide is IndexExpression) {
          var gnNode1 = IndexExpressionNode();
          var currentNode1 = currentNode.leftHandSide as IndexExpression;
          gnNode1.key = GenericStatementNode(convertExpression(currentNode1.index.toString()));
          gnNode1.target = GenericStatementNode(convertExpression(currentNode1.target.toString()));
          gnNode1.value = GenericStatementNode(convertExpression(currentNode.rightHandSide.toString()));
          gnNode1.isSet = true;
          func?.body.push(gnNode1);
        } else {
          gnNode.leftSide = convertExpression(currentNode.leftHandSide.toString());
          gnNode.operator_ = currentNode.operator.toString();
          gnNode.rightSide = GenericStatementNode(convertExpression(currentNode.rightHandSide.toString()));
          func?.body.push(gnNode);
        }
      } else if (node.expression is CascadeExpression) {
        var gnNode = CascadeOperatorStatementNode();
        var currentNode = node.expression as CascadeExpression;
        gnNode.target = convertExpression(currentNode.target.toString());
        gnNode.cascades = [];
        currentNode.cascadeSections.forEach((element) {
          if (element is MethodInvocation) {
            gnNode.cascades?.add(handleMethodInvocation(element));
          } else if (element is AssignmentExpression) {
            if (element.leftHandSide is PropertyAccess) {
              var leftSide = element.leftHandSide as PropertyAccess;
              if (leftSide.isCascaded) {
                var assignmentNode = PropertyAccessStatementNode();
                assignmentNode.fieldName = leftSide.propertyName.toString();
                assignmentNode.setVal = convertExpression(element.rightHandSide.toString());
                gnNode.cascades?.add(assignmentNode);
              } else {
                throw Exception('''Not supported statement(s): ${element.toString()}''');
              }
            }
          } else {
            throw Exception('''Not supported statement(s): ${element.toString()}''');
          }
        });
        func?.body.push(gnNode);
      } else if (node.expression is ConditionalExpression) {
        var gnNode = ConditionalExpressionNode();
        var currentNode = node.expression as ConditionalExpression;
        gnNode.condition = GenericStatementNode(convertExpression(currentNode.condition.toString()));
        gnNode.then = GenericStatementNode(convertExpression(currentNode.thenExpression.toString()));
        gnNode.elseExpr = GenericStatementNode(convertExpression(currentNode.elseExpression.toString()));
        func?.body.push(gnNode);
      } else if (node.expression is IndexExpression) {
        var gnNode = IndexExpressionNode();
        var currentNode = node.expression as IndexExpression;
        gnNode.key = GenericStatementNode(convertExpression(currentNode.index.toString()));
        gnNode.target = GenericStatementNode(convertExpression(currentNode.target.toString()));
        func?.body.push(gnNode);
      } else if (node.expression is ParenthesizedExpression) {
        var currentNode = node.expression as ParenthesizedExpression;
        var gnNode = ParenthesizedExpressionNode(convertExpression(currentNode.expression.toString()));
        func?.body.push(gnNode);
      } else if (node.expression is BinaryExpression) {
        var currentNode = node.expression as BinaryExpression;
        var gnNode = BinaryExpressionNode();
        gnNode.left = GenericStatementNode(convertExpression(currentNode.leftOperand.toString()));
        gnNode.right = GenericStatementNode(convertExpression(currentNode.rightOperand.toString()));
        gnNode.operator = currentNode.operator.toString();
        func?.body.push(gnNode);
      } else if (node.expression is PrefixExpression) {
        var currentNode = node.expression as PrefixExpression;
        var gnNode = PrefixExpressionNode();
        gnNode.operand = GenericStatementNode(convertExpression(currentNode.operand.toString()));
        gnNode.operator = currentNode.operator.toString();
        func?.body.push(gnNode);
      } else if (node.expression is IsExpression) {
        var currentNode = node.expression as IsExpression;
        func?.body.push(GenericStatementNode(convertExpression(currentNode.expression.toString())));
      } else if (node.expression is AsExpression) {
        var currentNode = node.expression as AsExpression;
        func?.body.push(GenericStatementNode(convertExpression(currentNode.expression.toString())));
      } else if (node.expression is AwaitExpression) {
        var gnNode = AwaitStatementNode();
        var currentNode = node.expression as AwaitExpression;
        gnNode.expr = GenericStatementNode(convertExpression(currentNode.expression.toString()));
        func?.body.push(gnNode);
      } else if (node.expression is SingleStringLiteral) {
        func?.body.push(GenericStatementNode(handleStringTemplate(node.expression as SingleStringLiteral)));
      } else if (node.expression is InstanceCreationExpression) {
        var gnNode = NewOperatorStatementNode();
        gnNode = handleCreationCall(node.expression as InstanceCreationExpression);
        func?.body.push(gnNode);
      } else if (node.expression is ListLiteral) {
        var gnNode = ListLiteralStatementNode();
        var currentNode = node.expression as ListLiteral;
        currentNode.elements.forEach((e) => gnNode.addElement(e));
        func?.body.push(gnNode);
      } else {
        func?.body.push(GenericStatementNode(node.toSource()));
      }
      return null;
    } else if (node is ExpressionFunctionBody) {
      func?.body.push(GenericStatementNode(convertExpression(node.expression.toString())));
      return null;
    } else if (node is VariableDeclarationStatement) {
      var gnNode = DeclarationStatmentNode();
      node.variables.variables.forEach((element) {
        if (element.initializer is SingleStringLiteral) {
          gnNode.variables.add('''${element.name.toString()} = ${handleStringTemplate(element.initializer as SingleStringLiteral)}''');
        } else if (element.initializer is FunctionExpression) {
          var currentNode = (element.initializer as FunctionExpression);
          var initializer = handleFuncitonExpression(currentNode);
          gnNode.variables.add('''${element.name.toString()} = $initializer''');
        } else if (element.initializer is SetOrMapLiteral) {
          gnNode.variables.add('''${element.name.toString()} = convertObjectLiteralToSetOrMap(${handleMapLiteral(element.initializer as SetOrMapLiteral)})''');
        } else if (element.initializer is SuperExpression) {
          gnNode.variables.add('''${element.name.toString()} = $superSubstitution''');
        } else {
          if (element.initializer != null) {
            gnNode.variables.add('''${element.name.toString()} = ${convertExpression(element.initializer.toString())}''');
          } else {
            gnNode.variables.add('''${element.name.toString()}''');
          }
        }
      });
      func?.body.push(gnNode);
      return null;
    } else if (node is WhileStatement) {
      var gnNode = WhileStatementNode();
      gnNode.condition = convertExpression(node.condition.toString());
      gnNode.body = node.body is EmptyStatement ? '' : convertBlock(node.body.toString());
      func?.body.push(gnNode);
      return null;
    } else if (node is DoStatement) {
      var gnNode = DoWhileStatementNode();
      gnNode.condition = convertExpression(node.condition.toString());
      gnNode.body = convertBlock(node.body.toString());
      func?.body.push(gnNode);
      return null;
    } else if (node is IfStatement) {
      var gnNode = IfStatementNode();
      handleChainIfStatement(node, gnNode);
      func?.body.push(gnNode);
      return null;
    } else if (node is SwitchStatement) {
      var gnNode = SwitchStatementNode();
      gnNode.expr = GenericStatementNode(convertExpression(node.expression.toString()));
      if (node.members.isNotEmpty) {
        gnNode.cases = [];
        node.members.forEach((element) {
          if (element is SwitchCase) {
            if (element.statements.isEmpty) {
              gnNode.cases?.add([element.expression.toString()]);
            } else {
              gnNode.cases?.add([element.expression.toString(), convertStatements(element.statements.map((e) => e.toString()).join(''))]);
            }
          } else if (element is SwitchDefault) {
            gnNode.default_ = convertStatements(element.statements.map((e) => e.toString()).join(''));
          } else {
            throw Exception('error: ${element.toString()}');
          }
        });
      }
      func?.body.push(gnNode);
      return null;
    } else if (node is ReturnStatement) {
      var gnNode = ReturnStatementNode();
      gnNode.expr = convertExpression(node.expression.toString());
      func?.body.push(gnNode);
      return null;
    } else if (node is ForStatement) {
      var gnNode = ForStatementNode();
      if (node.forLoopParts is ForPartsWithDeclarations) {
        var forLoopParts = node.forLoopParts as ForPartsWithDeclarations;
        gnNode.initExpr = convertStatements(forLoopParts.variables.toString() + ';');
        if (forLoopParts.condition != null) {
          gnNode.conditionalExpr = convertStatements(forLoopParts.condition.toString() + ';');
        }
        gnNode.stepExpr = forLoopParts.updaters.map((e) => convertExpression(e.toString())).join(',');
        gnNode.body = node.body is Block ? convertBlock(node.body.toString()) : convertStatements(node.body.toString());
        func?.body.push(gnNode);
      } else if (node.forLoopParts is ForPartsWithExpression) {
        var forLoopParts = node.forLoopParts as ForPartsWithExpression;
        if (forLoopParts.condition != null) {
          gnNode.conditionalExpr = convertStatements(forLoopParts.condition.toString() + ';');
        }
        gnNode.stepExpr = forLoopParts.updaters.map((e) => convertExpression(e.toString())).join(',');
        gnNode.body = node.body is Block ? convertBlock(node.body.toString()) : convertStatements(node.body.toString());
        func?.body.push(gnNode);
      } else if (node.forLoopParts is ForEachPartsWithDeclaration) {
        var forLoopParts = node.forLoopParts as ForEachPartsWithDeclaration;
        var gnForInNode = ForInStatementNode();
        gnForInNode.loopVariable = forLoopParts.loopVariable.identifier.toString();
        gnForInNode.iterable = GenericStatementNode(convertExpression(forLoopParts.iterable.toString()));
        gnForInNode.body = node.body is Block ? convertBlock(node.body.toString()) : convertStatements(node.body.toString());
        func?.body.push(gnForInNode);
      }

      return null;
    } else if (node is ContinueStatement || node is BreakStatement) {
      func?.body.push(GenericStatementNode(node.toString()));
      return null;
    } else if (node is FunctionDeclarationStatement) {
      func?.body.push(GenericStatementNode(convertFunction(node.functionDeclaration.toString())));
      return null;
    }

    return super.visitNode(node);
  }
}

String handleStringTemplate(SingleStringLiteral node) {
  var res = StringBuffer();
  var quote = '';
  if (node is StringInterpolation) {
    quote = '`';
    res.write(quote);
    node.elements.forEach((element) {
      if (element is InterpolationString) {
        res.write(element.value);
      } else if (element is InterpolationExpression) {
        res.write('''\${${element.expression.toString()}}''');
      }
    });
  } else if (node is SimpleStringLiteral) {
    var lexeme = node.literal.lexeme;
    quote = lexeme.length > 3 && lexeme.substring(0, 3) == "'''" ? '`' : lexeme[0];
    res.write(quote);
    res.write(node.value);
  } else {
    throw 'Unsupported string literal: ${node.stringValue}';
  }

  res.write(quote);
  return res.toString();
}

void handleChainIfStatement(IfStatement? node, IfStatementNode? gnNode) {
  gnNode?.condition = convertExpression(node?.condition.toString() ?? '');
  gnNode?.thenBody = node?.thenStatement is Block ? convertBlock(node?.thenStatement.toString() ?? '') : convertExpression(node?.thenStatement.toString() ?? '');
  if (node?.elseStatement != null) {
    if (node?.elseStatement is IfStatement) {
      gnNode?.elseBody = IfStatementNode();
      handleChainIfStatement(node?.elseStatement as IfStatement?, gnNode?.elseBody);
    } else {
      gnNode?.lastElseBody = node?.elseStatement is Block ? convertBlock(node?.elseStatement.toString() ?? '') : convertExpression(node?.elseStatement.toString() ?? '');
    }
  }
}

String convertExpression(String code) {
  var res = '';
  var start = 0;
  try {
    res = convertStatements(code + ';');
    res = res.trim();
  } on ArgumentError {
    // 有些表达式直接变成语句会报错，例如字典字面量对象
    var prefix = 'var __variable__ = ';
    res = convertStatements('''$prefix$code;''');
    res = res.trim();
    start = res.indexOf('=') + 1;
  }
  var end = res.length - 1;
  while (end >= 0 && RegExp(r'[\s\r\n;]', multiLine: false).hasMatch(res[end])) {
    end--;
  }
  return res.substring(start, end + 1);
}

String convertStatements(String code) {
  if (!code.endsWith(';') && !code.endsWith('}')) {
    code += ';';
  }
  var res = convertBlock('''{$code}''');
  return res;
}

bool shouldErrorBeIgnored(List<AnalysisError> errors) {
  var ignoredErrors = ['CONTINUE_OUTSIDE_OF_LOOP', 'BREAK_OUTSIDE_OF_LOOP'];
  return errors.firstWhereOrNull((err) => !ignoredErrors.contains(err.errorCode.name), orElse: () => null) == null;
}

String convertBlock(String code) {
  var res = parseString(content: '''dummy() async $code''', throwIfDiagnostics: false);

  if (res.errors.isNotEmpty) {
    if (shouldErrorBeIgnored(res.errors)) {
      // ignore
    } else {
      throw ArgumentError();
    }
  }

  var generator = SimpleFunctionGenerator();
  res.unit.visitChildren(generator);
  return generator.func?.body.toSource() ?? '';
}

String convertArrayFuncExpression(FunctionExpression code) {
  var body = code.body as ExpressionFunctionBody;
  if (body.functionDefinition.toString() == '=>') {
    var gnNode = ArrowFunctionExpressionNode();
    // TODO: 支持命名参数、可选参数
    code.parameters?.parameters.forEach((element) {
      gnNode.argumentList.add([element.identifier.toString()]);
    });
    gnNode.body.push(GenericStatementNode(convertExpression(body.expression.toString())));
    return gnNode.toSource();
  } else {
    throw 'error';
  }
}

String convertFunctionExpression(String code) {
  code = 'dummy' + code;
  return convertFunction(code);
}

String convertFunctionFromData(MethodDeclarationData? data, [ClassDeclarationData? ctx]) {
  var res = parseString(content: data?.body ?? '');
  var generator = SimpleFunctionGenerator(isArrowFunc: data?.isArrow ?? false, renamedParameters: data?.renamedParameters, parentClass: ctx?.parentClass);
  generator.func
    ?..withContext = true
    ..classHasStaticFields =
        (ctx?.fields.any((element) => element.isStatic) ?? false) || (ctx?.methods.any((element) => element.isStatic && !element.isFactory && !element.isGenerativeConstructor) ?? false)
    ..isStatic = data?.isStatic ?? false;
  res.unit.visitChildren(generator);

  if (ctx != null) {
    generator.func?.className = ctx.className;
    generator.func
      ?..isGenerativeConstructor = data?.isGenerativeConstructor ?? false
      ..isRedirectConstructor = data?.isRedirectConstructor ?? false;
  }

  if (data?.abtractedInitializer != null && data!.abtractedInitializer.isNotEmpty) {
    generator.func?.body.statements.insert(0, GenericStatementNode(data.abtractedInitializer.join('\r\n')));
  }
  return generator.func?.toSource() ?? '';
}

String convertFunction(String code, {bool isArrow = false, bool isClassMethod = false, bool classHasStaticFields = false}) {
  var res = parseString(content: code);
  var generator = SimpleFunctionGenerator(isArrowFunc: isArrow);
  res.unit.visitChildren(generator);
  generator.func
    ?..withContext = isClassMethod
    ..classHasStaticFields = classHasStaticFields;
  return generator.func?.toSource() ?? '';
}

//
// 去掉类型转换
// 支持匿名集合对象
// try-catch
// yeild
// 列表、Map对象、RegExp、Date、其他基础数据类型及其对应操作
//
// 操作符：,、~/
// escaped string（r修饰符）
// int.parse
// operator override
// get & set
// 高级特性：扩展方法 & part文件合并 & mixin & noSuchMethod
// 范型
// 注解(annotation)
// async: stream completer yield zone
// 省略的this
//
//
// done
// declare
// asignment
// static
// extend & super & constructor
// if / for / do-while / while-do / switch / for-in
// continue&break
// method-invoke&cacades
// inner function
// async&await
// new操作
// ?. / ... / ?: if表达式
// 对 bool表达式中的 is 进行处理
// 表达式嵌套
// is 类型检测 直接判断对象是否为空
// as 类型转换 直接去掉类型转换
//
String convertWidgetStateFile(String filePath, [bool isCompressed = false]) {
  var file = File(filePath);
  var stateFilePath = Platform.isWindows ? filePath : file.absolute.uri.normalizePath().path;
  var result = parseFile(path: stateFilePath, featureSet: FeatureSet.fromEnableFlags([]));
  var visitor = WidgetStateGenerator(stateFilePath);
  result.unit.visitChildren(visitor);

  transpileOption.modifySetState = true;
  return isCompressed ? uglify(visitor.genJsCode()) : visitor.genJsCode();
}

String convertClassString(String content, [bool isDataBean = false]) {
  var result = parseString(content: content, featureSet: FeatureSet.fromEnableFlags([]));
  var visitor = ClassDeclarationVisitor(isDataBean);
  result.unit.visitChildren(visitor);

  return visitor.genJsCode();
}

String uglify(String str) {
  // 不用处理注释
  var buf = StringBuffer();
  var isInString = false;
  var lastCh = '';
  void writeCh(String s) {
    buf.write(s);
    lastCh = s;
    assert(!(s == '\r' || s == '\n'));
  }

  for (var i = 0; i < str.length; i++) {
    if (isInString) {
      writeCh(str[i]);
      if ((str[i] == '\'' || str[i] == '"' || str[i] == '`') && (i < 1 || str[i - 1] != '\\')) {
        isInString = false;
      }
    } else {
      if ((str[i] == '\'' || str[i] == '"' || str[i] == '`') && (str[i - 1] != '\\')) {
        isInString = true;
        writeCh(str[i]);
      } else {
        if (str[i] == '\r' || str[i] == '\n') {
          continue;
        } else if (str[i] == ' ') {
          do {
            i++;
          } while (i < str.length && str[i] == ' ');
          if (buf.isNotEmpty) {
            if (i < str.length) {
              var pat = RegExp(r'^[a-zA-Z_\d]$');
              if (pat.hasMatch(lastCh) && pat.hasMatch(str[i])) {
                writeCh(' ');
              }
              i--;
            } else {
              break;
            }
          } else {
            if (i < str.length) {
              i--;
            } else {
              break;
            }
          }
        } else {
          writeCh(str[i]);
        }
      }
    }
  }
  return buf.toString();
}
