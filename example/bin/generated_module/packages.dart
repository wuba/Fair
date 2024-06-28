// ignore_for_file: avoid_print

import 'dart:io';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as path;
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import '../util/binding.dart';
import '../util/utils.dart';

// import 'package:flutter/widgets.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/semantics.dart';
// import 'package:flutter/animation.dart';
Set<String> _imports = <String>{
  // 'import \'package:extended_text_library/extended_text_library.dart\' as extended_text_library;',
  // 'import \'package:oktoast/src/core/toast.dart\';',
};

String _codes = '''
int _kDefaultSemanticIndexCallback(Widget _, int localIndex) => localIndex;
Widget _defaultBuildAnimation(
  BuildContext context,
  Widget child,
  AnimationController controller,
  double percent,
) {
  return Opacity(opacity: percent, child: child);
}

const Duration _defaultDuration = Duration(milliseconds: 2300);
const Duration _defaultAnimDuration = Duration(milliseconds: 250);
const Color _defaultBackgroundColor = Color(0xDD000000);
''';

Map<String, String> _fixes = <String, String>{
  '\'SelectionOverlay\': (props) => SelectionOverlay(':
      '\'SelectionOverlay\': (props) => extended_text_library.SelectionOverlay(',
  '\'SelectionOverlay.fadeDuration\': SelectionOverlay.fadeDuration,':
      '\'SelectionOverlay.fadeDuration\': extended_text_library.SelectionOverlay.fadeDuration,'
};

void main(List<String> args) async {
  Directory projectDirectory = getProjectDirectory();
  final File file = File(path.join(
      projectDirectory.path, 'bin', 'generated_module', 'binding.dart'));
  assert(file.existsSync());

  final result = parseFile(
    path: file.path,
    featureSet: FeatureSet.latestLanguageVersion(),
  );
  var packageConfig = await findPackageConfig(projectDirectory);
  if (packageConfig == null) {
    return;
  }
  List<String> includedPaths = <String>[];
  for (var child in result.unit.directives) {
    if (child is ImportDirective) {
      var uriString = child.uri.toString();
      // 去掉引号
      uriString = uriString.substring(1, uriString.length - 1);
      assert(uriString.startsWith('package:'));
      var resolve = packageConfig.resolve(Uri.parse(uriString));

      if (!resolve!
          .toFilePath(windows: Platform.isWindows)
          .startsWith(projectDirectory.path)) {
        Uri uri = Uri.parse(uriString);
        var resolve = packageConfig.resolve(Uri.parse(uriString));
        var resolvePackage = packageConfig[uri.path.split('/').first];
        if (resolvePackage != null && resolve != null) {
          _imports.add('import \'$uriString\';');
          await resolveCopyPackage(
            projectDirectory,
            resolvePackage,
            3,
            includedPaths,
            resolve,
            _imports,
          );
        }
      }
    }
  }

  await createBindings(
    projectDirectory: projectDirectory,
    includedPaths: includedPaths,
    fileName: 'Packages',
    imports: _imports.join('\n'),
    componentSkips: {
      'ExtendedNetworkImageProvider.httpClient',
    },
    codes: _codes,
    fixes: _fixes,
    functionDomainImports: _imports.join('\n'),
    functionDomainFixes: {
      'T Function(dynamic)': 'dynamic Function(dynamic)',
      'T Function(T, dynamic)': 'dynamic Function(dynamic, dynamic)',
      'Widget Function(BuildContext, T, int)':
          'Widget Function(BuildContext, dynamic, int)',
      'T Function()': 'dynamic Function()',
    },
    // FunctionType 的 fullElement
    // 有些是不会用的，特别是一些泛型
    functionDomainSkips: {},
  );
  // dartFix();
}
