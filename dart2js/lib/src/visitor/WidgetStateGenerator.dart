import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:fair_dart2js/src/list_ext.dart';

import '../covert/convertExpression.dart';
import '../declaration/ClassDeclarationData.dart';
import 'ClassDeclarationVisitor.dart';
import '../declaration/FieldDeclarationData.dart';
import '../declaration/MethodDeclarationData.dart';
import '../utils/const.dart';
import 'package:path/path.dart' as p;

import 'PartJsCodeGenerator.dart';

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

  void goThroughMembers(
      ClassDeclaration node, ClassDeclarationData tempClassDeclaration) {
    node.members.forEach((element) {
      if (element is FieldDeclaration) {
        var fieldDeclaration =
            element.fields.variables.first.toString().split('=');
        var hasFairPropsAttribute = element.metadata
            .any((elem) => elem.name.toString() == FairPropsAttribute);
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
        if (!excludeMethods.contains(element.name.toString()) &&
            element.returnType.toString() != 'Widget') {
          tempClassDeclaration.methods.add(MethodDeclarationData(
              element.name.toString(),
              element.toString(),
              element.body is ExpressionFunctionBody)
            ..isStatic = element.isStatic);
        }
        // }
      }
    });
  }

  String findCreateStateReturn(FunctionBody body) {
    if (body is BlockFunctionBody) {
      ReturnStatement? returnStatement = body.block.statements
          .singleWhereOrNull((element) => element is ReturnStatement,
              orElse: () => null) as ReturnStatement?;
      assert(returnStatement != null,
          'too complicated createState implementation');
      assert(returnStatement?.expression is MethodInvocation,
          'too complicated return expression in method createState');
      return (returnStatement?.expression as MethodInvocation).methodName.name;
    } else if (body is ExpressionFunctionBody) {
      assert(body.expression is MethodInvocation,
          'too complicated return expression in method createState');
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
    if (node.extendsClause != null &&
        stateExp
            .allMatches(node.extendsClause!.superclass.toString())
            .isNotEmpty) {
      allStates.add(tempClassDeclaration);
      if (classDeclarationData.className != null &&
          classDeclarationData.className == tempClassDeclaration.className) {
        classDeclarationData = tempClassDeclaration;
      }
    } else if (node.extendsClause == null ||
        node.extendsClause!.superclass.toString() == 'Object') {
      allInnerDataClasses.add(tempClassDeclaration);
    }
    var fairPatchAttributeName = 'FairPatch';
    const statefulWidgetClassName = 'StatefulWidget';
    const statelessWidgetClassName = 'StatelessWidget';
    if (node.metadata.isNotEmpty &&
        node.metadata
            .any((item) => item.name.toString() == fairPatchAttributeName)) {
      if (node.extendsClause != null) {
        switch (node.extendsClause!.superclass.toString()) {
          case statefulWidgetClassName:
            var member = node.members.firstWhereOrNull(
                (element) =>
                    element is MethodDeclaration &&
                    element.name.toString() == 'createState',
                orElse: () => null);
            if (member != null) {
              var expectedStateClassName =
                  ((member as MethodDeclaration).returnType as TypeName)
                      .name
                      .name;
              if (expectedStateClassName == 'State') {
                expectedStateClassName = findCreateStateReturn(member.body);
              }
              var data = allStates.firstWhere(
                  (element) => element?.className == expectedStateClassName,
                  orElse: () => null);
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

  void generateDependencies(String refererPath,
      List<Tuple<String, bool, String>> imports, List<String> result) {
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
        selfDependencySequences =
            reserveSequence(partJsGenerator.importLocalFiles.length, true);
        var index1 = 0;
        partJsGenerator.importLocalFiles.forEach((element) {
          var tempDependencyPath = resolvePath(p.dirname(absPath), element.k1);
          if (dependencyCache.containsKey(tempDependencyPath)) {
            selfDependencySequences[index1] =
                dependencyCache[tempDependencyPath].toString();
          }
          if (element.k3 != null && element.k3!.isNotEmpty) {
            selfDependencySequences[index1] =
                '[${selfDependencySequences[index1]},\'${element.k3}\']';
          }
          index1++;
        });
      }
      var classDeclarationVisitor1 =
          ClassDeclarationVisitor(element.k2 ?? false);
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
    var result = new List<int>.generate(num, (index) => moduleSequence + index)
        .map((item) => item.toString())
        .toList();
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
        dependencySequences =
            reserveSequence(partJsGenerator.importLocalFiles.length, true);
        var index = 0;
        partJsGenerator.importLocalFiles.forEach((element) {
          if (element.k3 != null && element.k3!.isNotEmpty) {
            dependencySequences[index] =
                '[${dependencySequences[index]},\'${element.k3}\']';
          }
          index++;
        });
        generateDependencies(
            baseFilePath, partJsGenerator.importLocalFiles, dependencyClasses);
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
