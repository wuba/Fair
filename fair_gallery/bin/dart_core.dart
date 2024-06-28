// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, avoid_print

import 'dart:io';
import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;

import 'util/utils.dart';

DartFormatter _dartFormatter = DartFormatter();

/// build dart core sugar
Future<void> main(List<String> args) async {
  Directory projectDirectory = getProjectDirectory(pubGet: false);

  final File dartRunFile = File(Platform.executable);
  var cacheDirectory = dartRunFile.parent;
  while (!cacheDirectory.path.endsWith('cache')) {
    cacheDirectory = cacheDirectory.parent;
  }

  final File file = File(path.join(
    projectDirectory.path,
    'lib',
    'src',
    'sugar',
    'dart_core.dart',
  ));
  if (!file.existsSync()) {
    file.createSync(recursive: true);
  }

  final AnalysisContextCollection collection =
      AnalysisContextCollection(includedPaths: <String>[
    path.join(cacheDirectory.path, 'pkg', 'sky_engine', 'lib', 'core'),
  ]);
  final List<String> imports = <String>[
    'import \'dart:math\';',
  ];

  final List<String> dartCore = <String>[
    'String',
    'int',
    'double',
    'bool',
    'num',
    'List',
    'Map',
    'Iterable',
  ];

  final Map<String, Map> operators = <String, Map>{
    'bool': {
      '&': 'and',
      '|': 'inclusiveOr',
      '^': 'exclusiveOr',
    },
    'double': {
      '+': 'adds',
      '-': 'subtracts',
      '*': 'multiplies',
      '%': 'euclideanModulo',
      '/': 'divides',
      '~/': 'truncatingDivision',
    },
    'int': {
      '&': 'and',
      '|': 'or',
      '^': 'exclusiveOr',
      '~': 'negate',
      '<<': 'leftShift',
      '>>': 'rightShift',
      '>>>': 'unsignedRightShift',
      '-': 'negative'
    },
    'List': {
      '[]': 'get',
      '[]=': 'set',
      '+': 'adds',
      '==': 'equalTo',
    },
    'num': {
      '==': 'equalTo',
      '+': 'adds',
      '-': 'subtracts',
      '*': 'multiplies',
      '%': 'euclideanModulo',
      '/': 'divides',
      '~/': 'truncatingDivision',
      '<': 'smallerThan',
      '<=': 'smallerThanOrEqualTo',
      '>': 'greaterThan',
      '>=': 'greaterThanOrEqualTo'
    },
    'String': {
      '[]': 'getChar',
      '==': 'equalTo',
      '+': 'concatenates',
      '*': 'multipliedConcatenates',
    },
    'Map': {
      '[]': 'get',
      '[]=': 'set',
    }
  };

  final Map<String, String> classes = <String, String>{};

  for (final AnalysisContext context in collection.contexts) {
    for (final path in context.contextRoot.analyzedFiles()) {
      if (path.endsWith('.dart')) {
        final ResolvedUnitResult result = await context.currentSession
            .getResolvedUnit(path) as ResolvedUnitResult;

        for (final element in result.libraryElement.topLevelElements) {
          if (element.isPublic) {
            final List<String> methods = <String>[];
            final printOperators = {};
            if (element is ClassElement && dartCore.contains(element.name)) {
              if (classes.containsKey(element.name)) {
                continue;
              }

              if (element.name == 'bool') {
                methods.add('''
// !input
static bool invert(bool input) => !input;
''');
              }

              if (element.name == 'List') {
                for (var element in element.constructors) {
                  if (element.name == '') {
                    continue;
                  }
                  var fullString =
                      element.getDisplayString(withNullability: true);
                  fullString = fullString.replaceFirst('List.', '');
                  String parameters = '';
                  for (final ParameterElement parameter in element.parameters) {
                    // the getters isOptionalNamed, isOptionalPositional, '
                    // 'isRequiredNamed, and isRequiredPositional

                    if (parameter.isNamed ||
                        parameter.isOptionalNamed ||
                        parameter.isRequiredNamed) {
                      parameters += '${parameter.name}: ${parameter.name},';
                    } else {
                      parameters += '${parameter.name},';
                    }
                  }
                  var method =
                      'static $fullString => List.${element.name}($parameters);';
                  method = method
                      .replaceAll('E?', 'dynamic')
                      .replaceAll('E', 'dynamic');
                  methods.add('${element.documentationComment ?? ''}\n$method');
                }
              }

              for (final accessor in element.accessors) {
                if (accessor.name == 'hashCode') {
                  continue;
                }
                var method = '';
                if (accessor.isStatic) {
                  method =
                      'static ${accessor.returnType.getDisplayString(withNullability: true)} ${accessor.displayName}()=> ${element.name}.${accessor.displayName};';
                } else if (accessor.isGetter) {
                  method =
                      'static ${accessor.returnType.getDisplayString(withNullability: true)} ${accessor.displayName}(${element.name} input)=> input.${accessor.displayName};';
                }

                if (method.isNotEmpty) {
                  if (element.name == 'List') {
                    method = method.replaceAll('E', 'dynamic');
                  } else if (element.name == 'Iterable') {
                    method = method.replaceAll(' E ', ' dynamic ');

                    method = method.replaceAll('<E>', '<dynamic>');
                    method =
                        method.replaceAll('Function(E)', 'Function(dynamic)');
                    method = method.replaceAll(
                        'E Function(E)', 'dynamic Function(dynamic)');
                    method = method.replaceAll('E Function(E, E)',
                        'dynamic Function(dynamic,dynamic)');
                    method = method.replaceAll(', E)', ', dynamic)');
                    method = method.replaceAll('{E', '{dynamic');
                  } else if (element.name == 'Map') {
                    method = method
                        .replaceAll('V2', 'dynamic')
                        .replaceAll('K2', 'dynamic')
                        .replaceAll('V', 'dynamic')
                        .replaceAll('K', 'dynamic');
                  }
                  methods
                      .add('${accessor.documentationComment ?? ''}\n$method');
                }
              }
              for (final methodElement in element.methods) {
                // if (methodElement.returnType.isVoid) {
                //   continue;
                // }
                String parameters = '';
                for (final ParameterElement parameter
                    in methodElement.parameters) {
                  // the getters isOptionalNamed, isOptionalPositional, '
                  // 'isRequiredNamed, and isRequiredPositional

                  if (parameter.isNamed ||
                      parameter.isOptionalNamed ||
                      parameter.isRequiredNamed) {
                    parameters += '${parameter.name}: ${parameter.name},';
                  } else {
                    parameters += '${parameter.name},';
                  }
                }

                var fullString = '$methodElement';

                final methodName = methodElement.displayName;
                var method = '';
                if (methodElement.isStatic) {
                  method =
                      'static $fullString => ${element.name}.$methodName($parameters);';
                } else {
                  var oldMethod = 'input.$methodName($parameters)';
                  var newMethodName = methodName;
                  if (methodName == 'toString') {
                    newMethodName =
                        '${element.name[0].toLowerCase()}${element.name.substring(1)}ToString()';
                    fullString = fullString.replaceAll(
                      'toString()',
                      newMethodName,
                    );
                  } else if (methodElement.isOperator) {
                    var operatorMethodName =
                        operators[element.name]?[methodName]?.toString();

                    if (operatorMethodName != null &&
                        operatorMethodName.isNotEmpty) {
                      parameters = parameters.replaceAll(',', '');
                      if (methodName == '[]') {
                        oldMethod = 'input[$parameters]';
                      }
                      //   void operator []=(K key, V value);
                      else if (methodName == '[]=') {
                        if (element.name == 'Map') {
                          oldMethod = 'input[key]=value';
                        } else if (element.name == 'List') {
                          oldMethod = 'input[index]=value';
                        }
                      }
                      // num operator -();
                      else if (methodName == '-' && parameters.isEmpty) {
                        oldMethod = '-input';
                        operatorMethodName = 'negation';
                      } else if (parameters.isEmpty) {
                        oldMethod = '${methodName}input';
                      } else if (element.name == 'bool') {
                        if (methodName == '&') {
                          methods.add(
                              '${methodElement.documentationComment ?? ''}\n static bool and(bool input, bool Function() other) => input & other();');
                          continue;
                        } else if (methodName == '|') {
                          methods.add(
                              '${methodElement.documentationComment ?? ''}\n static bool inclusiveOr(bool input, bool Function() other) => input | other();');
                          continue;
                        }
                        oldMethod = 'input $methodName $parameters';
                      } else {
                        oldMethod = 'input $methodName $parameters';
                      }
                      newMethodName = operatorMethodName;
                      fullString = fullString.replaceAll(
                        methodName,
                        newMethodName,
                      );
                    } else {
                      continue;
                    }
                  }

                  method = '''
                         static ${fullString.replaceFirst('(', '(${element.name} input,', fullString.indexOf(newMethodName))}=> $oldMethod;
                          ''';
                }
                // else if (methodElement.isOperator) {
                //   printOperators['\'${methodElement.displayName}\''] = '\'\'';
                // }
                if (method.isNotEmpty) {
                  if (element.name == 'List') {
                    method = method
                        .replaceAll('E?', 'dynamic')
                        .replaceAll('E', 'dynamic');
                  } else if (element.name == 'Iterable') {
                    method = method.replaceAll(' E ', ' dynamic ');
                    method = method.replaceAll('<E>', '<dynamic>');
                    method =
                        method.replaceAll('Function(E)', 'Function(dynamic)');
                    method = method.replaceAll(
                        'E Function(E)', 'dynamic Function(dynamic)');
                    method = method.replaceAll('E Function(E, E)',
                        'dynamic Function(dynamic,dynamic)');
                    method = method.replaceAll(', E)', ', dynamic)');
                    method = method.replaceAll('{E', '{dynamic');
                  } else if (element.name == 'Map') {
                    if (methodName == 'cast' ||
                        methodName == 'castFrom' ||
                        methodName == 'map') {
                      continue;
                    } else if (methodName != 'containsKey' &&
                        methodName != 'containsValue') {
                      method = method
                          .replaceAll('V?', 'dynamic')
                          .replaceAll('V2', 'dynamic')
                          .replaceAll('K2', 'dynamic')
                          .replaceAll('V', 'dynamic')
                          .replaceAll('K', 'dynamic');
                    }
                  }

                  methods.add(
                      '${methodElement.documentationComment ?? ''}\n$method');
                }
              }
              if (methods.isNotEmpty) {
                final name =
                    element.name[0].toUpperCase() + element.name.substring(1);
                classes[element.name] = _template
                    .replaceAll('{0}', name)
                    .replaceAll('{1}', methods.join('\n'));
              }
              if (printOperators.isNotEmpty) {
                print({'\'${element.name}\'': '$printOperators'});
              }
            } else if (element is FunctionElement) {}
          }
        }
      }
    }
  }

  var out = '''// ignore_for_file: deprecated_member_use, prefer_single_quotes\n
      ${imports.join('\n')}\n 
      ${classes.values.join('\n')}''';
  out = _dartFormatter.format(out);
  file.writeAsStringSync(out);
}

String _template = '''
/// {0} Sugar
class Sugar{0} {
  Sugar{0}._();

  {1}
}
''';
