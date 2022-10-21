import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'SimpleFunctionGenerator.dart';
import '../covert/convertExpression.dart';
import '../declaration/ClassDeclarationData.dart';
import '../declaration/FieldDeclarationData.dart';
import '../declaration/MethodDeclarationData.dart';
import '../utils/const.dart';
import 'UniqueNameGenerator.dart';

class ClassDeclarationVisitor
    extends RecursiveAstVisitor<ClassDeclarationVisitor> {
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
      classDeclarationData.parentClass =
          node.extendsClause!.superclass.toString();
    }
    node.members.forEach((element) {
      if (element is FieldDeclaration) {
        var fieldDeclaration =
            element.fields.variables.first.toString().split('=');
        classDeclarationData.fields.add(FieldDeclarationData(
            fieldDeclaration[0].trim(),
            fieldDeclaration.length == 2
                ? convertExpression(fieldDeclaration[1].trim())
                : null)
          ..isStatic = element.isStatic);
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
              element.name.name,
              '${element.returnType.toString()} ${element.name.name}${element.parameters.toString()}${element.body.toString()}',
              element.body is ExpressionFunctionBody)
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
        constructorBody =
            '$constructorAlias${element.parameters.toString()}$constructorBody';
        var methodDeclaration = MethodDeclarationData(
            element.name?.name ?? constructorAlias,
            constructorBody,
            element.body is ExpressionFunctionBody);
        if (element.factoryKeyword?.stringValue == 'factory') {
          methodDeclaration.isFactory = true;
          methodDeclaration.name = (element.name == null)
              ? factoryConstructorAlias
              : element.name!.name;
        } else {
          methodDeclaration.isGenerativeConstructor = element.name != null;
        }
        element.parameters.parameters.forEach((element) {
          if (element is FieldFormalParameter) {
            var newParamName = UniqueNameGenerator().next();
            methodDeclaration
              ..renamedParameters[idx] = newParamName
              ..abtractedInitializer
                  .add('${element.toString()} = $newParamName;');
          } else if (element is DefaultFormalParameter) {
            if (element.parameter is FieldFormalParameter) {
              var newParamName = element.parameter.identifier.toString();
              methodDeclaration
                ..renamedParameters[idx] = newParamName
                ..abtractedInitializer
                    .add('${element.parameter.toString()} = $newParamName;');
            }
          }
          idx++;
        });
        var callSuperConstructorImplicitly = false;
        element.initializers.forEach((initializer) {
          if (initializer is SuperConstructorInvocation) {
            callSuperConstructorImplicitly = true;
            var params = initializer.argumentList.arguments
                .map((e) => e.toString())
                .join(',');
            methodDeclaration.abtractedInitializer.add(
                '${classDeclarationData.parentClass}.prototype.$constructorAlias.call($thisAlias${params.isEmpty ? '' : ',$params'});');
          } else if (initializer is ConstructorFieldInitializer) {
            methodDeclaration.abtractedInitializer.add(
                'this.${initializer.fieldName} = ${convertExpression(initializer.expression.toString())};');
          } else if (initializer is RedirectingConstructorInvocation) {
            var params = initializer.argumentList.arguments
                .map((e) => convertExpression(e.toString()))
                .join(',');
            methodDeclaration.abtractedInitializer
                .add('return new ${element.returnType.name}($params);');
            methodDeclaration.isRedirectConstructor = true;
          } else {
            throw 'Unhandled constructor element ${element.toString()}';
          }
        });
        if (!callSuperConstructorImplicitly &&
            !methodDeclaration.isRedirectConstructor &&
            !methodDeclaration.isFactory) {
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
    var result = parseFile(
        path: file.absolute.uri.normalizePath().path,
        featureSet: FeatureSet.fromEnableFlags([]));
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
