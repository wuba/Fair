// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'dart:io';
import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;

import 'util/utils.dart';

DartFormatter _dartFormatter = DartFormatter();

Future<void> main(List<String> args) async {
  Directory projectDirectory = getProjectDirectory(pubGet: false);
  final File file = File(path.join(
    projectDirectory.path,
    'lib',
    'src',
    'sugar',
    'extension.dart',
  ));
  if (!file.existsSync()) {
    file.createSync();
  }

  final AnalysisContextCollection collection =
      AnalysisContextCollection(includedPaths: <String>[
    path.join(
      projectDirectory.path,
      'lib',
      'src',
      'extension',
    ),
  ]);
  final List<String> imports = <String>[];

  final List<String> accessibleExtensions = <String>[];

  for (final AnalysisContext context in collection.contexts) {
    for (final path in context.contextRoot.analyzedFiles()) {
      if (path.endsWith('.dart')) {
        final ResolvedUnitResult result = await context.currentSession
            .getResolvedUnit(path) as ResolvedUnitResult;
        // imports.add('import \'${result.uri}\';');
        for (final ExtensionElement accessibleExtension
            in result.libraryElement.accessibleExtensions) {
          // skip dart.core
          if (accessibleExtension.library.location?.encoding !=
              '${result.uri}') {
            continue;
          }

          final List<String> methods = <String>[];
          final extendedType = accessibleExtension.extendedType;
          final name = accessibleExtension.name;
          for (final MethodElement methodElement
              in accessibleExtension.methods) {
            String parameters = '';

            for (final ParameterElement parameter in methodElement.parameters) {
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

            final fullString = '$methodElement';

            final methodName = methodElement.displayName;

            if (methodElement.isStatic) {
              methods.add('''
                ${methodElement.documentationComment ?? ''}
                static $fullString => ${accessibleExtension.name}.$methodName($parameters);
                  ''');
            } else {
              methods.add('''
                ${methodElement.documentationComment ?? ''}
                 static ${fullString.replaceFirst('(', '(${extendedType.getDisplayString(withNullability: true)} input,', fullString.indexOf(methodElement.displayName))}=> input.$methodName($parameters);
                  ''');
            }
          }

          for (final PropertyAccessorElement accessor
              in accessibleExtension.accessors) {
            if (accessor.isStatic) {
              methods.add('''
                ${accessor.documentationComment ?? ''}
                 static ${accessor.returnType.getDisplayString(withNullability: true)} ${accessor.displayName}()=> ${accessibleExtension.name}.${accessor.displayName};
                  ''');
            } else {
              methods.add('''
                ${accessor.documentationComment ?? ''}
                 static ${accessor.returnType.getDisplayString(withNullability: true)} ${accessor.displayName}(${extendedType.getDisplayString(withNullability: true)} input)=> input.${accessor.displayName};
                  ''');
            }
          }
          imports.add('import \'${result.uri}\';');
          accessibleExtensions.add(_template
              .replaceAll('{0}', name!)
              .replaceAll('{1}', methods.join('\n')));
        }
      }
    }
  }
  var out = '''
      ${imports.join('\n')}\n 
      ${accessibleExtensions.join('\n')}''';
  out = _dartFormatter.format(out);
  file.writeAsStringSync(out);
}

String _template = '''
/// {0} Sugar
class Sugar{0}{
  Sugar{0}._();

  {1}
}
''';
