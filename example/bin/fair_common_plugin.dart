// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'dart:io';
import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;

import 'util/utils.dart';

DartFormatter _dartFormatter = DartFormatter();

Future<void> main(List<String> args) async {
  Directory projectDirectory = getProjectDirectory(pubGet: false);

  File pluginFile = File(path.join(
    projectDirectory.path,
    'lib',
    'src',
    'plugin',
    'fair_common_plugin.dart',
  ));

  if (!pluginFile.existsSync()) {
    pluginFile.createSync(recursive: true);
  }

  File jsFile = File(path.join(
    projectDirectory.path,
    'assets',
    'plugin',
    'fair_common_plugin.js',
  ));

  if (!jsFile.existsSync()) {
    jsFile.createSync(recursive: true);
  }

  final AnalysisContextCollection collection =
      AnalysisContextCollection(includedPaths: <String>[
    pluginFile.parent.path,
  ]);
  List<String> classNames = <String>['CompleterPlugin'];
  List<String> imports = <String>[];
  List<String> methods = <String>['futureComplete'];
  for (final AnalysisContext context in collection.contexts) {
    for (final file in context.contextRoot.analyzedFiles()) {
      if (file.endsWith('.dart') && file != pluginFile.path) {
        final ResolvedUnitResult result = await context.currentSession
            .getResolvedUnit(file) as ResolvedUnitResult;
        var unit = result.unit;
        for (var element in unit.declarations) {
          if (element is MixinDeclaration) {
            var isFairCommonPluginMixin = element.implementsClause?.interfaces
                    .any((element) =>
                        element.name.name == 'FairCommonPluginMixin') ??
                false;
            if (isFairCommonPluginMixin) {
              classNames.add(element.name.lexeme);
              var import = path.relative(file, from: pluginFile.parent.path);

              imports.add('import \'$import\';');
              for (var member in element.members) {
                if (member is MethodDeclaration &&
                    (member.declaredElement?.isPublic ?? false)) {
                  assert(!methods.contains(member.name.lexeme), '有相同的方法名');
                  methods.add(member.name.lexeme);
                }
              }
            }
          }
        }
      }
    }
  }

  if (methods.isNotEmpty) {
    jsFile.writeAsStringSync(jsFileTemplate.replaceAll(
      '{0}',
      methods.map((e) => jsFileItemTemplate.replaceAll('{0}', e)).join(',\n'),
    ));

    pluginFile.writeAsStringSync(
      _dartFormatter.format(
        dartFileTemplate
            .replaceAll('{0}', imports.join('\n'))
            .replaceAll('{1}', classNames.join(','))
            .replaceAll('{2}', methods.map((e) => '\'$e\':$e,').join('\n')),
      ),
    );
  }
}

String dartFileTemplate = '''
// 由 bin/fair_common_plugin.dart 生成
import 'package:fair/fair.dart';
{0}
/// 跟 js 交互的方法类
class FairCommonPlugin extends IFairPlugin
    with
         {1} {
  factory FairCommonPlugin() => _fairCommonPlugin;
  FairCommonPlugin._();
  static final FairCommonPlugin _fairCommonPlugin = FairCommonPlugin._();
  @override
  Map<String, Function> getRegisterMethods() {
    return <String, Function>{
      {2}
    };
  }
}
''';

String jsFileTemplate = '''
// 由 bin/fair_common_plugin.dart 生成
let FairCommonPlugin = function () {
    return {
{0}                     
    }
}
''';

String jsFileItemTemplate = '''
        {0}: function (resp) {
             fairCommonPluginRequest(resp, '{0}');
        }''';
