import 'dart:io';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;
import 'package:analyzer/dart/element/type.dart';

DartFormatter _dartFormatter = DartFormatter();
void createFunctionDomain({
  required Directory projectDirectory,
  required Map<String, FunctionType> functions,
  required String fileName,
  required String imports,
  required Map<String, String> fixes,
  // FunctionType 的 fullElement
  required Set<String> skips,
  required dynamic flutterVersion,
}) {
  if (functions.isNotEmpty) {
    StringBuffer sb = StringBuffer();
    var keys = functions.keys.toSet().toList();
    keys.sort();
    for (var key in keys) {
      var functionType = functions[key]!;
      var fullElement = functionType.alias?.element.toString();
      if (skips.contains(fullElement)) {
        continue;
      }

      String returnType = key;
      var callbackT = '';
      if (key ==
          'PageRoute<T> Function<T>(RouteSettings, Widget Function(BuildContext))') {
        callbackT = '<T>';
      } else if (key == 'List<PopupMenuEntry<T>> Function(BuildContext)') {
        returnType = 'List<PopupMenuEntry<dynamic>> Function(BuildContext)';
      } else if (returnType.contains('(T)') || returnType.contains('<T>')) {
        returnType = returnType
            .replaceAll('(T)', '(Object)')
            .replaceAll('<T>', '<Object>');
      } else if (returnType.contains('(T?)') || returnType.contains('<T?>')) {
        returnType = returnType
            .replaceAll('(T?)', '(dynamic)')
            .replaceAll('<T?>', '<dynamic>');
      } else if (returnType == 'Widget Function(BuildContext, T, Widget?)') {
        returnType = 'Widget Function(BuildContext, dynamic, Widget?)';
      } else if (fixes.isNotEmpty) {
        for (var key in fixes.keys) {
          if (returnType == key) {
            returnType = fixes[key]!;
            break;
          }
        }
      }

      if (returnType.startsWith('T ')) {
        returnType = returnType.replaceFirst('T ', 'dynamic ');
      } else if (returnType.startsWith('T? ')) {
        returnType = returnType.replaceFirst('T? ', 'dynamic ');
      }

      key = returnType;
      if (returnType ==
          'List<PopupMenuEntry<dynamic>> Function(BuildContext)') {
        returnType = 'List<PopupMenuEntry<Object>> Function(BuildContext)';
      }

      String template = _functionTemplate.replaceAll('{0}', key);
      template = template.replaceAll('{4}', returnType);
      template = template.replaceAll('{7}', callbackT);

      var uri = functionType.alias?.element.source.uri.toString();
      if (uri != null && uri.contains('.dart_tool')) {
        uri = uri.substring(uri.indexOf('.dart_tool') + 2);
      }

      template = template.replaceAll(
          '{5}', fullElement != null ? '// $fullElement' : '');
      template = template.replaceAll('{6}', uri != null ? '// $uri' : '');

      List<String> functionDomain = <String>[];

      List<String> optionalPositional = <String>[];
      List<String> requiredPositional = <String>[];
      List<String> named = <String>[];
      for (var i = 0; i < functionType.parameters.length; i++) {
        var element = functionType.parameters[i];
        var name = element.name;
        if (element.isNamed) {
          var type = element.type.getDisplayString(withNullability: true);
          if (!element.isRequired && !type.endsWith('?')) {
            type += '?';
          }
          var display = '$type $name';
          if (element.isRequired) {
            display = 'required $display';
          }
          named.add(display);
          functionDomain.add('\'$name\': $name');
        } else if (element.isRequiredPositional) {
          requiredPositional.add('p$i');
          functionDomain.add('functionPaParameters[$i]:p$i');
        } else if (element.isOptionalPositional) {
          optionalPositional.add('p$i');
          functionDomain.add(
              'if(i< functionPaParameters.length) functionPaParameters[$i]:p$i');
        } else {
          assert(false, '不支持');
        }
      }

      String input = '';

      if (requiredPositional.isNotEmpty) {
        input += requiredPositional.join(',');
        if (optionalPositional.isNotEmpty || named.isNotEmpty) {
          input += ',';
        }
      }

      if (optionalPositional.isNotEmpty) {
        input += '[${optionalPositional.join(',')}]';
      } else if (named.isNotEmpty) {
        input += '{${named.join(',')}}';
      }

      template = template
          .replaceAll(
              '{3}',
              optionalPositional.isEmpty && requiredPositional.isEmpty
                  ? ''
                  : 'List functionPaParameters = FunctionDomain.pa(map);')
          .replaceAll(
              '{2}',
              functionDomain.isEmpty
                  ? 'domain'
                  : '''
             FunctionDomain(
                {
                  ${functionDomain.join(',')}
                },
                parent: domain,
              )
''')
          .replaceAll('{1}', input);
      sb.write(template);
    }

    var fileContent = _template1
        .replaceAll('{0}', sb.toString())
        .replaceAll('{1}', fileName)
        .replaceAll(
          '{2}',
          imports,
        )
        .replaceAll(
          '{3}',
          '${functions.length}',
        )
        .replaceAll(
          '{4}',
          flutterVersion['frameworkVersion'],
        )
        .replaceAll(
          '{5}',
          flutterVersion['dartSdkVersion'],
        );
    fileContent = _dartFormatter.format(fileContent);
    final File file = File(path.join(projectDirectory.path, 'lib', 'src',
        'generated_module', '${fileName.toLowerCase()}.function.dart'));

    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(fileContent);
  }
}

String _template1 = '''
// flutterVersion = '{4}'
// dartVersion = '{5}'
// functionCount = {3}
// ignore_for_file: deprecated_member_use, prefer_single_quotes, unused_element, unused_field, unused_import, unnecessary_import, implementation_imports, unused_shown_name, prefer_function_declarations_over_variables, void_checks, duplicate_import, no_duplicate_case_values
{2}
import 'package:fair/fair.dart';

/// {1}FunctionDynamicWidgetBuilder
mixin {1}FunctionDynamicWidgetBuilder on DynamicWidgetBuilder {

  dynamic convert{1}Function(BuildContext context, Map map, Map? methodMap,
      {Domain? domain}) {
    var name = map[tag];
    if (name == 'FairFunction') {
      var tag = FunctionDomain.getTag(map);
      switch (tag) {
        {0}
        default:
      }
    }
    return null;
  }
}

''';

String _functionTemplate = '''
        {5}
        {6}
        case '{0}':
          {3}
          {4} builder = {7}({1}) {
            return pa0Value(
              FunctionDomain.getBody(map), 
              methodMap,
              context,
              {2},
            );
          };
          return builder;
''';
